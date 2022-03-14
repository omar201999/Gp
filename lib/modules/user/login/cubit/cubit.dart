import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/models/user_model.dart';
import 'package:gp/modules/user/login/cubit/states.dart';

class LoginCubit extends Cubit<LoginStates>
{
  LoginCubit( ) : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  IconData suffix  = Icons.visibility_outlined;
   bool obScure = true;
   void changePasswordVisibility()
   {
     obScure = !obScure;
     suffix = obScure ? Icons.visibility_outlined :  Icons.visibility_off_outlined;
     emit(LoginChangePasswordVisibilityState());
   }


   void userLogin({
     required String email,
     required String password,
})
   {
     emit(LoginLoadingState());
     FirebaseAuth.instance.signInWithEmailAndPassword(
         email: email.trim(),
         password: password,
     ).then((value) {
       emit(LoginSuccessState(value.user!.uid));
     }).catchError((error){
       emit(LoginErrorState(error));
       print(error.toString());
     });
   }
 /* UserModel? userModel;

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
      emit(GetUserDataErrorState());
      //print(error.toString());
    });
  }*/

 List<UserModel> users = [];
  void getUsers()
  {
    FirebaseFirestore.instance.collection('users').get().then((value)
    {
      value.docs.forEach((element)
      {
        users.add(UserModel.fromJson(element.data()));
      });

      emit(GetAllUsersSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetAllUsersErrorState(error.toString()));
    });
  }


  /*List<UserModel> users1 = [];
  void getUsers1()
  {
    FirebaseFirestore.instance.
    collection('users').
    where('status',isEqualTo: 'user').
    get().
    then((value)
    {
      value.docs.forEach((element)
      {
        users1.add(UserModel.fromJson(element.data()));
      });

      emit(GetAllUsersSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetAllUsersErrorState(error.toString()));
    });
  }*/
}



