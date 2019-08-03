import 'package:flutter/material.dart';

class Constants {
  static const String About = 'About me';
  static const String Settings = 'Settings';

  static const List<String> choices = <String>[About, Settings];

  static getBackgroundWidget(height) {
    return Container(
      alignment: Alignment.topCenter,
      padding: EdgeInsets.only(top: height * 0.5),
      child: Text(
        '钱',
        style: TextStyle(
          fontSize: height * 0.55,
          fontFamily: 'Roboto',
          color: Colors.teal[100],
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
