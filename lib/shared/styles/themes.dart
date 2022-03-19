import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gp/shared/styles/colors.dart';
import 'package:hexcolor/hexcolor.dart';

ThemeData lightTheme = ThemeData(
  primarySwatch: defaultColor,
  scaffoldBackgroundColor: Colors.grey[50],
  appBarTheme: const AppBarTheme(
    titleSpacing: 20,
    elevation: 0,
    backgroundColor: Colors.white,
    iconTheme: IconThemeData(
      color: defaultColor,
    ),
    titleTextStyle: TextStyle(
      fontSize: 24,
      color: defaultColor,
      fontWeight: FontWeight.bold,
      fontFamily: 'Jannah',
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    //backgroundColor: defaultColor,
    selectedItemColor: defaultColor,
    unselectedItemColor: Colors.black54,
    elevation: 20.0,

  ),
  textTheme: const TextTheme(
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
  iconTheme: const IconThemeData(
      color: defaultColor
  ),
  fontFamily: 'Jannah',
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
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
    titleTextStyle: const TextStyle(
      fontSize: 24,
      color: defaultDarkTextColor,
      fontWeight: FontWeight.bold,
      fontFamily: 'Jannah',
    ),
  ),
  bottomNavigationBarTheme:  BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    backgroundColor: HexColor('333739'),
    selectedItemColor: Colors.white,
    unselectedItemColor: Colors.grey,
    elevation: 0,

  ),
  textTheme: const TextTheme(
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
  fontFamily: 'Jannah',
);