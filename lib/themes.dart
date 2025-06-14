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
  colorScheme: ColorScheme.light(primary: Colors.indigoAccent.shade400),
  inputDecorationTheme: InputDecorationTheme(
    floatingLabelAlignment: FloatingLabelAlignment.start,
    floatingLabelBehavior: FloatingLabelBehavior.auto,
    focusColor: Colors.indigo.shade600,
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        style: BorderStyle.solid,
        color: Colors.indigo.shade600,
        width: 0.5,
      ),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        style: BorderStyle.solid,
        color: Colors.indigo.shade600,
        width: 1,
      ),
    ),
    border: UnderlineInputBorder(
      borderSide: BorderSide(
        style: BorderStyle.solid,
        color: Colors.indigo.shade600,
        width: 0.5,
      ),
    ),
  ),
  buttonTheme: ButtonThemeData(buttonColor: Colors.indigo.shade50),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: TextButton.styleFrom(
      backgroundColor: Colors.indigo.shade50,
      foregroundColor: Colors.indigo.shade600,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      backgroundColor: Colors.indigo.shade50,
      foregroundColor: Colors.indigo.shade600,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  ),
);

final ThemeData chronoLogDarkTheme = ThemeData(
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
  colorScheme: ColorScheme.dark(
    primary: Colors.indigoAccent.shade400,
    surface: Colors.grey.shade900,
  ),
  inputDecorationTheme: InputDecorationTheme(
    floatingLabelAlignment: FloatingLabelAlignment.start,
    floatingLabelBehavior: FloatingLabelBehavior.auto,
    focusColor: Colors.indigo.shade600,
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        style: BorderStyle.solid,
        color: Colors.indigo.shade600,
        width: 0.5,
      ),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        style: BorderStyle.solid,
        color: Colors.indigo.shade600,
        width: 1,
      ),
    ),
    border: UnderlineInputBorder(
      borderSide: BorderSide(
        style: BorderStyle.solid,
        color: Colors.indigo.shade600,
        width: 0.5,
      ),
    ),
  ),
  buttonTheme: ButtonThemeData(buttonColor: Colors.indigo.shade50),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: TextButton.styleFrom(
      disabledForegroundColor: Colors.indigo.shade100,
      backgroundColor: Colors.indigo.shade50,
      foregroundColor: Colors.indigo.shade600,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      disabledForegroundColor: Colors.indigo.shade100,
      backgroundColor: Colors.indigo.shade50,
      foregroundColor: Colors.indigo.shade600,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  ),
);