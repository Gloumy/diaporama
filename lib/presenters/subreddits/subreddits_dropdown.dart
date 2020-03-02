import 'package:diaporama/states/posts_state.dart';
import 'package:diaporama/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SubredditsDropdown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      items: [
        DropdownMenuItem(
          child: Text(
            "Frontpage",
          ),
        ),
        DropdownMenuItem(
          child: Text(
            "Popular",
          ),
        ),
        DropdownMenuItem(
          child: Text(
            "All",
          ),
        ),
      ],
      underline: Container(
        height: 2,
        color: redditOrange,
      ),
      iconEnabledColor: redditOrange,
      onChanged: (value) {
        Provider.of<PostsState>(context, listen: false)
            .retrievePosts("popular");
      },
    );
  }
}
