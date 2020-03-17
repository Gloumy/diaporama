import 'package:diaporama/utils/colors.dart';
import 'package:flutter/material.dart';

class NewSourceChoiceSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          "Add new source",
          style: TextStyle(
            color: redditOrange,
            fontSize: 18,
          ),
        ),
        ListTile(
          title: Text(
            "Single Subreddit",
            style: TextStyle(
              color: lightGreyColor,
            ),
          ),
        ),
        ListTile(
          title: Text(
            "Multiple Subreddits",
            style: TextStyle(
              color: lightGreyColor,
            ),
          ),
        ),
      ],
    );
  }
}
