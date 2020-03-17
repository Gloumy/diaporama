import 'package:diaporama/screens/add_source_screen.dart';
import 'package:flutter/material.dart';

class AddNewSourceCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => AddSourceScreen())),
      child: Card(
        child: Center(child: Text("+")),
      ),
    );
  }
}
