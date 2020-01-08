import 'package:flutter/material.dart';

import 'common/colors.dart';

ThemeData theme = ThemeData(
  backgroundColor: Colors.white,
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
      body1: TextStyle(color: primaryTextColor, fontSize: 20),
      body2: TextStyle(color: primaryTextColor, fontSize: 18),
      display1: TextStyle(
          color: Colors.black,
          fontSize: 22,
          fontFamily: 'ComeniaSansBold',
          fontWeight: FontWeight.w700),
      title: TextStyle(
          color: Colors.black,
          fontSize: 28,
          fontFamily: 'ComeniaSansBold',
          fontWeight: FontWeight.w700)),
);
