import 'package:diaporama/utils/colors.dart';
import 'package:draw/draw.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:url_launcher/url_launcher.dart';

class PostCommentBody extends StatelessWidget {
  final Comment comment;

  const PostCommentBody({Key key, this.comment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        //The top row which contains the author, flair and score
        Padding(
          padding: const EdgeInsets.only(
            left: 4.0,
            top: 2.0,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              //The post's author
              Text(
                comment.author,
                style: TextStyle(
                    fontSize: 12.0,
                    color: lightGreyColor,
                    decoration: TextDecoration.underline,
                    decorationColor: redditOrange,
                    fontWeight: FontWeight.bold),
              ),
              //The comment's author's flair text
              Builder(
                builder: (ctx) {
                  if (comment.authorFlairText != null) {
                    return Container(
                      margin: EdgeInsets.only(left: 8.0),
                      child: Container(
                        padding: EdgeInsets.all(3.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                          color: Colors.grey,
                        ),
                        child: Text(
                          comment.authorFlairText,
                          style: TextStyle(
                            fontSize: 8.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Container(width: 0.0, height: 0.0);
                  }
                },
              ),
              //The score of the comment
              Expanded(
                child: Container(
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.only(right: 8.0),
                  child: Text(
                    comment.score.toString(),
                    style: TextStyle(
                      fontSize: 10.0,
                      fontStyle: FontStyle.italic,
                      color: lightGreyColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: darkGreyColor,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                padding: const EdgeInsets.only(
                  left: 6.0,
                  top: 4.0,
                  bottom: 4.0,
                  right: 6.0,
                ),
                margin: const EdgeInsets.only(
                  left: 6.0,
                  top: 4.0,
                  bottom: 4.0,
                  right: 6.0,
                ),
                child: MarkdownBody(
                  data: HtmlUnescape().convert(comment.body),
                  onTapLink: (link) => launch(link),
                  styleSheet: MarkdownStyleSheet.fromTheme(ThemeData(
                    textTheme: TextTheme(
                      body1: TextStyle(
                        fontSize: 12.0,
                        fontFamily: "Raleway",
                        color: lightGreyColor,
                      ),
                    ),
                  )),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
