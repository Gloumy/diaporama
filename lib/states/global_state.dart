import 'package:diaporama/services/reddit_client_service.dart';
import 'package:draw/draw.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GlobalState with ChangeNotifier {
  bool _openFirstTimeModal = false;
  String _credentials;

  bool get openFirstTimeModal => _openFirstTimeModal;
  String get credentials => _credentials;
  bool get hascredentials => _credentials != null;
  String get authUrl => _redditClientService.authUrl;

  RedditClientService _redditClientService = RedditClientService();

  Future<void> initApp({
    String authCode,
  }) async {
    if (authCode != null) {
      _redditClientService.authorizeClient(authCode);
      await storeCredentials();
    } else {
      await checkCredentials();
      if (_credentials != null)
        Reddit.restoreInstalledAuthenticatedInstance(_credentials);
    }

    notifyListeners();
  }

  Future<void> checkCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("credentials")) {
      _credentials = prefs.getString("credentials");
      notifyListeners();
    }
  }

  Future<void> storeCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _credentials = _redditClientService.getCredentials();
    prefs.setString("credentials", _credentials);
  }
}
