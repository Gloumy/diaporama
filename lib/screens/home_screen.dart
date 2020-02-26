import 'package:diaporama/presenters/load_posts_button.dart';
import 'package:diaporama/presenters/posts_grid.dart';
import 'package:diaporama/states/posts_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PostsState>(
      create: (context) => PostsState(),
      child: Scaffold(
        body: SafeArea(
          child: Container(
              child: Column(
            children: <Widget>[
              LoadPostsButton(),
              PostsGrid(),
            ],
          )),
        ),
      ),
    );
  }
}
