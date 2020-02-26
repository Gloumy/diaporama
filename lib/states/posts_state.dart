import 'package:diaporama/models/post.dart';
import 'package:flutter/material.dart';

class PostsState with ChangeNotifier {
  List<Post> _posts = [];

  List<Post> get posts => List.from(_posts);
}
