import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/layout/home-layout/cubit/states.dart';
import 'package:gp/models/user_model.dart';
import 'package:gp/modules/customer_dashboard/CustomerDashBoard_Screen.dart';
import 'package:gp/modules/home/home_screen.dart';
import 'package:gp/modules/market/MarketScreen.dart';
import 'package:gp/modules/recipe/recipe_screen.dart';
import 'package:gp/shared/componants/constant.dart';


class HomeCubit extends Cubit<HomeStates>
{
  HomeCubit() : super(HomeIntitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> bodyScreen =
  [
    HomePage(),
    MarketScreen(),
    RecipeScreen(),
    CustomerDashBoardScreen(),

  ];
  void changeBottomNavBar(int index)
  {
    currentIndex = index;
    emit(HomeChangeBottonNavState());
  }

  UserModel? userModel;

  void getUserData()
  {
   emit(GetUserDataLoadingState());
   FirebaseFirestore.instance.
   collection('users').
   doc(uId).
   get().
   then((value) {
     userModel = UserModel.fromJson(value.data());
     emit(GetUserDataSuccessState());
   }).catchError((error){
     emit(GetUserDataErrorState(error));
    print(error.toString());
   });
  }

}