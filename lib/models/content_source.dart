import 'package:flutter/material.dart';

enum SourceType { Subreddit, MultiReddit }

class ContentSource {
  final String name;
  final String label;
  final SourceType type;

  ContentSource({
    @required this.name,
    @required this.label,
    this.type = SourceType.Subreddit,
  });
}
