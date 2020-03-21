import 'package:diaporama/models/content_source.dart';
import 'package:diaporama/screens/viewer_screen.dart';
import 'package:diaporama/states/posts_state.dart';
import 'package:diaporama/states/subreddits_state.dart';
import 'package:diaporama/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContentSourceCard extends StatelessWidget {
  final ContentSource source;

  const ContentSourceCard({Key key, this.source}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Provider.of<PostsState>(context, listen: false)
            .loadPosts(source: source);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ViewerScreen(
                      startingIndex: 0,
                    )));
      },
      onLongPress: () {
        showModalBottomSheet(
            context: context,
            builder: (context) => Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      title: Text("Edit"),
                      leading: Icon(
                        Icons.edit,
                        color: blueColor,
                      ),
                    ),
                    ListTile(
                        title: Text("Remove"),
                        leading: Icon(
                          Icons.remove_circle,
                          color: Colors.red,
                        ),
                        onTap: () {
                          Provider.of<SubredditsState>(context, listen: false)
                              .removeSource(source);
                          Navigator.pop(context);
                        }),
                  ],
                ));
      },
      child: Container(
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
            source.label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: lightGreyColor,
            ),
          ),
        ),
      ),
    );
  }
}
