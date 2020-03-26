import 'package:diaporama/utils/colors.dart';
import 'package:diaporama/utils/secrets.dart';
import 'package:draw/draw.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FirstTimeModal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "Welcome to Diaporama",
        style: TextStyle(
          color: redditOrange,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: mediumGreyColor,
      content: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: darkGreyColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              "Hello there (General Kenobi) ! \n",
              style: TextStyle(color: lightGreyColor),
            ),
            Text(
              "To get a more personnalized experience, you need to connect to your Reddit account. \n",
              style: TextStyle(color: lightGreyColor),
            ),
            Text(
              "If you don't, that's cool, you'll still be able to use it, but you might be limited in the content. \n",
              style: TextStyle(color: lightGreyColor),
            ),
            Text(
              "So, you gonna connect or what ?",
              style: TextStyle(color: lightGreyColor),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () => Navigator.pop(context),
          child: Text("Nope."),
          textColor: Colors.red,
        ),
        RaisedButton(
            color: blueColor,
            onPressed: () {
              Reddit reddit = Reddit.createInstalledFlowInstance(
                clientId: redditSecret,
                userAgent: "diaporama-app",
                redirectUri: Uri.parse("diaporama://cornet.dev"),
              );
              launch(
                reddit.auth.url(["read", "save", "account", "identity"],
                    "diaporama-auth").toString(),
              );
            },
            child: Text("Yes !")),
      ],
    );
  }
}
