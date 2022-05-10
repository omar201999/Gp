import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:gp/modules/user/login/cubit/states.dart';
import 'package:gp/shared/componants/constant.dart';


class LoginCubit extends Cubit<LoginStates>
{
  LoginCubit( ) : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);
 // Color constantColor1 = Color(0xFFE3F4FB);

  /*bool isDark = false;
  void changeAppMode({fromCache}) {
    if (fromCache == null) {
      isDark = !isDark;
    } else {
      isDark = fromCache;
    }
      if (isDark) {
        //constantColor1 = HexColor('333739');
        appMode = ThemeMode.dark;
        //print('HexColor');
        //emit(AppChangeModeState());
      }
      else {
       // constantColor1 = Color(0xFFE3F4FB);
        appMode = ThemeMode.light;
        //print('Color(0xFFE3F4FB)');
        //emit(AppChangeModeState());
      }
  }*/

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

  Future<UserCredential> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);

    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }

 /* Future<void> createOrder2 () async{
    DocumentReference? x;
    x = await FirebaseFirestore.instance
        .collection('orders')
        .add(
        {
          'userName': x?.id,
        });
    FirebaseFirestore.instance
        .collection('orders').doc(x.id).update({'userName': x.id,});
    emit(LoginSuccessState());

  }*/
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
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

/* List<UserModel> users = [];
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
      emit(GetAllUsersErrorState(error.toString()));
      print(error.toString());

    });
  }*/


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



