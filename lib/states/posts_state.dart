import 'package:diaporama/models/post.dart';
import 'package:diaporama/repositories/posts_repository.dart';
import 'package:flutter/material.dart';

class PostsState with ChangeNotifier {
  List<Post> _posts = [];

  List<Post> get posts =>
      List.from(_posts.where((p) => p.domain == "i.redd.it"));

  PostsRepository _postsRepository = PostsRepository();

  Future<void> retrievePosts(String subreddit) async {
    _posts = await _postsRepository.retrievePosts(subreddit);
    notifyListeners();
  }
}
