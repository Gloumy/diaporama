import 'package:diaporama/models/content_source.dart';
import 'package:diaporama/screens/viewer_screen.dart';
import 'package:diaporama/states/posts_state.dart';
import 'package:diaporama/states/subreddits_state.dart';
import 'package:diaporama/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContentSourceCard extends StatefulWidget {
  final ContentSource source;

  const ContentSourceCard({Key key, this.source}) : super(key: key);

  @override
  _ContentSourceCardState createState() => _ContentSourceCardState();
}

class _ContentSourceCardState extends State<ContentSourceCard> {
  bool _showActions = false;

  void _toggleShowActions() {
    setState(() {
      _showActions = !_showActions;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _showActions
          ? null
          : () {
              Provider.of<PostsState>(context, listen: false)
                  .loadPosts(source: widget.source);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ViewerScreen(
                            startingIndex: 0,
                          )));
            },
      onLongPress: _toggleShowActions,
      child: Stack(
        children: <Widget>[
          Container(
            height: double.maxFinite,
            width: double.maxFinite,
            margin: EdgeInsets.all(3),
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: darkGreyColor,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: blueColor,
                width: 2,
              ),
            ),
            child: Center(
              child: Text(
                widget.source.label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: lightGreyColor,
                ),
              ),
            ),
          ),
          if (_showActions)
            Container(
              height: double.maxFinite,
              width: double.maxFinite,
              margin: EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: Colors.black45,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: blueColor,
                  width: 2,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(child: Icon(Icons.edit, color: blueColor)),
                  GestureDetector(
                      child: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onTap: () {
                        if (["popular", "frontpage"]
                            .contains(widget.source.subredditsString)) {
                          Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text("Can't remove default sources"),
                            backgroundColor: Colors.red,
                          ));
                        } else {
                          Provider.of<SubredditsState>(context, listen: false)
                              .removeSource(widget.source);
                        }
                        _toggleShowActions();
                      }),
                  GestureDetector(
                      child: Icon(
                        Icons.cancel,
                        color: blueColor,
                      ),
                      onTap: _toggleShowActions),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
