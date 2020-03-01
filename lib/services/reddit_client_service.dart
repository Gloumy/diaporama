import 'package:diaporama/utils/secrets.dart';
import 'package:draw/draw.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RedditClientService {
  final Reddit reddit;

  RedditClientService({this.reddit});

  String get authUrl => reddit.auth.url(['*'], "diaporama").toString();
  Redditor get user => _user;

  Redditor _user;

  factory RedditClientService.createInstalledFlow(String authCode) {
    final Reddit reddit = Reddit.createInstalledFlowInstance(
      clientId: redditSecret,
      userAgent: "diaporama-app",
      redirectUri: Uri.parse("diaporama://cornet.dev"),
    );

    return RedditClientService(reddit: reddit);
  }

  factory RedditClientService.restoreInstalledFlow(String credentials) {
    final Reddit reddit = Reddit.restoreInstalledAuthenticatedInstance(
      credentials,
      clientId: redditSecret,
      userAgent: "diaporama-app",
    );

    return RedditClientService(reddit: reddit);
  }

  Future<void> authorizeClient(String authCode) async {
    reddit.auth.url(['*'], "diaporama-auth");
    await reddit.auth.authorize(authCode);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("credentials", reddit.auth.credentials.toJson());
  }

  Future<void> setUser() async {
    _user = await reddit.user.me();
  }

  void getPosts() {
    reddit.front.fetch();
  }
}
