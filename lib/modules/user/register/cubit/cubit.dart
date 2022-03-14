import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/models/user_model.dart';
import 'package:gp/modules/user/register/cubit/states.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;


class RegisterCubit extends Cubit<RegisterStates>
{
  RegisterCubit() : super(RegisterInitialState());
  
  static RegisterCubit get(context) => BlocProvider.of(context);

  IconData suffix  = Icons.visibility_outlined;
  bool obScure = true;
  void changePasswordVisibility()
  {
    obScure = !obScure;
    suffix = obScure ? Icons.visibility_outlined :  Icons.visibility_off_outlined;
    emit(RegisterChangePasswordVisibilityState());
  }





  void userRegister({
    required String name,
    required String email,
    required String password,
    required double weight,
    required double height,
    required double goalWeight,
    required String gender,
    required String? goal,
    required String? active,
    required int age,
    required double weeklyGoal,


  })
  {
    emit(RegisterLoadingState());
    FirebaseAuth.instance.
    createUserWithEmailAndPassword
      (
        email: email.trim(),
        password: password,
    ).then((value) {
      if(profileImage == null)
      {
        userCreate(
          name: name,
          email: email.trim(),
          uId: value.user!.uid,
          weight: weight,
          height: height,
          goalWeight: goalWeight,
          gender: gender,
          goal: goal,
          active: active,
          age:age,
          weeklyGoal:weeklyGoal,
        );
      }else
      {
        uploadProfileImage(
            name: name,
            email: email,
            uId: value.user!.uid,
            weight: weight,
            height: height,
            goalWeight: goalWeight,
            gender: gender,
            goal: goal,
            active: active,
            weeklyGoal: weeklyGoal,
            age: age,
        );
      }


    }).catchError((error){
      emit(RegisterErrorState(error.toString()));
      print(error.toString());


    });

  }

  void userCreate({
  required String name,
    required String email,
    required String uId,
    required double weight,
    required double height,
    required double goalWeight,
    required String gender,
    required String? goal,
    required String? active,
    required double weeklyGoal,
    required int age,
    String? profileImage,

  })
  {
    UserModel model = UserModel(
      name: name,
      uId: uId,
      email: email.trim(),
      weight: weight,
      height: height,
      gender: gender,
      goalWeight: goalWeight,
      profileImage:profileImage??'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png' ,
      active:active ,
      goal: goal,
      status: 'user',
      age: age,
      weeklyGoal: weeklyGoal,
    );
    print(profileImage.toString());
    FirebaseFirestore.instance.
    collection('users').
    doc(uId).
    set(model.toMap()).
    then((value) {
      emit(CreateUserSuccessState(uId));
    }).
    catchError((error)
    {
      emit(CreateUserErrorState(error));
      print(error.toString());
    });

  }

  File? profileImage;
  ImagePicker? picker = ImagePicker();
  Future? getProfileImage() async {
    final pickedFile = await picker?.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(RegisterImagePickerSuccessState());
    } else {
      print('No Image Selected');
      emit(RegisterImagePickerErrorState());
    }
  }

  void uploadProfileImage ({
        required String name,
        required String email,
        required String uId,
        required double weight,
        required double height,
        required double goalWeight,
        required String gender,
        required String? goal,
        required String? active,
        required double weeklyGoal,
        required int age,
  })
  {
    emit(RegisterLoadingState());
    firebase_storage.FirebaseStorage.instance.
    ref().
    child('users/${Uri.file(profileImage!.path).pathSegments.last}').
    putFile(profileImage!).
    then((value) {
      value.ref.getDownloadURL().
      then((value) {
        userCreate(
            name: name,
            email: email,
            uId: uId,
            weight: weight,
            height: height,
            goalWeight: goalWeight,
            gender: gender,
            goal: goal,
            active: active,
            weeklyGoal: weeklyGoal,
            age: age,
            profileImage: value,
        );
      }).catchError((error){
        emit(RegisterUploadProfileImageErrorState());
      });
    }).catchError((error){
      emit(RegisterUploadProfileImageErrorState());
    });
  }


}