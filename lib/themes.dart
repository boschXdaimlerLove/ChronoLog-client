import 'package:flutter/material.dart';

final ThemeData chronoLogLightTheme = ThemeData(
  appBarTheme: AppBarTheme(
    iconTheme: IconThemeData(color: Colors.black87, applyTextScaling: true),
    backgroundColor: Colors.blueGrey.shade200,
    foregroundColor: Colors.black87,
    centerTitle: true,
    shape: RoundedRectangleBorder(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(25),
        bottomRight: Radius.circular(25),
      ),
      side: BorderSide(style: BorderStyle.solid),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    floatingLabelAlignment: FloatingLabelAlignment.start,
    floatingLabelBehavior: FloatingLabelBehavior.auto,
  ),
  buttonTheme: ButtonThemeData(buttonColor: Colors.blueAccent.shade700),
);

final ThemeData chronoLogDarkTheme = ThemeData();
