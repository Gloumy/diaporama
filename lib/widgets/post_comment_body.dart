import 'package:diaporama/utils/colors.dart';
import 'package:diaporama/utils/custom_markdown_stylesheet.dart';
import 'package:draw/draw.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:provider/provider.dart';
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
                    color: comment.author ==
                            Provider.of<String>(context, listen: false)
                        ? redditOrange
                        : lightGreyColor,
                    decoration: TextDecoration.underline,
                    decorationColor: redditOrange,
                    fontWeight: FontWeight.bold),
              ),
              if (comment.author == Provider.of<String>(context, listen: false))
                Icon(
                  Icons.mic,
                  color: redditOrange,
                  size: 14,
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
                          HtmlUnescape().convert(comment.authorFlairText),
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
                  styleSheet: customMarkdownStyleSheet,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
