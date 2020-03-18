import 'dart:async';
import 'package:diaporama/models/content_source.dart';
import 'package:diaporama/services/reddit_client_service.dart';
import 'package:draw/draw.dart';
import 'package:flutter/material.dart';

class PostsState with ChangeNotifier {
  final RedditClientService redditService;

  PostsState({@required this.redditService});

  StreamController<UserContent> streamController;
  List<Submission> _contents = [];
  bool _isLoading = false;
  ContentSource _selectedSource;

  List<Submission> get contents => List.from(_contents);
  bool get isLoading => _isLoading;

  void loadPosts({
    ContentSource source,
    int limit = 20,
    bool loadMore = false,
  }) {
    setBusy();
    source = source ?? _selectedSource;
    streamController = StreamController.broadcast();
    if (!loadMore) _contents.clear();
    _setSelectedSource(source);
    notifyListeners();

    streamController.stream.listen((post) {
      _contents.add(post);
    }, onDone: () {
      setBusy(value: false);
    });

    String after = loadMore ? _contents.last.fullname : null;

    switch (source.subredditsString) {
      case "frontpage":
        redditService.reddit.front
            .hot(
              limit: limit,
              after: after,
            )
            .pipe(streamController);
        break;
      default:
        redditService.reddit
            .subreddit(source.subredditsString)
            .hot(
              limit: limit,
              after: after,
            )
            .pipe(streamController);
        break;
    }
  }

  void setBusy({bool value = true}) {
    _isLoading = value;
    notifyListeners();
  }

  void _setSelectedSource(ContentSource source) {
    _selectedSource = source;
    notifyListeners();
  }

  @override
  void dispose() {
    streamController.close();
    super.dispose();
  }
}
