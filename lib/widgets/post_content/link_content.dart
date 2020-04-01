import 'package:diaporama/utils/colors.dart';
import 'package:draw/draw.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkContent extends StatelessWidget {
  final Submission post;

  const LinkContent({Key key, this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => launch(post.url.toString()),
      child: Container(
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          border: Border.all(
            color: blueColor,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(5),
          color: darkGreyColor,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              child: Icon(
                Icons.launch,
                color: blueColor,
              ),
              flex: 1,
            ),
            VerticalDivider(
              thickness: 2,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Link",
                    style: TextStyle(
                      color: redditOrange,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    post.domain,
                    style: TextStyle(color: lightGreyColor),
                  ),
                ],
              ),
              flex: 3,
            ),
          ],
        ),
      ),
    );
  }
}
