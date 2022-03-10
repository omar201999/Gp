import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gp/shared/styles/colors.dart';
import 'package:hexcolor/hexcolor.dart';

ThemeData lightTheme = ThemeData(
  primarySwatch: defaultColor,
  scaffoldBackgroundColor: Colors.grey[200],
  appBarTheme: AppBarTheme(
    titleSpacing: 20,
    elevation: 0,
    backgroundColor: Colors.blue,
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
    titleTextStyle: TextStyle(
      fontSize: 24,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    backgroundColor: defaultColor,
    selectedItemColor: Colors.white,
    unselectedItemColor: Colors.black54,
    elevation: 0,

  ),
  textTheme: TextTheme(
    headline1: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: defaultLightTextColor,
    ),
    bodyText1: TextStyle(
      color: defaultLightTextColor,
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
  ),
  iconTheme: IconThemeData(
    color: defaultColor
  )
);

ThemeData darkTheme = ThemeData(
  primarySwatch: defaultColor,
  scaffoldBackgroundColor: HexColor('333739'),
  appBarTheme: AppBarTheme(
    titleSpacing: 20,
    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: HexColor('333739'),
      statusBarBrightness: Brightness.light
    ),
    backgroundColor: HexColor('333739'),
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
    titleTextStyle: TextStyle(
      fontSize: 24,
      color: defaultDarkTextColor,
      fontWeight: FontWeight.bold,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    backgroundColor: HexColor('333739'),
    selectedItemColor: Colors.white,
    unselectedItemColor: Colors.grey,
    elevation: 0,

  ),
  textTheme: TextTheme(
    headline1: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: defaultDarkTextColor,
    ),
    bodyText1: TextStyle(
      color: defaultDarkTextColor,
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
  ),
);