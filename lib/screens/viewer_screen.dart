import 'package:diaporama/states/posts_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewerScreen extends StatefulWidget {
  @override
  _ViewerScreenState createState() => _ViewerScreenState();
}

class _ViewerScreenState extends State<ViewerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Consumer<PostsState>(
        builder: (context, state, _) {
          return PageView.builder(
              itemCount: state.posts.length,
              itemBuilder: (context, index) => Container(
                    height: double.maxFinite,
                    width: double.maxFinite,
                    child: Image.network(state.posts[index].url),
                  ));
        },
      )),
    );
  }
}
