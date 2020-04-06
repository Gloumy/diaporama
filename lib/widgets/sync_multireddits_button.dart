import 'package:diaporama/states/subreddits_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SyncMultiredditsButton extends StatefulWidget {
  @override
  _SyncMultiredditsButtonState createState() => _SyncMultiredditsButtonState();
}

class _SyncMultiredditsButtonState extends State<SyncMultiredditsButton> {
  @override
  Widget build(BuildContext context) {
    return RaisedButton.icon(
      icon: Icon(Icons.sync),
      label: Text("Sync"),
      onPressed: () {
        Provider.of<SubredditsState>(context, listen: false).syncMultiReddits();
      },
    );
  }
}
