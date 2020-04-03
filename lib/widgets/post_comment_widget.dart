import 'package:diaporama/utils/colors.dart';
import 'package:diaporama/widgets/post_comment_body.dart';
import 'package:draw/draw.dart';
import 'package:flutter/material.dart';

class PostCommentWidget extends StatefulWidget {
  final dynamic comment;
  final int level;

  const PostCommentWidget({Key key, this.comment, this.level})
      : super(key: key);

  @override
  _PostCommentWidgetState createState() => _PostCommentWidgetState();
}

class _PostCommentWidgetState extends State<PostCommentWidget> {
  // dynamic get _comment => widget.comment;
  dynamic _comment;
  int get _level => widget.level;

  final List<Color> commentBorderColor = [
    mediumGreyColor,
    Colors.blue,
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
  ];

  bool _collapseChildren = false;

  @override
  void initState() {
    super.initState();
    _comment = widget.comment;
  }

  @override
  Widget build(BuildContext context) {
    Widget widget;

    if (_comment is Comment) {
      widget = GestureDetector(
        onTap: () {
          setState(() {
            _collapseChildren = !_collapseChildren;
          });
        },
        onDoubleTap: () async {
          if (_comment.vote == VoteState.none) {
            await _comment.upvote(waitForResponse: true);
          } else if (_comment.vote == VoteState.upvoted) {
            await _comment.downvote(waitForResponse: true);
          } else if (_comment.vote == VoteState.downvoted) {
            await _comment.clearVote(waitForResponse: true);
          }
          await _comment.refresh();
          setState(() {
            _comment = _comment;
          });
        },
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(
                    width: 4.0,
                    color: _level < commentBorderColor.length
                        ? commentBorderColor[_level]
                        : Colors.grey,
                  ),
                ),
              ),
              child: Column(
                children: <Widget>[
                  PostCommentBody(
                    comment: _comment,
                  ),
                  if (_collapseChildren)
                    Container(
                      child: Icon(
                        Icons.arrow_drop_down,
                        color: lightGreyColor,
                      ),
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                          color: blueColor,
                          borderRadius: BorderRadius.circular(5)),
                    )
                ],
              ),
            ),
            if (_comment.replies != null && !_collapseChildren)
              for (dynamic comment in _comment.replies.comments)
                if (comment is Comment)
                  PostCommentWidget(
                    comment: comment,
                    level: _level + 1,
                  ),
          ],
        ),
      );
    } else {
      return Container(child: Text("More Comments"));
    }

    return Container(
      padding: EdgeInsets.only(
        left: _level > 0 ? 4.0 : 0.0,
      ),
      child: widget,
    );
  }
}
