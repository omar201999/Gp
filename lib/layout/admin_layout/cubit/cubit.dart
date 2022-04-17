import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/layout/admin_layout/cubit/states.dart';
import 'package:gp/models/product_model.dart';
import 'package:gp/models/recipes_model.dart';
import 'package:gp/models/user_model.dart';
import 'package:gp/modules/admin/admin_dashboard/dashboard_screen.dart';
import 'package:gp/modules/admin/market_management/market_management.dart';
import 'package:gp/modules/admin/recipe_management/recipes_management_screen.dart';
import 'package:gp/modules/admin/users_management/users_management.dart';
import 'package:gp/shared/componants/constant.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class AdminCubit extends Cubit<AdminStates>
{
  AdminCubit() : super(AdminInitialState());

  static AdminCubit get(context) => BlocProvider.of(context);

  UserModel? adminModel;
  void getAdminData() {
    emit(GetAdminDataLoadingState());
    FirebaseFirestore.instance.
    collection('users').
    doc(uId).
    get().
    then((value) {
      adminModel = UserModel.fromJson(value.data());
      emit(GetAdminDataSuccessState());
    }).catchError((error) {
      emit(GetAdminDataErrorState(error));
      print(error.toString());
    });
  }
  int currentIndex = 0 ;
  List<Widget> screens = [
    DashboardScreen(),
    UsersManagementScreen(),

    //NotificationsScreen(),
    RecipesManagementScreen(),
    MarketManagementScreen()
  ];



  changeBottomNav(index) {
    currentIndex = index;
    emit(ChangeBottomNavState());
  }


  void getAdminData() {
    emit(GetAdminDataLoadingState());
    FirebaseFirestore.instance.
    collection('users').
    doc('60G1SVVEz9OulifBubcr6YdqAti1').
    get().
    then((value) {
      model = UserModel.fromJson(value.data());
      emit(GetAdminDataSuccessState());
    }).catchError((error) {
      emit(GetAdminDataErrorState(error));
      print(error.toString());
    });
  }

  List<UserModel> users = [];

  void getUsers()
  {
    emit(AdminGetAllUsersLoadingState());
    users = [];
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

  void deleteUser(String? uId)
  {
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .delete()
        .then((value) {
          getUsers();
    }).catchError((error){
      emit(AdminDeleteUsersErrorState(error.toString()));
      print(error.toString());
    });
  }

  List<UserModel> searchUsers = [];

  void getSearchUsers(String value)
  {
    searchUsers = [] ;
    searchUsers = users.where((element) => element.name!.toLowerCase().contains(value.toLowerCase())).toList();
    emit(SearchUsersSuccessState());

  }

 //cubit for recipe

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

  File? newRecipeImage;

  Future? getNewRecipeImage() async {
    final pickedFile = await picker?.pickImage(
        source: ImageSource.gallery
    );

    if (pickedFile != null ) {
      newRecipeImage = File(pickedFile.path);
      emit(ImagePickedSuccessState());
    } else {
      print('No image selected');
      emit(ImagePickedErrorState());
    }
  }

  void uploadNewImage({
    required String title,
    required String ingredients,
    required String directions,
    required double calories,
    required double fats,
    required double carbs,
    required double protein,
    required double weight,
    required String? uId,
    required String? category,
})
  {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('recipes/${Uri.file(newRecipeImage!.path).pathSegments.last}')
        .putFile(newRecipeImage!)
        .then((value){
      value.ref.getDownloadURL().then((value)
      {
        updateRecipe(
            title: title,
            ingredients: ingredients,
            directions: directions,
            calories: calories,
            fats: fats,
            carbs: carbs,
            protein: protein,
            weight: weight,
            uId: uId,
            category: category,
            newRecipeImage: value,
        );
      }).catchError((error)
      {
        print(error.toString());
        emit(UploadNewRecipeImageErrorState(error.toString()));
      });
    }).catchError((error)
    {
      print(error.toString());
      emit(UploadNewRecipeImageErrorState(error.toString()));
    });
  }

  void updateRecipe({
    required String title,
    required String ingredients,
    required String directions,
    required double calories,
    required double fats,
    required double carbs,
    required double protein,
    required double weight,
    required String? uId,
    required String? category,
    String? newRecipeImage,
})
  {
    RecipeModel model = RecipeModel(
      title: title,
      image: newRecipeImage,
      ingredients: ingredients,
      directions: directions,
      calories: calories,
      fats: fats,
      carbs: carbs,
      protein: protein,
      weight: weight,
      uId: uId,
      category: category,

    );

    FirebaseFirestore.instance
    .collection('recipes')
    .doc(uId)
    .update(model.toMap())
    .then((value) {
      //emit(UpdateRecipeSuccessState());
      getBreakfastRecipe();
     getLunchRecipe();
     getDinnerRecipe();
    }).catchError((error){

      emit(UpdateRecipeErrorState(error.toString()));
      print(error.toString());
    });

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
     required String? uId,
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
    required String? uId,
    //required int totalTime,
  }){
    emit(CreateRecipeLoadingState());
    RecipeModel model = RecipeModel(
        title: title.toLowerCase(),
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
        .doc(uId)
        .set(model.toMap())
        .then((value){

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
    emit(GetAllBreakFastRecipeLoadingState());
    breakfastRecipe = [];
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
    emit(GetAllLunchRecipeLoadingState());
    lunchRecipe = [];
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
    emit(GetAllDinnerRecipeLoadingState());
    dinnerRecipe = [];
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
      emit(GetAllDinnerRecipeErrorState(error.toString()));
      print(error.toString());

    });
  }
  List<RecipeModel> allRecipe = [];
  void getAllRecipe()
  {
    allRecipe = [];
    FirebaseFirestore.instance
        .collection('recipes')
        .get()
        .then((value) {
      value.docs.forEach((element)
      {
        allRecipe.add(RecipeModel.fromJson(element.data()));
      });
      emit(GetAllRecipeSuccessState());
    }).catchError((error) {
      emit(GetAllRecipeErrorState(error.toString()));
      print(error.toString());

    });
  }

  void deleteRecipe(String? uId){
    FirebaseFirestore.instance
        .collection('recipes')
        .doc(uId)
        .delete()
        .then((value) {
          getBreakfastRecipe();
          getLunchRecipe();
          getDinnerRecipe();
          getAllRecipe();
    }).catchError((error){
      emit(AdminDeleteRecipeErrorState(error.toString()));
      print(error.toString());
    });
  }

  void removeRecipeImage() {
    recipeImage = null;
    emit(RemoveRecipeImageState());
  }

  List<RecipeModel> searchRecipe = [];

  void getSearchRecipe(String value)
  {
    searchRecipe = [];
    searchRecipe = allRecipe.where((element) => element.title!.toLowerCase().contains(value.toLowerCase())).toList();
    emit(SearchRecipeSuccessState());
  }



  //cubit for product


  File? productImage;

  Future? getProductImage() async {
    final pickedFile = await picker?.pickImage(
        source: ImageSource.gallery
    );

    if (pickedFile != null ) {
      productImage = File(pickedFile.path);
      emit(ProductImagePickedSuccessState());
    } else {
      print('No image selected');
      emit(ProductImagePickedErrorState());
    }
  }

  File? newProductImage;

  Future? getnewProductImage() async {
    final pickedFile = await picker?.pickImage(
        source: ImageSource.gallery
    );

    if (pickedFile != null ) {
      newProductImage = File(pickedFile.path);
      emit(ImagePickedSuccessState());
    } else {
      print('No image selected');
      emit(ImagePickedErrorState());
    }
  }

  void uploadNewProductImage({
    required String name,
    required String description,
    required int quantity,
    required double currentPrice,
    required double oldPrice,
    required double discount,

    required String? uId,
  })
  {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('products/${Uri.file(newProductImage!.path).pathSegments.last}')
        .putFile(newProductImage!)
        .then((value){
      value.ref.getDownloadURL().then((value)
      {
        updateProduct(
          name: name,
          description: description,
          currentPrice: currentPrice,
          oldPrice: oldPrice,
          discount: discount,
          quantity: quantity,

          uId: uId,
          newProductImage: value,
        );
      }).catchError((error)
      {
        print(error.toString());
        emit(UploadNewProductImageErrorState(error.toString()));
      });
    }).catchError((error)
    {
      print(error.toString());
      emit(UploadNewProductImageErrorState(error.toString()));
    });
  }

  void updateProduct({
    required String name,
    required String description,
    required int quantity,
    required double currentPrice,
    required double oldPrice,
    required double discount,
    String? newProductImage,
    required String? uId,
  })
  {
    ProductModel model = ProductModel(
      name: name,
      image: newProductImage,
      description: description,
      currentPrice: currentPrice,
      oldPrice: oldPrice,
      discount: discount,
      quantity: quantity,

      uId: uId,

    );

    FirebaseFirestore.instance
        .collection('products')
        .doc(uId)
        .update(model.toMap())
        .then((value) {
      //emit(UpdateRecipeSuccessState());

    }).catchError((error){

      emit(UpdateRecipeErrorState(error.toString()));
      print(error.toString());
    });

  }



  void uploadProductImage({
    required String name,
    required double currentPrice,
    required double oldPrice,
    required double discount,
    required int quantity,
    required String description,
    String? status,
    required String uId,
    //required int totalTime,
  }){
    emit(CreateProductLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('products/${Uri.file(productImage!.path).pathSegments.last}')
        .putFile(productImage!)
        .then((value){
      value.ref.getDownloadURL().then((value)
      {
        //print(value);

        createProduct(
          name: name,
          productImage: value,
          currentPrice: currentPrice,
          oldPrice: oldPrice,
          discount: discount,
          quantity: quantity,
          description: description,
          uId:uId,
          status: status
        );


      }).catchError((error)
      {
        emit(CreateProductErrorState());
      });
    }).catchError((error)
    {
      emit(CreateProductErrorState());
    });

  }


  void createProduct({
    required String name,
    String? productImage,
    required double currentPrice,
    required double oldPrice,
    required double discount,
    required int quantity,
    required String description,
    required String uId,
    String? status,

  }){
    emit(CreateProductLoadingState());
    ProductModel model = ProductModel(
        name: name,
        image: productImage,
        currentPrice: currentPrice,
        oldPrice: oldPrice,
        discount: discount,
        quantity: quantity,
        description: description,
        uId:uId,
        status: status

    );

    FirebaseFirestore.instance
        .collection('products')
        .doc(uId.toString())
        .set(model.toMap())
        .then((value){

      //print(uId1.toString());
      emit(CreateProductSuccessState());
    }).catchError((error)
    {
      emit(CreateProductErrorState());
    });

  }

  List<ProductModel> products = [];
  void getProducts()
  {
    emit(GetProductsLoadingState());
    products = [];
    FirebaseFirestore.instance.collection('products')
        .get()
        .then((value) {
          value.docs.forEach((element) {
            products.add(ProductModel.fromJson(element.data()));
          });
         emit(GetProductsSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetProductsErrorState(error.toString()));
    });
  }

  void deleteProduct(String? uId){
    FirebaseFirestore.instance
        .collection('products')
        .doc(uId)
        .delete()
        .then((value) {
          getProducts();
    }).catchError((error){
      emit(AdminDeleteProductErrorState(error.toString()));
      print(error.toString());
    });
  }

  void removeProductImage() {
    productImage = null;
    emit(RemoveRecipeImageState());
  }


  List<ProductModel> searchProduct = [];
  void getSearchProduct(String value)
  {
    searchProduct = [];
    searchProduct = products.where((element) => element.name!.toLowerCase().contains(value.toLowerCase())).toList();
    emit(SearchProductSuccessState());

  }

  List<ProductModel> stockProducts = [];
  void countStockProducts()
  {
    emit(GetStockProductsLoadingState());
    FirebaseFirestore.instance
        .collection('products')
        .where('status', isEqualTo: 'inStock')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        stockProducts.add(ProductModel.fromJson(element.data()));
      });
      emit(GetDashboardProductsSuccessState());
    }).catchError((error) {
      emit(GetDashboardProductsErrorState());
    });
  }


 List<ProductModel> orders = [];

  void getOrders()
  {
    emit(AdminGetAllOrdersLoadingState());
    orders = [];
    FirebaseFirestore.instance.collection('orders')
        .get().then((value)
    {
      value.docs.forEach((element)
      {
        orders.add(ProductModel.fromJson(element.data()));
      });
      emit(AdminGetAllOrdersSuccessState());

    }).catchError((error) {
      print(error.toString());
      emit(AdminGetAllOrdersErrorState(error.toString()));
    });
  }

}