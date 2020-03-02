import 'dart:async';

import 'package:diaporama/models/post.dart';
import 'package:diaporama/repositories/posts_repository.dart';
import 'package:diaporama/services/reddit_client_service.dart';
import 'package:draw/draw.dart';
import 'package:flutter/material.dart';

class PostsState with ChangeNotifier {
  final RedditClientService redditService;

  List<Post> _posts = [];

  PostsState({@required this.redditService});

  StreamController<UserContent> streamController;
  List<Submission> _contents = [];

  List<Post> get posts =>
      List.from(_posts.where((p) => p.domain == "i.redd.it"));
  List<Submission> get contents => List.from(_contents);

  PostsRepository _postsRepository = PostsRepository();

  Future<void> retrievePosts(String subreddit) async {
    _posts = await _postsRepository.retrievePosts(subreddit);
    notifyListeners();
  }

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
