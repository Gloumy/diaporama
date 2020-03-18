import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'content_source.g.dart';

enum SourceType { Subreddit, MultiReddit }

@HiveType(typeId: 0)
class ContentSource extends HiveObject {
  @HiveField(0)
  final String
      name; // Will contain the subreddits, should change for a better name later
  @HiveField(1)
  final String label; // Used for displaying on source card
  final SourceType type;

  ContentSource({
    @required this.name,
    @required this.label,
    this.type = SourceType.Subreddit,
  });
}
