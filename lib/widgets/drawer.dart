import 'package:diaporama/utils/secrets.dart';
import 'package:draw/draw.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:diaporama/states/global_state.dart';

class DrawerMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Consumer<GlobalState>(
              builder: (context, state, _) {
                return state.redditor != null
                    ? Text(state.redditor?.displayName)
                    : Row(
                        children: <Widget>[
                          Text("Anonymous"),
                          SizedBox(
                            width: 10.0,
                          ),
                          RaisedButton.icon(
                            onPressed: () {
                              Reddit reddit =
                                  Reddit.createInstalledFlowInstance(
                                clientId: redditSecret,
                                userAgent: "diaporama-app",
                                redirectUri:
                                    Uri.parse("diaporama://cornet.dev"),
                              );
                              launch(reddit.auth
                                  .url(["*"], "diaporama-auth").toString());
                            },
                            icon: Icon(Icons.person),
                            label: Text("Login"),
                          )
                        ],
                      );
              },
            ),
          ),
          ListTile(
            title: Text("Frontpage"),
          ),
          ListTile(
            title: Text("All"),
          ),
          ListTile(
            title: Text("Popular"),
          ),
        ],
      ),
    );
  }
}
