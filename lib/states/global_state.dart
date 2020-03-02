import 'package:diaporama/services/reddit_client_service.dart';
import 'package:diaporama/states/posts_state.dart';
import 'package:diaporama/utils/secrets.dart';
import 'package:draw/draw.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class GlobalState with ChangeNotifier {
  bool _openFirstTimeModal = false;
  String _credentials;

  bool get openFirstTimeModal => _openFirstTimeModal;
  bool get hascredentials => _credentials != null;
  String get authUrl => _redditClientService.authUrl;
  PostsState get postsState => _postsState;

  RedditClientService _redditClientService;

  PostsState _postsState;

  Future<void> initApp({
    String authCode,
  }) async {
    if (authCode != null) {
      print("Initialize Installed Client with authCode");
      _redditClientService = RedditClientService.createInstalledFlow(authCode);
      await _redditClientService.authorizeClient(authCode);
    } else {
      await checkCredentials();
      if (_credentials == null) {
        print("Initialize Anonymous Client");
        Reddit reddit = await Reddit.createUntrustedReadOnlyInstance(
          clientId: redditSecret,
          userAgent: "diaporama-app",
          deviceId: Uuid().v4(),
        );
        _redditClientService = RedditClientService(reddit: reddit);
      } else {
        print("Restore Authenticated Instance with credentials");
        _redditClientService =
            RedditClientService.restoreInstalledFlow(_credentials);
      }
    }

    _postsState = PostsState(redditService: _redditClientService);
    _postsState.loadPosts();
    
    notifyListeners();
  }

  Future<void> checkCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("credentials")) {
      _credentials = prefs.getString("credentials");
      notifyListeners();
    }
  }
}
