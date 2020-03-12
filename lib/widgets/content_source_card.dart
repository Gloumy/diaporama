import 'package:diaporama/models/content_source.dart';
import 'package:diaporama/screens/viewer_screen.dart';
import 'package:diaporama/states/posts_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContentSourceCard extends StatelessWidget {
  final ContentSource source;

  const ContentSourceCard({Key key, this.source}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Provider.of<PostsState>(context, listen: false)
            .loadPosts(source: source);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ViewerScreen(
                      startingIndex: 0,
                    )));
      },
      child: Card(
        child: Center(
          child: Text(
            source.label,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
