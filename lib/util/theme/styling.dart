import 'package:flutter/material.dart';

import '../../common/colors.dart';

ThemeData theme = ThemeData(
  backgroundColor: Colors.white,
  buttonColor: Colors.black,
  fontFamily: 'Comenia Sans',
  primaryColor: Colors.white,
  primaryTextTheme: TextTheme(body1: TextStyle(color: primaryTextColor)),
  canvasColor: Colors.white,
  accentColor: Colors.grey,
  brightness: Brightness.light,
  buttonTheme: ButtonThemeData(
      textTheme: ButtonTextTheme.normal,
      buttonColor: Colors.black,
      disabledColor: Colors.grey,
      hoverColor: primaryTextColor),
  textTheme: TextTheme(
      body1: TextStyle(color: primaryTextColor, fontSize: 20),
      body2: TextStyle(color: primaryTextColor, fontSize: 18, height: 1.3),
      subhead: TextStyle(
          fontSize: 16, color: Colors.white, fontFamily: 'Comenia Sans'),
      display1: TextStyle(
          color: primaryTextColor,
          fontSize: 22,
          fontFamily: 'Comenia Sans Bold',
          fontWeight: FontWeight.w700),
      subtitle: TextStyle(
          fontSize: 20,
          color: Colors.black,
          fontFamily: 'Comenia Sans Bold',
          fontWeight: FontWeight.w700),
      title: TextStyle(
          color: primaryTextColor,
          fontSize: 28,
          fontFamily: 'Comenia Sans Bold',
          fontWeight: FontWeight.w700)),
);
