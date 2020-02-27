import 'package:diaporama/presenters/load_posts_button.dart';
import 'package:diaporama/presenters/posts_grid.dart';
import 'package:diaporama/utils/reddit_client.dart';
import 'package:draw/draw.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatelessWidget {
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
