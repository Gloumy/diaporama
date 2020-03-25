import 'package:diaporama/utils/colors.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      decoration: BoxDecoration(
        color: darkGreyColor,
        border: Border(
          bottom: BorderSide(width: 2, color: redditOrange),
        ),
      ),
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image.asset(
              "assets/images/diaporama-logo-inapp.png",
              height: 38,
              width: 38,
            ),
            Text(
              "Diaporama",
              style: TextStyle(
                color: lightGreyColor,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size(double.maxFinite, 75);
}
