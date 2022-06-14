import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/shared/componants/constant.dart';
import 'package:gp/shared/cubit/states.dart';
import 'package:gp/shared/network/local/cashe_helper.dart';

class AppCubit extends Cubit<AppStates>
{
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);
  Color constantColor1 = Color(0xFFE3F4FB);
  Color constantColor5 = Color(0xFFEEEEEE);
  Color? scaffoldColor = Colors.grey[50];
  Color defaultColor = Colors.blue;
  Color shadowColor = Colors.black;

  bool isDark = false;
  void changeAppMode({fromCache}) {
    if (fromCache == null) {
      isDark = isDark;
    } else {
      isDark = fromCache;
    }
    CacheHelper.saveData(key: 'isDark', value: isDark).then((value) {
      if (isDark) {
        constantColor1 =Color(0xff3a3b3c);// HexColor('#242526');//333739 0xff242526 0xff3a3b3c
        appMode = ThemeMode.dark;
        scaffoldColor = Color(0xff242526);
        shadowColor = Colors.white;
        constantColor5 = Color(0xFFD6D6D6);
        defaultColor = Colors.white;
        emit(AppChangeModeState());
      }
      else {
        constantColor1 = Color(0xFFE3F4FB);
        constantColor5 = Color(0xFFEEEEEE);
        scaffoldColor = Colors.grey[50];
        shadowColor = Colors.black;
        defaultColor = Colors.blue;
        appMode = ThemeMode.light;
        emit(AppChangeModeState());
      }
    });
  }
/*bool isDark = false;

  void changeAppMode({ bool? fromShared})
  {
    if (fromShared != null)
    {
      isDark = fromShared;

    }
    else{
      isDark = !isDark;

      CacheHelper.saveData(key: 'isDark', value: isDark).then((value)
      {
        emit(AppChangeModeState());
      });

    }
  }*/
/*  bool isDark = false;

  void changeAppMode({bool? fromShared})
  {
    if (fromShared != null)
    {
      isDark = fromShared;
      emit(AppChangeModeState());
    } else
    {
      isDark = !isDark;
      CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
        emit(AppChangeModeState());
      });
    }
  }*/
/*bool isDark = true;
  void changeAppMode({bool? value}) async {
    if (value!) {
       isDark = true;
      emit(ChangeThemeDarkState());
    } else {
      isDark = false;
      emit(ChangeThemeLightState());
    }
      if(isDark)
      {
        constantColor1 = HexColor('333739');
        appMode = ThemeMode.dark;
        print('HexColor');

      }
      else
        {
          constantColor1 = Color(0xFFE3F4FB);
          appMode = ThemeMode.light;
          print('Color(0xFFE3F4FB)');
        }


  }*/

}