import 'package:diaporama/models/post_type.dart';
import 'package:draw/draw.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PostContent extends StatelessWidget {
  final Submission post;

  const PostContent({Key key, this.post}) : super(key: key);

  PostType getPostType() {
    if (post.isSelf) return PostType.SelfPost;
    if (["i.redd.it", "gfycat.com", "i.imgur.com"].contains(post.domain)) {
      if (post.url.toString().contains('.gifv') ||
          post.domain.contains("gfycat.com")) {
        return PostType.GifVideo;
      } else {
        return PostType.Image;
      }
    }
    if (post.isVideo) return PostType.Video;

    return PostType.Link;
  }

  @override
  Widget build(BuildContext context) {
    Widget widget;

    switch (getPostType()) {
      case PostType.SelfPost:
        widget = Text(post.selftext);
        break;
      case PostType.Video:
        widget = Text("Video");
        break;
      case PostType.Image:
        widget = Image.network(post.url.toString());
        break;
      case PostType.Link:
        widget = Column(
          children: <Widget>[
            Text(post.url.toString()),
            RaisedButton(
              onPressed: () => launch(post.url.toString()),
              child: Text("Go to URL"),
            ),
          ],
        );
        break;
      case PostType.GifVideo:
        widget = Text("GifVideo");
        break;
      default:
        throw "Unsupported post type";
    }

    return widget;
  }
}
