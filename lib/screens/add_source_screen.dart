import 'package:diaporama/states/subreddits_state.dart';
import 'package:diaporama/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';

class AddSourceScreen extends StatefulWidget {
  @override
  _AddSourceScreenState createState() => _AddSourceScreenState();
}

class _AddSourceScreenState extends State<AddSourceScreen> {
  List<String> _subreddits = [];
  bool _multiple = false;

  Future<List<String>> _searchListener(String query) async {
    List<String> subs =
        await Provider.of<SubredditsState>(context, listen: false)
            .searchSubreddit(query);
    return subs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add new source"),
        centerTitle: true,
        leading: IconButton(
            icon: Icon(
              Icons.cancel,
              color: Colors.red,
            ),
            onPressed: () => Navigator.pop(context)),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 25,
        ),
        child: Column(
          children: <Widget>[
            ToggleSwitch(
              activeBgColor: redditOrange,
              activeTextColor: lightGreyColor,
              inactiveBgColor: darkGreyColor,
              inactiveTextColor: mediumGreyColor,
              labels: ["Subreddit", "Multireddit"],
              onToggle: (index) {
                setState(() {
                  _multiple = index == 0 ? false : true;
                });
              },
            ),
            TypeAheadField(
                suggestionsCallback: (value) async =>
                    await _searchListener(value),
                itemBuilder: (context, value) {
                  return Text(value);
                },
                onSuggestionSelected: (value) {
                  setState(() {
                    _subreddits.add(value);
                  });
                }),
            for (String sub in _subreddits) Text(sub)
          ],
        ),
      ),
    );
  }
}
