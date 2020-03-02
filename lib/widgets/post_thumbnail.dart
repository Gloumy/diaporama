import 'package:diaporama/screens/viewer_screen.dart';
import 'package:draw/draw.dart';
import 'package:flutter/material.dart';

class PostThumbnail extends StatelessWidget {
  final Submission post;
  final int index;

  const PostThumbnail({Key key, this.post, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget child;

    if (post.isSelf || post.preview.isEmpty) {
      child = Center(
        child: Text(post.title),
      );
    } else {
      child = Image.network(
        post.thumbnail.toString(),
        fit: BoxFit.cover,
      );
    }

    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ViewerScreen(
                    startingIndex: index,
                  ))),
      child: child,
    );
  }
}
