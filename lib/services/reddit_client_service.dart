import 'package:diaporama/utils/secrets.dart';
import 'package:draw/draw.dart';

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
    Redditor user = await _reddit.user.me();
    print(user.displayName);
  }

  String getCredentials() {
    return _reddit.auth.credentials.toJson();
  }
}
