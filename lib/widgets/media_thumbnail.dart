import 'package:diaporama/screens/viewer_screen.dart';
import 'package:draw/draw.dart';
import 'package:flutter/material.dart';

class MediaThumbnail extends StatelessWidget {
  final Submission post;

  const MediaThumbnail({Key key, @required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => ViewerScreen())),
      child: Image.network(
        post.thumbnail.toString(),
        fit: BoxFit.cover,
      ),
    );
  }
}
