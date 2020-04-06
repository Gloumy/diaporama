import 'package:diaporama/states/posts_state.dart';
import 'package:diaporama/utils/colors.dart';
import 'package:diaporama/widgets/post_content.dart';
import 'package:diaporama/widgets/post_header.dart';
import 'package:draw/draw.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewerScreen extends StatefulWidget {
  final int startingIndex;

  const ViewerScreen({Key key, this.startingIndex}) : super(key: key);

  @override
  _ViewerScreenState createState() => _ViewerScreenState();
}

class _ViewerScreenState extends State<ViewerScreen> {
  PageController _controller;

  @override
  void initState() {
    _controller = PageController(
      initialPage: widget.startingIndex,
    );
    super.initState();
  }

  Future<bool> _exitView(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              "Exit ?",
              style: TextStyle(
                color: redditOrange,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: mediumGreyColor,
            content: Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: darkGreyColor,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                "Are you sure you want to go back ? Your progression in threads will be reset.",
                style: TextStyle(
                  color: lightGreyColor,
                ),
              ),
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(
                  "Stay",
                  style: TextStyle(
                    color: redditOrange,
                  ),
                ),
              ),
              RaisedButton(
                onPressed: () => Navigator.of(context).pop(true),
                color: blueColor,
                child: Text(
                  "Exit",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Consumer<PostsState>(
        builder: (context, state, _) {
          return WillPopScope(
            onWillPop: () => _exitView(context),
            child: PageView.builder(
                controller: _controller,
                itemCount: state.contents.length,
                itemBuilder: (context, index) {
                  Submission post = state.contents[index];
                  bool loadMore =
                      (index > state.contents.length - 10 && !state.isLoading);
                  return SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        PostHeader(post: post),
                        PostContent(
                          post: post,
                          loadMore: loadMore,
                        ),
                      ],
                    ),
                  );
                }),
          );
        },
      )),
    );
  }
}
