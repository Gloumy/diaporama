import 'package:diaporama/presenters/load_posts_button.dart';
import 'package:diaporama/presenters/posts_grid.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            child: Column(
          children: <Widget>[
            LoadPostsButton(),
            PostsGrid(),
          ],
        )),
      ),
    );
  }
}
