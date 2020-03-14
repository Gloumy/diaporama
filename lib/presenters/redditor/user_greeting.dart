import 'package:diaporama/states/global_state.dart';
import 'package:diaporama/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserGreeting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Selector<GlobalState, String>(
      selector: (_, state) => state.username,
      builder: (context, username, child) {
        return Row(
          children: <Widget>[
            Text(
              "Hi ${username ?? "Anonymous"} !",
              style: TextStyle(
                color: lightGreyColor,
              ),
            ),
          ],
        );
      },
    );
  }
}
