import 'package:diaporama/utils/colors.dart';
import 'package:diaporama/widgets/post_comment_widget.dart';
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
    if (_post.comments == null) {
      //Can happen for first post if it hasn't loaded the comments yet
      return FutureBuilder(
          future: initComments(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    for (dynamic topComment in _post.comments.comments)
                      PostCommentWidget(
                        level: 0,
                        comment: topComment,
                      )
                  ],
                );
              } else {
                if (snapshot.hasError) {
                  return Text("Couldn't retrieve comments - ${snapshot.error}");
                }
                return Text(
                  "--- No comments ---",
                  style: TextStyle(
                    color: lightGreyColor,
                  ),
                );
              }
            } else {
              return Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    redditOrange,
                  ),
                  backgroundColor: darkGreyColor,
                ),
              );
            }
          });
    } else if (_post.comments.comments.isNotEmpty) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          for (dynamic topComment in _post.comments.comments)
            PostCommentWidget(
              level: 0,
              comment: topComment,
            )
        ],
      );
    } else {
      return Text(
        "--- No comments ---",
        style: TextStyle(
          color: lightGreyColor,
        ),
      );
    }
  }
}
