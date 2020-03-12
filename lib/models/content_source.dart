import 'package:flutter/material.dart';

enum SourceType { Subreddit, MultiReddit }

class ContentSource {
  final String name;
  final SourceType type;

  ContentSource({
    @required this.name,
    this.type = SourceType.Subreddit,
  });
}
