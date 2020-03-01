import 'package:diaporama/utils/secrets.dart';
import 'package:draw/draw.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FirstTimeModal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Welcome to Diaporama"),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text("Hello there (General Kenobi) !"),
          Text(
              "To get full functionalites from Diaporama (no limit on posts count, access to subreddit search and more), you need to connect to your Reddit account."),
          Text(
              "If you don't, no worries, you'll still be able to use it, but you'll be limited in the content."),
          Text("So, you gonna connect or not ?"),
        ],
      ),
      actions: <Widget>[
        FlatButton(
            onPressed: () => Navigator.pop(context), child: Text("Nope.")),
        RaisedButton(
            onPressed: () {
              Reddit reddit = Reddit.createInstalledFlowInstance(
                clientId: redditSecret,
                userAgent: "diaporama-app",
                redirectUri: Uri.parse("diaporama://cornet.dev"),
              );
              launch(reddit.auth.url(["*"], "diaporama-auth").toString());
            },
            child: Text("Yes !")),
      ],
    );
  }
}
