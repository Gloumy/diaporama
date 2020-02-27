import 'dart:async';

import 'package:diaporama/screens/home_screen.dart';
import 'package:diaporama/states/posts_state.dart';
import 'package:diaporama/utils/reddit_client.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_links/uni_links.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<Null> initPlatformState() async {
    try {
      Uri initialLink = await getInitialUri();
      if (initialLink != null && initialLink.queryParameters["code"] != null)
        RedditClient.reddit.auth.authorize(initialLink.queryParameters["code"]);
    } catch (e) {
      throw (e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PostsState>(
      create: (context) => PostsState(),
      child: MaterialApp(
        title: 'Diaporama',
        home: HomeScreen(),
      ),
    );
  }
}
