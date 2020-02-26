import 'package:diaporama/screens/home_screen.dart';
import 'package:diaporama/states/posts_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

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
