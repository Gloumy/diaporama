import 'package:diaporama/states/posts_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoadPostsButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () => Provider.of<PostsState>(context, listen: false)
          .retrievePosts("funny"),
      child: Text("Load"),
    );
  }
}
