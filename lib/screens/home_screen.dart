import 'package:diaporama/presenters/redditor/user_greeting.dart';
import 'package:diaporama/presenters/subreddits/content_sources_grid.dart';
import 'package:diaporama/widgets/custom_app_bar.dart';
import 'package:diaporama/widgets/first_time_modal.dart';
import 'package:flutter/material.dart';
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
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(),
        body: Container(
          height: double.maxFinite,
          width: double.maxFinite,
          child: ListView(
            children: <Widget>[
              UserGreeting(),
              ContentSourcesGrid(),
            ],
          ),
        ),
      ),
    );
  }
}
