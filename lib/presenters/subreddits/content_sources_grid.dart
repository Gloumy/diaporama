import 'package:diaporama/states/posts_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContentSourcesGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<PostsState>(
      builder: (context, state, _) {
        return GridView.builder(
          itemCount: state.contentSources.length + 1,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          itemBuilder: (context, index) {
            return index < state.contentSources.length
                ? Card(
                    child: Center(
                      child: Text(
                        state.contentSources[index].name,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                : Card(
                    child: Center(child: Text("+")),
                  );
          },
        );
      },
    );
  }
}
