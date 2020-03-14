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
            Text(
              "Hi ${username ?? "Anonymous"} !",
              style: TextStyle(
                color: lightGreyColor,
              ),
            ),
            if (username == null)
              IconButton(
                  icon: Icon(
                    Icons.person,
                    color: redditOrange,
                  ),
                  onPressed: () {
                    Reddit reddit = Reddit.createInstalledFlowInstance(
                      clientId: redditSecret,
                      userAgent: "diaporama-app",
                      redirectUri: Uri.parse("diaporama://cornet.dev"),
                    );
                    launch(reddit.auth.url(["*"], "diaporama-auth").toString());
                  }),
          ],
        );
      },
    );
  }
}
