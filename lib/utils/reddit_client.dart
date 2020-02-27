import 'package:diaporama/utils/secrets.dart';
import 'package:draw/draw.dart';

class RedditClient {
  static final RedditClient _singleton = RedditClient._internal();
  static final Reddit reddit = Reddit.createInstalledFlowInstance(
    clientId: redditSecret,
    userAgent: "diaporama-app",
    redirectUri: Uri.parse("diaporama://cornet.dev"),
  );
  static final authUrl = reddit.auth.url(['*'], "diaporama");

  factory RedditClient() {
    return _singleton;
  }

  RedditClient._internal();
}
