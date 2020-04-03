import 'package:diaporama/models/app_settings.dart';
import 'package:diaporama/presenters/redditor/user_greeting.dart';
import 'package:diaporama/presenters/subreddits/content_sources_grid.dart';
import 'package:diaporama/widgets/custom_app_bar.dart';
import 'package:diaporama/widgets/first_time_modal.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> _checkFirstTime() async {
    Box box = await Hive.openBox<AppSettings>("settings");
    if (box.isEmpty) {
      box.add(AppSettings(
        stillAVirgin: false,
      ));
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
          padding: EdgeInsets.symmetric(
            horizontal: 15.0,
            vertical: 10.0,
          ),
          child: ListView(
            children: <Widget>[
              UserGreeting(),
              SizedBox(
                height: 8,
              ),
              ContentSourcesGrid(),
            ],
          ),
        ),
      ),
    );
  }
}
