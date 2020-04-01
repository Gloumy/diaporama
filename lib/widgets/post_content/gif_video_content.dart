import 'package:chewie/chewie.dart';
import 'package:diaporama/utils/colors.dart';
import 'package:draw/draw.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:video_provider/video_provider.dart';

class GifVideoContent extends StatefulWidget {
  final Submission post;

  const GifVideoContent({Key key, this.post}) : super(key: key);

  @override
  _GifVideoContentState createState() => _GifVideoContentState();
}

class _GifVideoContentState extends State<GifVideoContent> {
  Submission get _post => widget.post;

  VideoPlayerController _playerController;
  ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    VideoProvider.fromUri(_post.url)
        .getVideos()
        .forEach((u) => print(u.uri.toString()));
    Uri videoUrl = VideoProvider.fromUri(_post.url).getVideos().first.uri;
    _playerController = VideoPlayerController.network(videoUrl.toString());
    _playerController.initialize();
    _chewieController = ChewieController(
      videoPlayerController: _playerController,
      aspectRatio: _playerController.value.aspectRatio,
      allowedScreenSleep: false,
      errorBuilder: (context, error) => Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.error,
            color: redditOrange,
          ),
          Text(
            error,
            style: TextStyle(color: lightGreyColor),
          ),
        ],
      )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Chewie(
      controller: _chewieController,
    );
  }
}
