import 'package:diaporama/presenters/load_posts_button.dart';
import 'package:diaporama/presenters/posts_grid.dart';
import 'package:diaporama/utils/reddit_client.dart';
import 'package:diaporama/widgets/first_time_modal.dart';
import 'package:draw/draw.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

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
      body: SafeArea(
        child: Container(
            child: Column(
          children: <Widget>[
            LoadPostsButton(),
            RaisedButton(
              onPressed: () => launch(RedditClient.authUrl.toString()),
              child: Text("Auth"),
            ),
            RaisedButton(
              onPressed: () async {
                Redditor me = await RedditClient.reddit.user.me();
                print(me.displayName);
              },
              child: Text("Auth"),
            ),
            PostsGrid(),
          ],
        )),
      ),
    );
  }
}
