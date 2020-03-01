import 'package:diaporama/utils/secrets.dart';
import 'package:draw/draw.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RedditClientService {
  Reddit _reddit = Reddit.createInstalledFlowInstance(
    clientId: redditSecret,
    userAgent: "diaporama-app",
    redirectUri: Uri.parse("diaporama://cornet.dev"),
  );

  String get authUrl => _reddit.auth.url(['*'], "diaporama").toString();

  void authorizeClient(String authCode) async {
    _reddit.auth.url(['*'], "diaporama-auth").toString();
    await _reddit.auth.authorize(authCode);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("credentials", _reddit.auth.credentials.toJson());
  }

  String getCredentials() {
    return _reddit.auth.credentials.toJson();
  }
}
