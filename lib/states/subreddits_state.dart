import 'package:diaporama/models/content_source.dart';
import 'package:diaporama/services/reddit_client_service.dart';
import 'package:draw/draw.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class SubredditsState with ChangeNotifier {
  final RedditClientService redditService;

  List<ContentSource> _sources = [
    ContentSource(subredditsString: "frontpage", label: "Front Page")
  ];

  List<ContentSource> get contentSources => List.from(_sources);

  SubredditsState({@required this.redditService});

  Future<void> retrieveSources() async {
    var box = Hive.box<ContentSource>("sources");
    box.values.forEach((s) => _sources.add(s));
  }

  Future<List<String>> searchSubreddit(String query) async {
    List<SubredditRef> subs =
        await redditService.reddit.subreddits.searchByName(query);
    List<String> subsNames = subs.map((s) => s.displayName).toList();
    return subsNames;
  }

  Future<void> addSource({
    @required String label,
    @required String subredditsString,
  }) async {
    ContentSource newSource = ContentSource(
      subredditsString: subredditsString,
      label: label,
    );
    var box = Hive.box<ContentSource>("sources");
    await box.add(newSource);
    _sources.add(newSource);

    notifyListeners();
  }
}
