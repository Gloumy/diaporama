import 'package:diaporama/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

final ThemeData textTheme = ThemeData(
  textTheme: TextTheme(
    body1: TextStyle(
      fontSize: 12.0,
      fontFamily: "Raleway",
      color: lightGreyColor,
    ),
  ),
);

MarkdownStyleSheet customMarkdownStyleSheet = MarkdownStyleSheet.fromTheme(
  textTheme,
).copyWith(
  blockquoteDecoration: BoxDecoration(
    color: mediumGreyColor,
    borderRadius: BorderRadius.circular(2.0),
  ),
  code: textTheme.textTheme.body1.copyWith(
    backgroundColor: mediumGreyColor,
    fontFamily: "monospace",
    fontSize: textTheme.textTheme.body1.fontSize * 0.85,
  ),
  codeblockPadding: const EdgeInsets.all(8.0),
  codeblockDecoration: BoxDecoration(
    color: mediumGreyColor,
    borderRadius: BorderRadius.circular(2.0),
  ),
);
