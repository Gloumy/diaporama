import 'dart:async';
import 'package:diaporama/services/reddit_client_service.dart';
import 'package:draw/draw.dart';
import 'package:flutter/material.dart';

class PostsState with ChangeNotifier {
  final RedditClientService redditService;

  PostsState({@required this.redditService});

  StreamController<UserContent> streamController;
  List<Submission> _contents = [];

  List<Submission> get contents => List.from(_contents);

  void loadPosts() {
    streamController = StreamController.broadcast();
    _contents.clear();

    streamController.stream.listen((post) {
      _contents.add(post);
    }, onDone: () => notifyListeners());

    redditService.reddit.front.hot().pipe(streamController);
  }

  @override
  void dispose() {
    streamController.close();
    super.dispose();
  }
}
