import 'dart:io';

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
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage ;

import '../../../modules/register/cubit/states.dart';

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

  File? profileImage;
  ImagePicker? picker = ImagePicker();

  Future? getProfileImage() async {
    final pickedFile = await picker!.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(GetProfileImageSuccessState());
    } else {
      print('No Image Selected');
      emit(GetProfileImageErrorState());
    }
  }

  void uploadProfileImage (
      {
        required String name ,
        required int age ,
        required double goalWeight ,
        required double weight,
      }
      )
  {
    emit(UploadProfileImageLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value){
      value.ref.getDownloadURL()
          .then((value) {
        print(value);
        updateUser(
          weight: weight,
          name: name,
          age: age,
          goalWeight: goalWeight,
          profileImage: value ,
        );
      })
          .catchError((error){
        emit(UploadProfileImageErrorState());
      });
    })
        .catchError((error){
      emit(UploadProfileImageErrorState());
    });
  }


  void updateUser({
    double? height ,
    required String name ,
    String? active ,
    required int age ,
    String? goal,
    required double goalWeight ,
    String? profileImage ,
    required double weight ,
  }){
    UserModel model = UserModel(
      height: userModel!.height,
      profileImage: profileImage?? userModel!.profileImage,
      uId: userModel!.uId,
      name: name,
      email: userModel!.email,
      active: userModel!.active,
      age: age,
      gender: userModel!.gender,
      goal: userModel!.goal,
      goalWeight:goalWeight ,
      status: userModel!.status,
      weeklyGoal: userModel!.weeklyGoal,
      weight: weight,
    ) ;

    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
    })
        .catchError((error){
      emit(UpdateUserDataErrorState());
    });
  }
}