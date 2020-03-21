import 'package:diaporama/states/posts_state.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Consumer<PostsState>(
        builder: (context, state, _) {
          return PageView.builder(
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
              });
        },
      )),
    );
  }
}
