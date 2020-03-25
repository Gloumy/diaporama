import 'package:diaporama/utils/colors.dart';
import 'package:draw/draw.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class PostHeader extends StatelessWidget {
  final Submission post;

  const PostHeader({Key key, this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(8.0),
        decoration: const BoxDecoration(
          color: darkGreyColor,
          border: const Border(
            bottom: BorderSide(
              color: redditOrange,
              width: 2,
            ),
          ),
        ),
        constraints: const BoxConstraints(
          minHeight: 75,
          minWidth: double.maxFinite,
        ),
        child: Column(
          children: <Widget>[
            Text(
              post.title,
              style: TextStyle(fontSize: 24, color: lightGreyColor),
              textAlign: TextAlign.center,
            ),
            RichText(
              text: TextSpan(text: "u/", children: [
                TextSpan(
                    text: post.author,
                    style: TextStyle(
                        color: redditOrange, fontWeight: FontWeight.bold)),
                TextSpan(text: " in r/"),
                TextSpan(
                    text: post.subreddit.displayName,
                    style: TextStyle(
                        color: redditOrange, fontWeight: FontWeight.bold)),
                TextSpan(text: " - "),
                TextSpan(
                    text: timeago.format(post.createdUtc, locale: 'en_short'))
              ]),
            ),
          ],
        ));
  }
}
