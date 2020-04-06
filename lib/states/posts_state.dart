import 'dart:async';
import 'package:diaporama/models/content_source.dart';
import 'package:diaporama/services/reddit_client_service.dart';
import 'package:draw/draw.dart';
import 'package:flutter/material.dart';

class PostsState with ChangeNotifier {
  final RedditClientService redditService;

  PostsState({@required this.redditService}) {
    streamController = StreamController.broadcast();

    streamController.stream.listen((post) {
      Submission content = post;
      content.refreshComments(); //load comments directly
      _contents.add(content);
    }, onDone: () {
      setBusy(value: false);
      notifyListeners();
    });
  }

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

    if (!loadMore) _contents.clear();
    _setSelectedSource(source);
    notifyListeners();

    String after = loadMore ? _contents.last.fullname : null;
    Stream<UserContent> stream;
    switch (source.subredditsString) {
      case "frontpage":
        stream = redditService.reddit.front.best(
          limit: limit,
          after: after,
        );
        break;
      default:
        stream = redditService.reddit.subreddit(source.subredditsString).hot(
              limit: limit,
              after: after,
            );
        break;
    }
    streamController.addStream(stream);
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
