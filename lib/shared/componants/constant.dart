
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gp/layout/home-layout/cubit/cubit.dart';
import 'package:gp/main.dart';
import 'package:gp/shared/cubit/cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> signOut(context)
async{
  uId = '';
  //print(uId.toString());
  HomeCubit.get(context).userModel=null;
  //print( HomeCubit.get(context).userModel.toString());
  await FirebaseAuth.instance.signOut();
  AppCubit.get(context).changeAppMode(fromCache: false);
  MyApp.setLocale(context, Locale('en','US'));
  setLocale(english);
  getLocale();
  //print(AppCubit.get(context).isDark.toString());
}


String? uId = '';
ThemeMode appMode = ThemeMode.light;

String? lan = 'en';
const String LAGUAGE_CODE = 'languageCode';

//languages code
const String english = 'en';
const String arabic = 'ar';


Future<Locale> setLocale(String languageCode) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  await _prefs.setString(LAGUAGE_CODE, languageCode);
  //lan = languageCode;
  return _locale(languageCode);
}

Future<Locale> getLocale() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  String languageCode = _prefs.getString(LAGUAGE_CODE)! ;
  lan = languageCode;
  return _locale(languageCode);
}

Locale _locale(String languageCode) {
  switch (languageCode) {
    case english:
      return Locale(english, 'US');
    case arabic:
      return Locale(arabic, "EG");
    default:
      return Locale(english, 'US');
  }
}
