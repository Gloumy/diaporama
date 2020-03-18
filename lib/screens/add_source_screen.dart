import 'package:diaporama/states/subreddits_state.dart';
import 'package:diaporama/utils/colors.dart';
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
  TextEditingController _nameController = TextEditingController();

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: "Source name"),
              controller: _nameController,
            ),
            SizedBox(
              height: 15.0,
            ),
            TypeAheadField(
                textFieldConfiguration: TextFieldConfiguration(
                  decoration: InputDecoration(
                      labelText: "Subreddits",
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: blueColor,
                      )),
                      suffixIcon: Icon(Icons.search),
                      prefixIcon: GestureDetector(
                        child: Icon(Icons.cancel),
                        onTap: () => _searchController.clear(),
                      )),
                  controller: _searchController,
                ),
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
            SizedBox(
              height: 5,
            ),
            Text(
              "Selected subreddits",
              style: TextStyle(fontSize: 18),
            ),
            for (String sub in _subreddits) Text(sub),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: blueColor,
        child: Icon(Icons.check),
      ),
    );
  }
}
