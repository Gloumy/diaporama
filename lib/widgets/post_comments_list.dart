import 'package:diaporama/widgets/comment_widget.dart';
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
            List<Widget> nestedComments = [];
            _getNestedComments(snapshot.data.comments, nestedComments, -1);
            return Column(
              children: List.generate(
                nestedComments.length,
                (index) => nestedComments[index],
              ),
            );
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

  //Thanks @Patte1808 for implementation
  void _getNestedComments(List replies, List widgets, int level) {
    level++;
    replies.forEach((reply) {
      if (reply is Comment) {
        widgets.add(CommentWidget(reply, level));

        if (reply.replies != null) {
          _getNestedComments(reply.replies.comments, widgets, level);
        }
      }
    });
  }
}
