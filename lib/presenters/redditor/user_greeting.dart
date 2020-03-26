import 'package:diaporama/states/global_state.dart';
import 'package:diaporama/utils/colors.dart';
import 'package:diaporama/utils/secrets.dart';
import 'package:draw/draw.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class UserGreeting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Selector<GlobalState, String>(
      selector: (_, state) => state.username,
      builder: (context, username, child) {
        return Row(
          children: <Widget>[
            RichText(
              text: TextSpan(
                text: "Hi ",
                children: [
                  TextSpan(
                    text: username ?? "Anonymous",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: redditOrange,
                    ),
                  ),
                  TextSpan(
                    text: " !",
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
            if (username == null)
              RaisedButton.icon(
                  textColor: lightGreyColor,
                  color: blueColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
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
                  icon: Icon(
                    Icons.person,
                    size: 20,
                  ),
                  label: Text("Login"))
          ],
        );
      },
    );
  }
}
