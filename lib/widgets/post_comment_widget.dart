import 'package:diaporama/utils/colors.dart';
import 'package:draw/draw.dart';
import 'package:flutter/material.dart';

class PostCommentWidget extends StatelessWidget {
  final dynamic comment;
  final int level;

  const PostCommentWidget({Key key, this.comment, this.level})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget widget;
    final List<Color> commentBorderColor = [
      mediumGreyColor,
      Colors.blue,
      Colors.red,
      Colors.orange,
      Colors.yellow,
      Colors.green,
    ];
    if (comment is Comment) {
      widget = Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(
                  width: 4.0,
                  color: level < commentBorderColor.length
                      ? commentBorderColor[level]
                      : Colors.grey,
                ),
              ),
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 6.0,
                      top: 4.0,
                      bottom: 4.0,
                    ),
                    child: Text(comment.body),
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: darkGreyColor,
            height: 0.5,
            width: double.maxFinite,
          ),
          if (comment.replies != null)
            for (dynamic comment in comment.replies.comments)
              if (comment is Comment)
                PostCommentWidget(
                  comment: comment,
                  level: level + 1,
                )
        ],
      );
    } else {
      return Container(child: Text("More Comments"));
    }

    return Container(
      padding: EdgeInsets.only(
        left: level > 0 ? 4.0 : 0.0,
      ),
      child: widget,
    );
  }
}
