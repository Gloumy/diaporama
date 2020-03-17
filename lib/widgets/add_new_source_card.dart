import 'package:diaporama/utils/colors.dart';
import 'package:diaporama/widgets/new_source_choice_sheet.dart';
import 'package:flutter/material.dart';

class AddNewSourceCard extends StatefulWidget {
  @override
  _AddNewSourceCardState createState() => _AddNewSourceCardState();
}

class _AddNewSourceCardState extends State<AddNewSourceCard> {
  void _displayNewSourceModal() {
    showModalBottomSheet(
        context: context,
        backgroundColor: darkGreyColor,
        builder: (context) {
          return NewSourceChoiceSheet();
        });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _displayNewSourceModal,
      child: Card(
        child: Center(child: Text("+")),
      ),
    );
  }
}
