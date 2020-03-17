import 'package:diaporama/services/reddit_client_service.dart';
import 'package:draw/draw.dart';
import 'package:flutter/material.dart';

class SubredditsState with ChangeNotifier {
  final RedditClientService redditService;

  SubredditsState({@required this.redditService});

  Future<List<String>> searchSubreddit(String query) async {
    List<SubredditRef> subs =
        await redditService.reddit.subreddits.searchByName(query);
    List<String> subsNames = subs.map((s) => s.displayName).toList();
    return subsNames;
  }
}
