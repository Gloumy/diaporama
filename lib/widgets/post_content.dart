import 'package:chewie/chewie.dart';
import 'package:diaporama/models/post_type.dart';
import 'package:draw/draw.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import 'package:video_provider/video_provider.dart';

class PostContent extends StatefulWidget {
  final Submission post;

  const PostContent({Key key, this.post}) : super(key: key);

  @override
  _PostContentState createState() => _PostContentState();
}

class _PostContentState extends State<PostContent> {
  Submission get _post => widget.post;

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
        widget = Text(_post.selftext);
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
        widget = Image.network(_post.url.toString());
        break;
      case PostType.Link:
        widget = Column(
          children: <Widget>[
            Text(_post.url.toString()),
            RaisedButton(
              onPressed: () => launch(_post.url.toString()),
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

  @override
  void dispose() {
    _playerController?.dispose();
    _chewieController?.dispose();
    super.dispose();
  }
}
