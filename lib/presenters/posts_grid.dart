import 'package:diaporama/states/posts_state.dart';
import 'package:diaporama/widgets/media_thumbnail.dart';
import 'package:draw/draw.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Consumer<PostsState>(
        builder: (context, state, _) {
          return GridView.builder(
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
            shrinkWrap: true,
            itemCount: state.contents.length,
            itemBuilder: (context, index) {
              Submission post = state.contents[index];
              return post.isSelf
                  ? Text(post.title)
                  : MediaThumbnail(
                      post: post,
                    );
            },
          );
        },
      ),
    );
  }
}
