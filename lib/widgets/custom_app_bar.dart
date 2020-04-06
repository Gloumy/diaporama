import 'package:diaporama/utils/colors.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String subtitle;

  const CustomAppBar({Key key, this.subtitle}) : super(key: key);

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
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
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
            if (subtitle != null)
              Text(
                subtitle,
                style: TextStyle(color: redditOrange),
              )
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size(double.maxFinite, 75);
}
