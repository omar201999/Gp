import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/layout/admin_layout/cubit/states.dart';
import 'package:gp/models/recipes_model.dart';
import 'package:gp/models/user_model.dart';
import 'package:gp/modules/admin/admin_dashboard/dashboard_screen.dart';
import 'package:gp/modules/admin/market_management/market_management.dart';
import 'package:gp/modules/admin/recipe_management/recipes_management_screen.dart';
import 'package:gp/modules/admin/users_management/users_management.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

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
    where('status',isEqualTo: 'user').
    get().
    then((value)
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



  ImagePicker? picker = ImagePicker();

  File? recipeImage;

  Future? getRecipeImage() async {
    final pickedFile = await picker?.pickImage(
        source: ImageSource.gallery
    );

    if (pickedFile != null ) {
      recipeImage = File(pickedFile.path);
      emit(RecipeImagePickedSuccessState());
    } else {
      print('No image selected');
      emit(RecipeImagePickedErrorState());
    }
  }

  void uploadRecipeImage({
    required String title,
    required double carbs,
    required double protein,
    required double fats,
    required double calories,
    required double weight,
    required String ingredients,
    required String directions,
    required String category,
     required int uId,
    //required int totalTime,
  }){
    emit(CreateRecipeLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('recipes/${Uri.file(recipeImage!.path).pathSegments.last}')
        .putFile(recipeImage!)
        .then((value){
      value.ref.getDownloadURL().then((value)
      {
       //print(value);

        createRecipe(
            title: title,
            recipeImage: value,
            carbs: carbs,
            protein: protein,
            fats: fats,
            calories: calories,
            weight: weight,
            ingredients: ingredients,
            directions: directions,
            category: category,
            uId: uId,
          //totalTime: totalTime
        );


      }).catchError((error)
      {
        emit(CreateRecipeErrorState());
      });
    }).catchError((error)
    {
      emit(CreateRecipeErrorState());
    });

  }


  void createRecipe({
    required String title,
    String? recipeImage,
    required double carbs,
    required double protein,
    required double fats,
    required double calories,
    required double weight,
    required String ingredients,
    required String directions,
    required String category,
    required int uId,
    //required int totalTime,
  }){
    emit(CreateRecipeLoadingState());
    RecipeModel model = RecipeModel(
        title: title,
        image: recipeImage,
        carbs: carbs,
        protein: protein,
        fats: fats,
        calories: calories,
        weight: weight,
        ingredients: ingredients,
        directions: directions,
         uId:uId,
        category: category

    );

    FirebaseFirestore.instance
        .collection('recipes')
        .doc()
        .set(model.toMap())
        .then((value){
      getBreakfastRecipe();
      getLunchRecipe();
      getDinnerRecipe();
          //print(uId1.toString());
      emit(CreateRecipeSuccessState());
    }).catchError((error)
    {
      emit(CreateRecipeErrorState());
    });

  }

  List<RecipeModel> breakfastRecipe = [];

  void getBreakfastRecipe()
  {
    FirebaseFirestore.instance
        .collection('recipes')
        .where('category',isEqualTo: 'breakfast')
        .get()
        .then((value) {
      value.docs.forEach((element)
      {
        breakfastRecipe.add(RecipeModel.fromJson(element.data()));
      });

      emit(GetAllBreakFastRecipeSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetAllBreakFastRecipeErrorState(error.toString()));
    });
  }
  List<RecipeModel> lunchRecipe = [];

  void getLunchRecipe()
  {
    FirebaseFirestore.instance
        .collection('recipes')
        .where('category',isEqualTo: 'lunch')
        .get()
        .then((value) {
      value.docs.forEach((element)
      {
        lunchRecipe.add(RecipeModel.fromJson(element.data()));
      });

      emit(GetAllLunchRecipeSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetAllLunchRecipeErrorState(error.toString()));
    });
  }
  List<RecipeModel> dinnerRecipe = [];

  void getDinnerRecipe()
  {
    FirebaseFirestore.instance
        .collection('recipes')
        .where('category',isEqualTo: 'dinner')
        .get()
        .then((value) {
      value.docs.forEach((element)
      {
        dinnerRecipe.add(RecipeModel.fromJson(element.data()));
      });

      emit(GetAllDinnerRecipeSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetAllDinnerRecipeErrorState(error.toString()));
    });
  }
  void deleteUser(String? uId){

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .delete()
        .then((value) {
      print('done');
    }).catchError((error){
      print(error.toString());
    });
  }


}