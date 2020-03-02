import 'package:diaporama/presenters/posts_grid.dart';
import 'package:diaporama/presenters/subreddits/subreddits_dropdown.dart';
import 'package:diaporama/states/posts_state.dart';
import 'package:diaporama/widgets/first_time_modal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
          children: <Widget>[
            Icon(Icons.slideshow),
            Text("Diaporama"),
          ],
        ),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.settings), onPressed: () {})
        ],
      ),
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        child: Column(
          children: <Widget>[
            SubredditsDropdown(),
            Selector<PostsState, bool>(
              selector: (context, state) => state.isLoading,
              builder: (context, isLoading, _) {
                return isLoading
                    ? Center(child: CircularProgressIndicator())
                    : PostsGrid();
              },
            )
          ],
        ),
      ),
    );
  }
}
