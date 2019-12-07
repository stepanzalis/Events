import 'package:flutter/material.dart';

ThemeData theme = ThemeData(
  buttonColor: Colors.black,
  fontFamily: 'Comenia Sans',
  primaryColor: Colors.white,
  primaryTextTheme: TextTheme(body1: TextStyle(color: Colors.black)),
  canvasColor: Colors.white,
  accentColor: Colors.grey,
  brightness: Brightness.light,
  buttonTheme: ButtonThemeData(
      textTheme: ButtonTextTheme.normal,
      buttonColor: Colors.black,
      disabledColor: Colors.grey,
      hoverColor: Colors.black),
  textTheme: TextTheme(
    body1: TextStyle(color: Colors.black, fontSize: 20),
  ),
);
