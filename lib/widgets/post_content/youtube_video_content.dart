import 'package:flutter/material.dart';

class YoutubeVideoContent extends StatelessWidget {
  final String url;

  const YoutubeVideoContent({Key key, this.url}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    return Container(child: Text("Youtube Video Content"));
  }
}
