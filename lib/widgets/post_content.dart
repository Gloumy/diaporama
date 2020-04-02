import 'package:diaporama/models/post_type.dart';
import 'package:diaporama/states/posts_state.dart';
import 'package:diaporama/utils/colors.dart';
import 'package:diaporama/widgets/post_comments_list.dart';
import 'package:diaporama/widgets/post_content/gfycat_video_content.dart';
import 'package:diaporama/widgets/post_content/gif_video_content.dart';
import 'package:diaporama/widgets/post_content/image_content.dart';
import 'package:diaporama/widgets/post_content/link_content.dart';
import 'package:diaporama/widgets/post_content/self_post_content.dart';
import 'package:diaporama/widgets/post_content/twet_content.dart';
import 'package:diaporama/widgets/post_content/video_content.dart';
import 'package:diaporama/widgets/post_content/youtube_video_content.dart';
import 'package:draw/draw.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostContent extends StatefulWidget {
  final Submission post;
  final bool loadMore;

  const PostContent({
    Key key,
    this.post,
    this.loadMore,
  }) : super(key: key);

  @override
  _PostContentState createState() => _PostContentState();
}

class _PostContentState extends State<PostContent> {
  Submission get _post => widget.post;
  bool get _loadMore => widget.loadMore;

  @override
  void initState() {
    super.initState();
    if (_loadMore)
      Provider.of<PostsState>(context, listen: false).loadPosts(loadMore: true);
  }

  PostType getPostType() {
    if (_post.isSelf) return PostType.SelfPost;
    if (RegExp(r"\.(gif|jpe?g|bmp|png)$").hasMatch(_post.url.toString()))
      return PostType.Image;
    if (RegExp(
            r"(?:youtube\.com\/\S*(?:(?:\/e(?:mbed))?\/|watch\?(?:\S*?&?v\=))|youtu\.be\/)([a-zA-Z0-9_-]{6,11})")
        .hasMatch(_post.url.toString())) return PostType.YoutubeVideo;
    if (["v.redd.it", "i.redd.it", "i.imgur.com"].contains(_post.domain) ||
        _post.url.toString().contains('.gifv')) return PostType.GifVideo;
    if (_post.isVideo) return PostType.Video;
    if (_post.domain == "twitter.com") return PostType.Tweet;
    // Handle gfycat outside of VideoProvider as it returns 403 links
    if (_post.domain == "gfycat.com") return PostType.GfycatVideo;
    if (_post.domain == "imgur.com") return PostType.ImgurImage;

    return PostType.Link;
  }

  @override
  Widget build(BuildContext context) {
    Widget widget;
    switch (getPostType()) {
      case PostType.SelfPost:
        widget = SelfPostContent(
          text: _post.selftext,
        );
        break;
      case PostType.Video:
        widget = VideoContent(post: _post);
        break;
      case PostType.GifVideo:
        widget = GifVideoContent(post: _post);
        break;
      case PostType.GfycatVideo:
        widget = GfycatVideoContent(url: _post.url);
        break;
      case PostType.Image:
        widget = ImageContent(url: _post.url.toString());
        break;
      case PostType.ImgurImage:
        String imageId = _post.url.path.substring(1);
        widget = ImageContent(url: "https://i.imgur.com/$imageId.jpg");
        break;
      case PostType.Link:
        widget = LinkContent(post: _post);
        break;
      case PostType.YoutubeVideo:
        widget = YoutubeVideoContent(
          url: _post.url.toString(),
        );
        break;
      case PostType.Tweet:
        widget = TweetContent(
          url: _post.url.toString(),
        );
        break;
      default:
        throw "Unsupported post type";
    }

    return Provider<String>.value(
      value: _post.author,
      child: Column(children: [
        widget,
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: redditOrange, width: 2),
                top: BorderSide(
                  color: redditOrange,
                  width: 2,
                ),
              ),
              color: Colors.black12),
          height: 35,
          child: Row(
            children: <Widget>[
              Icon(
                Icons.arrow_upward,
                color: blueColor,
              ),
              Text(
                _post.score.toString(),
                style: TextStyle(
                    color: lightGreyColor, fontWeight: FontWeight.bold),
              ),
              Icon(Icons.arrow_downward, color: blueColor),
            ],
          ),
        ),
        PostCommentsList(
          post: _post,
        )
      ]),
    );
  }
}
