import 'package:diaporama/states/subreddits_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';

class AddSourceScreen extends StatefulWidget {
  @override
  _AddSourceScreenState createState() => _AddSourceScreenState();
}

class _AddSourceScreenState extends State<AddSourceScreen> {
  List<String> _subreddits = [];
  TextEditingController _searchController = TextEditingController();

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
        child: Column(
          children: <Widget>[
            // TextFormField(
            //   controller: _searchController,
            // ),
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
