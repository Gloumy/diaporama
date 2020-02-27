import 'package:diaporama/screens/home_screen.dart';
import 'package:diaporama/states/posts_state.dart';
import 'package:diaporama/utils/secrets.dart';
import 'package:draw/draw.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final reddit = Reddit.createInstalledFlowInstance(
    clientId: redditSecret,
    userAgent: "diaporama-app",
    redirectUri: Uri.parse("diaporama://cornet.dev"),
  );
  final authUrl = reddit.auth.url(['*'], "diaporama");

  launch(authUrl.toString());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
