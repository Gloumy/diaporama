import 'package:diaporama/models/post_type.dart';
import 'package:draw/draw.dart';
import 'package:flutter/material.dart';

class PostContent extends StatelessWidget {
  final Submission post;

  const PostContent({Key key, this.post}) : super(key: key);

  PostType getPostType() {
    if (post.isSelf) return PostType.SelfPost;
    if (["i.redd.it", "gfycat.com", "i.imgur.com"].contains(post.domain))
      return PostType.Image;
    if (post.isVideo) return PostType.Video;
    return null;
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
      default:
        throw "Unsupported post type";
    }

    return widget;
  }
}
