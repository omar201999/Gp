import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/layout/admin_layout/admin_layout.dart';
import 'package:gp/layout/home-layout/cubit/cubit.dart';
import 'package:gp/layout/home-layout/home_layout.dart';
import 'package:gp/modules/user/login/login_screen.dart';
import 'package:gp/shared/bloc_observer.dart';
import 'package:gp/shared/componants/constant.dart';
import 'package:gp/shared/cubit/cubit.dart';
import 'package:gp/shared/cubit/states.dart';
import 'package:gp/shared/network/local/cashe_helper.dart';
import 'layout/admin_layout/cubit/cubit.dart';
import 'shared/styles/themes.dart';

void main()
{
  BlocOverrides.runZoned(
        () async {
      WidgetsFlutterBinding.ensureInitialized();
      await CacheHelper.init();
      await Firebase.initializeApp();

      Widget widget;
      uId = CacheHelper.getData(key: 'uId');
      if(uId == '60G1SVVEz9OulifBubcr6YdqAti1')
      {
        widget = AdminLayout();
        print(uId.toString());
      }
      else if(uId == null)
      {
        widget = LoginScreen();
        print(uId.toString());

      } else
      {
        widget = HomeLayout();
        print(uId.toString());

      }

      runApp( MyApp(
        startWidget: widget,
      )); //isDark!




    },
    blocObserver: MyBlocObserver(),
  );

}

class MyApp extends StatelessWidget
{
  final Widget? startWidget;
  MyApp({
    this.startWidget
  });

  @override
  Widget build(BuildContext context)
  {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AppCubit()),
        BlocProvider(create: (context) => HomeCubit()..getUserData()..getLunchRecipe()..getDinnerRecipe()..getBreakfastRecipe()..getProduct()..getCompleteDiaryItems()),
        BlocProvider(create: (context) => AdminCubit()..getUsers()..getLunchRecipe()..getDinnerRecipe()..getBreakfastRecipe()..getProducts()),
      ],
      child: BlocConsumer<AppCubit,AppStates>(
        listener:(context,state){} ,
        builder: (context,state){
          return  MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme ,
            themeMode: ThemeMode.light,
            home: startWidget,
          );
        },
      ),
    );
  }

}
