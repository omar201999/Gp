
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/layout/admin_layout/admin_layout.dart';
import 'package:gp/layout/home-layout/cubit/cubit.dart';
import 'package:gp/layout/home-layout/home_layout.dart';
import 'package:gp/models/user_model.dart';
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


Future<void> main()
async{
  BlocOverrides.runZoned(
        () async {
          WidgetsFlutterBinding.ensureInitialized();
      await CacheHelper.init();
      await Firebase.initializeApp();
      var token = await FirebaseMessaging.instance.getToken();
      //print(token);

      // foreground fcm
      /*FirebaseMessaging.onMessage.listen((event)
      {
        print('on message');
        print(event.data.toString());

        showToast(text: 'on message', state: ToastStates.SUCCESS,);
      });

      // when click on notification to open app
      FirebaseMessaging.onMessageOpenedApp.listen((event)
      {
        print('on message opened app');
        print(event.data.toString());

        showToast(text: 'on message opened app', state: ToastStates.SUCCESS,);
      });

      // background fcm
      FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
*/

      //Widget widget;
      //uId =   CacheHelper.getData(key: 'uId');
      //print(uId);
      /*if( uId == '60G1SVVEz9OulifBubcr6YdqAti1')
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

      }*/

      runApp( MyApp(
        //startWidget: widget,
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
        BlocProvider(create: (context) => HomeCubit()..getCompleteDiaryItems()..getCartItem()..getAllMeals()),
        BlocProvider(create: (context) => AdminCubit()..getUsers()..getLunchRecipe()..getDinnerRecipe()..getBreakfastRecipe()..getProducts()..countStockProducts()..getAllRecipe()..getOrders()),
      ],
      child: BlocConsumer<AppCubit,AppStates>(
        listener:(context,state){} ,
        builder: (context,state){
          return  MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme ,
            themeMode: ThemeMode.light,
            home: MainPage(),
          );
        },
      ),
    );
  }

}

class MainPage extends StatelessWidget
{
  late UserModel userModel;
  Future<DocumentSnapshot> getUserData() async{
    DocumentSnapshot x = await FirebaseFirestore.instance.
    collection('users').
    doc(uId).
    get();
     userModel = UserModel.fromJson(x.data());
    return x;
    /*.
    then((value) {
      userModel = UserModel.fromJson(value.data());
      emit(GetUserDataSuccessState());
    }).catchError((error) {
      emit(GetUserDataErrorState(error));
      print(error.toString());
    });*/
  }

  //CollectionReference users =  FirebaseFirestore.instance.collection('users');
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null ) {
            //CacheHelper.saveData(key: 'uId', value: snapshot.data!.uid);
            uId =snapshot.data!.uid;
            print(uId.toString());
            return FutureBuilder<DocumentSnapshot>(
              future: getUserData(),
              builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){
                if(snapshot.hasData && snapshot.data != null) {
                  final user = snapshot.data!.data();
                  HomeCubit.get(context).getUserData( model: userModel);
                  if(user!['status'] == 'admin') {
                    return AdminLayout();
                  } else {
                    print(userModel.name.toString());
                    return HomeLayout();
                  }
                }
                return const Center(child: CircularProgressIndicator());
              }

          );
        }
          //showToast(text: 'User is no longer active', state: ToastStates.ERROR);
          return LoginScreen();
        },
    );
  }

}
