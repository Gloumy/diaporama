import 'package:diaporama/screens/add_source_screen.dart';
import 'package:diaporama/utils/colors.dart';
import 'package:flutter/material.dart';

class AddNewSourceCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => AddSourceScreen())),
      child: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        margin: EdgeInsets.all(3),
        decoration: BoxDecoration(
          color: darkGreyColor,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: blueColor,
            width: 2,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                Icons.add,
                color: lightGreyColor,
                size: 28,
              ),
              Text(
                "Add new",
                style: TextStyle(
                  color: lightGreyColor,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
