import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'content_source.g.dart';

enum SourceType { Subreddit, MultiReddit }

@HiveType(typeId: 0)
class ContentSource extends HiveObject {
  @HiveField(0)
  final String
      subredditsString; // Contain the names of the subreddits
  @HiveField(1)
  final String label; // Used for displaying on source card
  final SourceType type;

  ContentSource({
    @required this.subredditsString,
    @required this.label,
    this.type = SourceType.Subreddit,
  });
}
