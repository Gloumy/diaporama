import 'package:diaporama/services/reddit_client_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GlobalState with ChangeNotifier {
  bool _openFirstTimeModal = false;
  String _authCode;

  bool get openFirstTimeModal => _openFirstTimeModal;
  String get authCode => _authCode;
  bool get hasAuthCode => _authCode != null;
  String get authUrl => _redditClientService.authUrl;

  RedditClientService _redditClientService = RedditClientService();

  Future<void> initApp({
    String authCode,
  }) async {
    if (authCode != null) {
      _authCode = authCode;
      _redditClientService.authorizeClient(authCode);
      await storeAuthCode();
    } else {
      await checkAuthCode();
    }

    notifyListeners();
  }

  Future<void> checkAuthCode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("authCode")) {
      _authCode = prefs.getString("authCode");
      notifyListeners();
    }
  }

  Future<void> storeAuthCode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("authCode", _authCode);
  }
}
