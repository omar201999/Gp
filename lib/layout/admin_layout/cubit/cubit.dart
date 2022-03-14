
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/layout/admin_layout/cubit/states.dart';
import 'package:gp/models/user_model.dart';
import 'package:gp/modules/admin_dashboard/admin_dashboard.dart';
import 'package:gp/modules/market_management/market_management.dart';
import 'package:gp/modules/recipe_management/recipes_management.dart';
import 'package:gp/modules/users_management/users_management.dart';
import 'package:gp/shared/componants/constant.dart';


class AdminCubit extends Cubit<AdminStates>
{
  AdminCubit() : super(AdminInitialState());

  static AdminCubit get(context) => BlocProvider.of(context);

  UserModel  model = UserModel();

  /*void getUserData()
  {
    emit(AdminGetUserSLoadingState());

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .get()
        .then((value) {
      print(value.data());
      model = AdminUserModel.fromJson(value.data());
      emit(AdminGetUserSuccessState());

    }).catchError((error) {
      print(error.toString());
      emit(AdminGetUserErrorState(error.toString()));
    });
  }*/
  int currentIndex = 0 ;
  List<Widget> screens = [
    DashboardScreen(),
    UsersManagementScreen(),

    //NotificationsScreen(),
    RecipesManagementScreen(),
    MarketManagementScreen()
  ];

  List<String> titles = [
    'Dashboard',
    'Users',
    'Recipes',
    'Market'
  ];



  changeBottomNav(index) {
    currentIndex = index;
    emit(ChangeBottomNavState());
  }

  List<UserModel> users = [];

  void getUsers()
  {
    FirebaseFirestore.instance.collection('users').
    where('status',isEqualTo: 'user')
        .get().then((value)
    {
      value.docs.forEach((element)
      {
        users.add(UserModel.fromJson(element.data()));
      });

      emit(AdminGetAllUsersSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(AdminGetAllUsersErrorState(error.toString()));
    });
  }

  void deleteUser()
  {
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId).delete().then((value)
    {
      emit(AdminDeleteUsersSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(AdminDeleteUsersErrorState(error.toString()));
    });
  }

}