import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/layout/home-layout/cubit/cubit.dart';
import 'package:gp/layout/home-layout/cubit/states.dart';
import 'package:gp/modules/add_Information/add_information.dart';
import 'package:gp/shared/bloc_observer.dart';
import 'shared/styles/themes.dart';

void main() {
  BlocOverrides.runZoned(
        () async {
          WidgetsFlutterBinding.ensureInitialized();
          await Firebase.initializeApp();
          runApp( MyApp()); //isDark!




    },
    blocObserver: MyBlocObserver(),
  );

}

class MyApp extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {



             return MaterialApp(
               debugShowCheckedModeBanner: false,
               theme: lightTheme,
               darkTheme: darkTheme ,
               themeMode: ThemeMode.light,
               home: AddInformation() ,
             );


      }

}
