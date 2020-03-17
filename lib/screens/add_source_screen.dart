import 'package:diaporama/states/subreddits_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddSourceScreen extends StatefulWidget {
  @override
  _AddSourceScreenState createState() => _AddSourceScreenState();
}

class _AddSourceScreenState extends State<AddSourceScreen> {
  List<String> _subreddits = [];
  TextEditingController _searchController = TextEditingController();

  void _searchListener() async {
    List<String> subs =
        await Provider.of<SubredditsState>(context, listen: false)
            .searchSubreddit(_searchController.text);
    print(subs);
  }

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_searchListener);
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
            TextFormField(
              controller: _searchController,
            ),
          ],
        ),
      ),
    );
  }
}
