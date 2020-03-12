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

  List<ContentSource> contentSources = [
    ContentSource(label: "Front Page", name: "frontpage"),
    ContentSource(label: "Popular", name: "popular"),
    ContentSource(label: "ImGoingToHellForThis", name: "imgoingtohellforthis"),
  ];

  List<Submission> get contents => List.from(_contents);
  bool get isLoading => _isLoading;

  void loadPosts() {
    setBusy();
    streamController = StreamController.broadcast();
    _contents.clear();

    streamController.stream.listen((post) {
      _contents.add(post);
    }, onDone: () {
      setBusy(value: false);
    });

    redditService.reddit.front.hot().pipe(streamController);
  }

  void setBusy({bool value = true}) {
    _isLoading = value;
    notifyListeners();
  }

  @override
  void dispose() {
    streamController.close();
    super.dispose();
  }
}
