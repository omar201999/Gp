import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
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

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
   print('on background message');
   print(message.data.toString());

   //showToast(text: 'on background message', state: ToastStates.NOTE);
}


void main()
{
  BlocOverrides.runZoned(
        () async {
      WidgetsFlutterBinding.ensureInitialized();
      await CacheHelper.init();
      await Firebase.initializeApp();

      var token = await FirebaseMessaging.instance.getToken();

      print(token);

      //when the app is opened
      FirebaseMessaging.onMessage.listen((event) {
        print('on message');
        print(event.data.toString());

        //showToast(text: 'on message', state: ToastStates.NOTE);
      });
      // when click on notification to open app
      FirebaseMessaging.onMessageOpenedApp.listen((event) {
        print('on message opened app');
        print(event.data.toString());

        //showToast(text: 'on message opened app', state: ToastStates.NOTE);
      });
      // background notification
      FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

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
        BlocProvider(create: (context) => HomeCubit()..getUserData()..getCompleteDiaryItems()..getCartItem()),
        BlocProvider(create: (context) => AdminCubit()..getUsers()..getLunchRecipe()..getDinnerRecipe()..getBreakfastRecipe()..getProducts()..countStockProducts()),
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
