import 'package:diaporama/utils/secrets.dart';
import 'package:diaporama/widgets/first_time_modal.dart';
import 'package:draw/draw.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../states/global_state.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> _checkFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Check if the user has already opened the app at least once
    if (!prefs.containsKey("notAVirgin")) {
      prefs.setString("notAVirgin", "true");
      showDialog(context: context, builder: (context) => FirstTimeModal());
    }
  }

  @override
  void initState() {
    super.initState();
    _checkFirstTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[Icon(Icons.slideshow), Text("Diaporama")],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(child: Consumer<GlobalState>(
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
            ))
          ],
        ),
      ),
      body: Container(),
    );
  }
}
