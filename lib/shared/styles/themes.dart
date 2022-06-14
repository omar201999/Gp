import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gp/shared/styles/colors.dart';

ThemeData lightTheme = ThemeData(
  primarySwatch: defaultColor,
  scaffoldBackgroundColor: Colors.grey[50],
  appBarTheme:  AppBarTheme(
    titleSpacing: 15,
    elevation: 0,
    backgroundColor: Colors.grey[50],

    iconTheme: const IconThemeData(
      color: defaultColor,
    ),
    titleTextStyle: const TextStyle(
      fontSize: 24,
      color: defaultColor,
      fontWeight: FontWeight.bold,
      fontFamily: 'Jannah',
    ),

  ),
  bottomNavigationBarTheme:  BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    //backgroundColor: defaultColor,
    selectedItemColor: defaultColor,
    unselectedItemColor: Colors.black54,
    elevation: 20,

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
      color: Colors.black
  ),
  fontFamily: 'Jannah',
);

//HexColor('333739'),
ThemeData darkTheme = ThemeData(
  primarySwatch: defaultColor,
  scaffoldBackgroundColor:Color(0xff242526),// HexColor('#18191a'),//#1c1c1c
  appBarTheme: AppBarTheme(
    titleSpacing: 15,
    //backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Color(0xff242526),//HexColor('#18191a'),//#1c1c1c 0xff18191a
        statusBarBrightness: Brightness.light
    ),
    backgroundColor:Color(0xff242526),// HexColor('#18191a'),//#1c1c1c
    elevation: 0.0,
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
    titleTextStyle: const TextStyle(
      fontSize: 24,
      color: defaultDarkTextColor,
      fontWeight: FontWeight.bold,
      fontFamily: 'Jannah',
    ),
    actionsIconTheme: const IconThemeData(
      color: Colors.white,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    backgroundColor:Color(0xff242526),//HexColor('#18191a'),//#1c1c1c 0xff18191a
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
      caption:  TextStyle(
        color: Color(0xFFD4D4D4),
      )

  ),
  fontFamily: 'Jannah',
  iconTheme: IconThemeData(
      color:  Colors.white
  ),
  drawerTheme: DrawerThemeData(
    backgroundColor: Colors.black,
  ),
);