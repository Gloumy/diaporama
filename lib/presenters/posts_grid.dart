import 'package:diaporama/models/post.dart';
import 'package:diaporama/screens/viewer_screen.dart';
import 'package:diaporama/states/posts_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(child: Consumer<PostsState>(
      builder: (context, state, _) {
        return GridView.count(
          shrinkWrap: true,
          crossAxisCount: 3,
          children: <Widget>[
            for (Post post in state.posts)
              GestureDetector(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ViewerScreen())),
                child: Image.network(
                  post.thumbnailUrl,
                  fit: BoxFit.cover,
                ),
              ),
          ],
        );
      },
    ));
  }
}
