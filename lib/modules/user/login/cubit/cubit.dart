import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
       emit(LoginSuccessState());//value.user!.uid
     }).catchError((error){
       emit(LoginErrorState(error.toString()));
       print(error.toString());
     });
   }
}



