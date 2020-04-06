import 'package:diaporama/states/global_state.dart';
import 'package:diaporama/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          subtitle: "Settings",
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              RaisedButton.icon(
                  onPressed: () {
                    Provider.of<GlobalState>(context, listen: false).logout();
                  },
                  icon: Icon(MaterialCommunityIcons.logout),
                  label: Text("Logout")),
              RaisedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.sync),
                  label: Text("Sync my multireddits")),
            ],
          ),
        ),
      ),
    );
  }
}
