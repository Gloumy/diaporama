import 'dart:convert';

import 'package:diaporama/utils/colors.dart';
import 'package:diaporama/widgets/post_content/image_content.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class GfycatVideoContent extends StatefulWidget {
  final Uri url;

  const GfycatVideoContent({Key key, this.url}) : super(key: key);

  @override
  _GfycatVideoContentState createState() => _GfycatVideoContentState();
}

class _GfycatVideoContentState extends State<GfycatVideoContent> {
  Future<String> _retrieveLink() async {
    String videoName = widget.url.path.substring(1);

    Response response =
        await Dio().get('https://api.gfycat.com/v1/gfycats/$videoName');

    Map<String, dynamic> json = jsonDecode(response.toString());

    return json["gfyItem"]["gifUrl"];
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _retrieveLink(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ImageContent(
            url: snapshot.data,
          );
        } else {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                redditOrange,
              ),
              backgroundColor: darkGreyColor,
            ),
          );
        }
      },
    );
  }
}
