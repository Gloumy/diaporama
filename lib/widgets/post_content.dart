import 'package:chewie/chewie.dart';
import 'package:diaporama/models/post_type.dart';
import 'package:diaporama/states/posts_state.dart';
import 'package:diaporama/utils/colors.dart';
import 'package:diaporama/widgets/post_comments_list.dart';
import 'package:draw/draw.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import 'package:video_provider/video_provider.dart';

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
  bool _showComments = false;

  VideoPlayerController _playerController;
  ChewieController _chewieController;
  Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    if (getPostType() == PostType.Video) {
      _playerController = VideoPlayerController.network(_post.url.toString());
      _initializeVideoPlayerFuture = _playerController.initialize();
    }
    if (getPostType() == PostType.GifVideo) {
      Uri videoUrl = VideoProvider.fromUri(_post.url).getVideos().first.uri;
      _playerController = VideoPlayerController.network(videoUrl.toString());
      _playerController.initialize();
      _chewieController = ChewieController(
        videoPlayerController: _playerController,
        aspectRatio: _playerController.value.aspectRatio,
        allowedScreenSleep: false,
      );
    }
    if (getPostType() == PostType.SelfPost || getPostType() == PostType.Link) {
      setState(() {
        _showComments = true;
      });
    }
    if (_loadMore)
      Provider.of<PostsState>(context, listen: false).loadPosts(loadMore: true);
  }

  PostType getPostType() {
    if (_post.isSelf) return PostType.SelfPost;
    if (["i.redd.it", "i.imgur.com"].contains(_post.domain)) {
      if (_post.url.toString().contains('.gifv')) {
        return PostType.GifVideo;
      } else {
        return PostType.Image;
      }
    }
    if (["v.redd.it", "gfycat.com"].contains(_post.domain))
      return PostType.GifVideo;
    if (_post.isVideo) return PostType.Video;

    return PostType.Link;
  }

  @override
  Widget build(BuildContext context) {
    Widget widget;
    switch (getPostType()) {
      case PostType.SelfPost:
        widget = _post.selftext.isNotEmpty
            ? Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: darkGreyColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: MarkdownBody(
                  data: _post.selftext,
                  onTapLink: (link) => launch(link),
                  styleSheet: MarkdownStyleSheet.fromTheme(
                    ThemeData(
                      textTheme: TextTheme(
                        body1: TextStyle(
                          fontSize: 14.0,
                          fontFamily: "Raleway",
                          color: lightGreyColor,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            : Container();
        break;
      case PostType.Video:
        widget = FutureBuilder(
          future: _initializeVideoPlayerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              // If the VideoPlayerController has finished initialization, use
              // the data it provides to limit the aspect ratio of the VideoPlayer.
              return AspectRatio(
                aspectRatio: _playerController.value.aspectRatio,
                // Use the VideoPlayer widget to display the video.
                child: VideoPlayer(_playerController),
              );
            } else {
              // If the VideoPlayerController is still initializing, show a
              // loading spinner.
              return Center(child: CircularProgressIndicator());
            }
          },
        );
        break;
      case PostType.GifVideo:
        widget = Chewie(
          controller: _chewieController,
        );
        break;
      case PostType.Image:
        widget = Image.network(
          _post.url.toString(),
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  redditOrange,
                ),
                backgroundColor: darkGreyColor,
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes
                    : null,
              ),
            );
          },
        );
        break;
      case PostType.Link:
        widget = GestureDetector(
          onTap: () => launch(_post.url.toString()),
          child: Container(
            margin: EdgeInsets.all(8.0),
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              border: Border.all(
                color: blueColor,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(5),
              color: darkGreyColor,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Expanded(
                  child: Icon(
                    Icons.launch,
                    color: blueColor,
                  ),
                  flex: 1,
                ),
                VerticalDivider(
                  thickness: 2,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Link",
                        style: TextStyle(
                          color: redditOrange,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        _post.domain,
                        style: TextStyle(color: lightGreyColor),
                      ),
                    ],
                  ),
                  flex: 3,
                ),
              ],
            ),
          ),
        );
        break;
      default:
        throw "Unsupported post type";
    }

    return Column(children: [
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
              style:
                  TextStyle(color: lightGreyColor, fontWeight: FontWeight.bold),
            ),
            Icon(Icons.arrow_downward, color: blueColor),
            Expanded(child: Container()),
            if (_post.comments != null)
              Text(
                _post.comments?.length.toString(),
                style: TextStyle(
                    color: lightGreyColor, fontWeight: FontWeight.bold),
              ),
            GestureDetector(
              onTap: () {
                setState(() {
                  _showComments = true;
                });
              },
              child: Icon(
                Icons.mode_comment,
                color: blueColor,
              ),
            ),
          ],
        ),
      ),
      if (_showComments)
        PostCommentsList(
          post: _post,
        )
    ]);
  }

  @override
  void dispose() {
    _playerController?.dispose();
    _chewieController?.dispose();
    super.dispose();
  }
}
