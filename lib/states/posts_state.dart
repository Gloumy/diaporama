import 'package:diaporama/models/post.dart';
import 'package:diaporama/repositories/posts_repository.dart';
import 'package:diaporama/services/reddit_client_service.dart';
import 'package:flutter/material.dart';

class PostsState with ChangeNotifier {
  final RedditClientService redditService;

  List<Post> _posts = [];

  PostsState({@required this.redditService});

  List<Post> get posts =>
      List.from(_posts.where((p) => p.domain == "i.redd.it"));

  PostsRepository _postsRepository = PostsRepository();

  Future<void> retrievePosts(String subreddit) async {
    _posts = await _postsRepository.retrievePosts(subreddit);
    notifyListeners();
  }
}
