import 'package:diaporama/states/posts_state.dart';
import 'package:diaporama/utils/colors.dart';
import 'package:diaporama/widgets/post_comments_list.dart';
import 'package:diaporama/widgets/post_content.dart';
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
                bool loadMore = index > state.contents.length - 10;
                return SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(8.0),
                        constraints: BoxConstraints(minHeight: 70.0),
                        color: darkGreyColor,
                        child: Center(
                            child: Text(
                          post.title,
                          style: TextStyle(fontSize: 24, color: lightGreyColor),
                          textAlign: TextAlign.center,
                        )),
                      ),
                      Row(
                        children: <Widget>[
                          Chip(
                            label: Text("r/${post.subreddit.displayName}"),
                          ),
                          if (post.over18)
                            Chip(
                              label: Text("18+"),
                            )
                        ],
                      ),
                      PostContent(
                        post: post,
                        loadMore: loadMore,
                      ),
                      PostCommentsList(
                        post: post,
                      )
                    ],
                  ),
                );
              });
        },
      )),
    );
  }
}
