import 'package:draw/draw.dart';
import 'package:flutter/material.dart';

class PostCommentsList extends StatefulWidget {
  final Submission post;

  const PostCommentsList({Key key, this.post}) : super(key: key);

  @override
  _PostCommentsListState createState() => _PostCommentsListState();
}

class _PostCommentsListState extends State<PostCommentsList> {
  Submission get _post => widget.post;

  Future<CommentForest> initComments() async {
    CommentForest comments = await _post.refreshComments();
    return comments;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: initComments(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Text(snapshot.data.comments.length.toString());
          } else {
            if (snapshot.hasError) {
              print(snapshot.error);
            }
            return Container(
              height: 0.0,
              width: 0.0,
            );
          }
        });
  }
}
