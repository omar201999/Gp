import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/layout/admin_layout/cubit/states.dart';
import 'package:gp/models/feedback_model.dart';
import 'package:gp/models/new_order_model.dart';
import 'package:gp/models/product_model.dart';
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


  int currentIndex = 0 ;
  List<Widget> screens = [
    DashboardScreen(),
    UsersManagementScreen(),
    RecipesManagementScreen(),
    MarketManagementScreen()
  ];
  List<String> titleAppBar = [
    'Dashboard',
    'Users',
    'Recipes',
    'Market'
  ];

  changeBottomNav(index) {
    currentIndex = index;
    emit(ChangeBottomNavState());
  }
  // cubit for user
  List<UserModel> users = [];
  void getUsers()
  {
    /*users = [];
    FirebaseFirestore.instance.collection('users').
    where('status',isEqualTo: 'user')
        .get()
        .then((value) {
      value.docs.forEach((element)
      {
        users.add(UserModel.fromJson(element.data()));
      });
      emit(AdminGetAllUsersSuccessState());

    }).catchError((error) {
      print(error.toString());
      emit(AdminGetAllUsersErrorState(error.toString()));
    });*/

    emit(AdminGetAllUsersLoadingState());
    FirebaseFirestore.instance.collection('users').
    where('status',isEqualTo: 'user')
        .snapshots()
        .listen((event)
    {
      users = [];
      event.docs.forEach((element) {
        users.add(UserModel.fromJson(element.data()));
      });
      emit(AdminGetAllUsersSuccessState());
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
    final pickedFile = await picker?.getImage(
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
    final pickedFile = await picker?.getImage(
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

  void uploadNewImage(String? recipeId,{
    required String title,
    required String ingredients,
    required String directions,
    required double calories,
    required double fats,
    required double carbs,
    required double protein,
    //required double weight,
    required num totalRating,
    required num averageRating,
    required num numOfRates,
    required String? category,
    required String? titleAr,
    required String? ingredientsAr,
    required String? directionsAr,
    //required bool? isFavorite,
    required String? uId,
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
          recipeId,
          title: title,
            ingredients: ingredients,
            directions: directions,
            calories: calories,
            fats: fats,
            carbs: carbs,
            protein: protein,
            //weight: weight,
            //uId: uId,
            category: category,
            newRecipeImage: value,
          totalRating: totalRating,
          averageRating: averageRating,
          numOfRates: numOfRates,
          uId: uId,
          directionsAr:directionsAr ,
            ingredientsAr:ingredientsAr ,
          titleAr:titleAr,
          //isFavorite: isFavorite
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

  void updateRecipe(String? recipeID,{
    required String title,
    required String ingredients,
    required String directions,
    required double calories,
    required double fats,
    required double carbs,
    required double protein,
    //required double weight,
    required num numOfRates,
    required num averageRating,
    required num totalRating,
    required String? category,
    required String? titleAr,
    required String? ingredientsAr,
    required String? directionsAr,
    required String? uId,
    //required bool? isFavorite,
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
     // weight: weight,
      //uId: uId,
      category: category,
      numOfRates:numOfRates,
      averageRating:averageRating ,
      totalRating: totalRating,
      titleAr:titleAr ,
      ingredientsAr:ingredientsAr ,
      directionsAr: directionsAr,
      uId: uId,
      //isFavorite: isFavorite
    );

    FirebaseFirestore.instance
    .collection('recipes')
    .doc(recipeID)
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
   // required double weight,
    required String ingredients,
    required String directions,
    required String category,
    required String titleAr,
    required String ingredientsAr,
    required String directionsAr,
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
            //weight: weight,
            ingredients: ingredients,
            directions: directions,
            category: category,
            titleAr: titleAr,
            ingredientsAr:ingredientsAr ,
            directionsAr: directionsAr,

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
  Future<void> createRecipe({
    required String title,
    String? recipeImage,
    required double carbs,
    required double protein,
    required double fats,
    required double calories,
    //required double weight,
    required String ingredients,
    required String directions,
    required String category,
    required String directionsAr,
    required String ingredientsAr,
    required String titleAr,
    //required int totalTime,
  })async
  {
    emit(CreateRecipeLoadingState());
    DocumentReference? recipe;
    RecipeModel model = RecipeModel(
        title: title.toLowerCase(),
        image: recipeImage,
        carbs: carbs,
        protein: protein,
        fats: fats,
        calories: calories,
       // weight: weight,
        ingredients: ingredients,
        directions: directions,
        //uId:uId,
        category: category,
        averageRating: 0 ,
        numOfRates: 0 ,
        totalRating:0 ,
      directionsAr: directionsAr,
      ingredientsAr:ingredientsAr ,
      titleAr: titleAr,
      //isFavorite: false
    );
    recipe = await FirebaseFirestore.instance
        .collection('recipes')
        .add(model.toMap());
    FirebaseFirestore.instance.collection('recipes').doc(recipe.id).update({
      'uId':recipe.id,
      'title':model.title,
      'image':model.image,
      'carbs':model.carbs,
      'protein':model.protein,
      'fats':model.fats,
      'calories':model.calories,
      //'weight':model.weight,
      'ingredients':model.ingredients,
      'directions':model.directions,
      'category':model.category,
      'totalRating' :model.totalRating,
      'numOfRates' :model.numOfRates,
      'averageRating' :model.averageRating,
      'titleAr' :model.titleAr,
      'directionsAr' :model.directionsAr,
      'ingredientsAr' :model.ingredientsAr,
      //'isFavorite' :model.isFavorite,
    }).then((value){
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
    FirebaseFirestore.instance
        .collection('recipes')
        .where('category',isEqualTo: 'breakfast')
        .snapshots()
        .listen((event) {
      breakfastRecipe = [];
      event.docs.forEach((element) {
        breakfastRecipe.add(RecipeModel.fromJson(element.data()));
      });
      emit(GetAllBreakFastRecipeSuccessState());
    });
  }
  List<RecipeModel> lunchRecipe = [];
  void getLunchRecipe()
  {
    emit(GetAllLunchRecipeLoadingState());
    lunchRecipe = [];
    FirebaseFirestore.instance
        .collection('recipes')
        .where('category',isEqualTo: 'lunch').snapshots().listen((event) {
      lunchRecipe = [];
      event.docs.forEach((element) {
        lunchRecipe.add(RecipeModel.fromJson(element.data()));
      });

      emit(GetAllLunchRecipeSuccessState());
    });
  }
  List<RecipeModel> dinnerRecipe = [];
  void getDinnerRecipe()
  {
    emit(GetAllDinnerRecipeLoadingState());
    FirebaseFirestore.instance
        .collection('recipes')
        .where('category',isEqualTo: 'dinner').snapshots().listen((event) {
      dinnerRecipe = [];
      event.docs.forEach((element) {
        dinnerRecipe.add(RecipeModel.fromJson(element.data()));
      });
      emit(GetAllDinnerRecipeSuccessState());
    });
  }
  List<RecipeModel> allRecipe = [];
  void getAllRecipe()
  {
    FirebaseFirestore.instance
        .collection('recipes')
        .snapshots()
        .listen((event) {
      allRecipe = [];
      event.docs.forEach((element) {
        allRecipe.add(RecipeModel.fromJson(element.data()));
      });
      emit(GetAllRecipeSuccessState());
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

  void getSearchRecipe(String value,lan)
  {
    if(lan=='en')
    {
      searchRecipe = [];
      searchRecipe = allRecipe.where((element) => element.title!.toLowerCase().contains(value.toLowerCase())).toList();
      emit(SearchRecipeSuccessState());
    }
    else
      {
        searchRecipe = [];
        searchRecipe = allRecipe.where((element) => element.titleAr!.contains(value)).toList();
        emit(SearchRecipeSuccessState());
      }

  }



  //cubit for product


  File? productImage;

  Future? getProductImage() async {
    final pickedFile = await picker?.getImage(
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

  Future? getNewProductImage() async {
    final pickedFile = await picker?.getImage(
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

  void uploadNewProductImage(String? id,{
    required String name,
    required String description,
    required int quantity,
    required double currentPrice,
    required double oldPrice,
    required double discount,
    required String? status ,
    required String? descriptionAr ,
    required String? nameAr ,
    required num totalRating,
    required num averageRating,
    required num numOfRates,
    //required bool isFavorite,

    //required String? uId,
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
          id,
          name: name,
          description: description,
          currentPrice: currentPrice,
          oldPrice: oldPrice,
          discount: discount,
          quantity: quantity,
          status: status,
          descriptionAr:descriptionAr ,
          nameAr: nameAr,
          //uId: uId,
          newProductImage: value,
          totalRating: totalRating,
          averageRating: averageRating,
          numOfRates: numOfRates,
            //isFavorite: isFavorite

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

  void updateProduct(String? id,{
    required String name,
    required String description,
    required int quantity,
    required double currentPrice,
    required double oldPrice,
    required double discount,
    required String? status,
    required String? descriptionAr,
    required String? nameAr,
    String? newProductImage,
    required num numOfRates,
    required num averageRating,
    required num totalRating,
    //required bool isFavorite,
    //required String? uId,
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
      status: status,
      descriptionAr:descriptionAr ,
      nameAr:nameAr ,
      numOfRates:numOfRates,
      averageRating:averageRating ,
      totalRating: totalRating,
      //isFavorite: isFavorite,
      //uId: uId,

    );

    FirebaseFirestore.instance
        .collection('products')
        .doc(id)
        .update(model.toMap())
        .then((value) {
      emit(UpdateProductsSuccessState());
          getProducts();
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
    required String nameAr,
    required String descriptionAr,
    String? status,
    //required String uId,
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
          //uId:uId,
          status: status,
            nameAr:nameAr ,
            descriptionAr: descriptionAr
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
    required String descriptionAr,
    required String nameAr,
    //required String uId,
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
        //uId:uId,
        status: status,
      descriptionAr:descriptionAr ,
      nameAr: nameAr,
      averageRating: 0 ,
      numOfRates: 0 ,
      totalRating:0 ,
      //isFavorite: false,

    );

    FirebaseFirestore.instance
        .collection('products')
        //.doc(uId.toString())
        .add(model.toMap())
        .then((value){

      //print(uId1.toString());
      emit(CreateProductSuccessState());
    }).catchError((error)
    {
      emit(CreateProductErrorState());
    });

  }

  List<ProductModel> products = [];
  List<String> productsIDs = [];
  void getProducts()
  {
    emit(GetProductsLoadingState());
    FirebaseFirestore.instance
        .collection('products')
        .snapshots()
        .listen((event) {
      products = [];
      productsIDs = [];
      event.docs.forEach((element) {
        productsIDs.add(element.id);
        products.add(ProductModel.fromJson(element.data()));
      });

      emit(GetProductsSuccessState());
    });
  }

  void deleteProduct(String? id){
    FirebaseFirestore.instance
        .collection('products')
        .doc(id)
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
  void getSearchProduct(String value,lan)
  {
    if(lan == 'en') {
      searchProduct = [];
      searchProduct = products.where((element) => element.name!.toLowerCase().contains(value.toLowerCase())).toList();
      emit(SearchProductSuccessState());
    }else{
      searchProduct = [];
      searchProduct = products.where((element) => element.nameAr!.contains(value)).toList();
      emit(SearchProductSuccessState());
    }
  }

  List<ProductModel> stockProducts = [];
  void countStockProducts()
  {
   /* .get()
      .then((value) {
  value.docs.forEach((element) {
  stockProducts.add(ProductModel.fromJson(element.data()));
  });
  emit(GetDashboardProductsSuccessState());
  }).catchError((error) {
  emit(GetDashboardProductsErrorState());
  });*/
    emit(GetStockProductsLoadingState());
    FirebaseFirestore.instance
        .collection('products')
        .where('status', isEqualTo: 'inStock').snapshots().listen((event) {
      stockProducts = [];
      event.docs.forEach((element) {
        stockProducts.add(ProductModel.fromJson(element.data()));
      });
      emit(GetDashboardProductsSuccessState());
    });

  }


  List<NewOrderModel> newOrders = [];
  List<NewOrderModel> confirmedOrders = [];
  List<NewOrderModel> canceledOrders = [];

  void getOrders()
  {
    emit(AdminGetAllOrdersLoadingState());
    {
      newOrders = [];
      confirmedOrders = [];
      canceledOrders = [];
      FirebaseFirestore.instance
          .collection('orders')
          .orderBy('dateTime',descending: true)
          .get()
          .then((value) {
            for (var element in value.docs) {
              if(element.get('status') == 'new')
              {
                newOrders.add(NewOrderModel.fromJson(element.data()));
              }
              else if(element.get('status') == 'confirmed') {
                confirmedOrders.add(NewOrderModel.fromJson(element.data()));
              }
              else {
                canceledOrders.add(NewOrderModel.fromJson(element.data()));
              }
            }

            emit(AdminGetAllOrdersSuccessState());
      }).catchError((error){
        emit(AdminGetAllOrdersErrorState(error.toString()));
        print(error.toString());
      });
    }
  }


 void updateStatusOfOrders(String id,{
  required String status,
   int? quantity,
   String? productName,
   String? dateTime,
   String? phone,
   String? address,
   String? orderId,
   String? orderNumber,
   String? userName,
   double? totalPrice,
   double? total,
   double? shipping,
   String? userEmail,
   required int? month,
   List<dynamic>? cardItemList,
})
  {
    FirebaseFirestore.instance
        .collection('orders')
        .doc(id)
        .update({
      'orderId':orderId,
      'userName': userName,
      'totalPrice': totalPrice,
      'shipping': shipping,
      'total': total,
      'phone': phone,
      'address': address,
      'dateTime': dateTime,
      'status': status,
      'productName': productName,
      'quantity': quantity,
      'userEmail': userEmail,
      'orderNumber': orderNumber,
      'cardItemList' : cardItemList?.toList(),
      'month' : month
    })
        .then((value) {
      getOrders();
    }).catchError((error){
      emit(UpdateOrdersErrorState(error.toString()));
      print(error.toString());
    });
  }

  List<FeedBackModel> feedback = [];

  void getFeedBack()
  {
    FirebaseFirestore.instance
        .collection('feedback')
        .snapshots()
        .listen((event) {
       event.docs.forEach((element) {
         feedback.add(FeedBackModel.fromjson(element.data()));
       });
       emit(AdminGetAllFeedbackSuccessState());
    });
  }
  double averageRateApp =0;
  double averageRate()
  {
    averageRateApp =0;
    for(int i =0 ; i < feedback.length; i++)
    {
      averageRateApp = averageRateApp + (feedback[i].rating)!.round() ;
    }
    return averageRateApp / feedback.length ;
  }
  int yesAchievementCount =0;
  int yesAchievement()
  {
    yesAchievementCount =0;
    for(int i =0 ; i < feedback.length; i++)
    {
      if(feedback[i].goalAchieve == 'yes')
      {
        yesAchievementCount = yesAchievementCount + 1;
      }

    }
    return yesAchievementCount ;
  }

  int partiallyAchievementCount =0;
  int partiallyAchievement()
  {
    partiallyAchievementCount =0;
    for(int i =0 ; i < feedback.length; i++)
    {
      if(feedback[i].goalAchieve == 'partially')
      {
        partiallyAchievementCount = partiallyAchievementCount + 1;
      }

    }
    return partiallyAchievementCount ;
  }

  int noAchievementCount =0;
  int noAchievement()
  {
    noAchievementCount =0;
    for(int i =0 ; i < feedback.length; i++)
    {
      if(feedback[i].goalAchieve == 'no')
      {
        noAchievementCount = noAchievementCount + 1;
      }

    }
    return noAchievementCount ;
  }

double countConfirmedOrders(int month) {
 double quantity = 0;
 for(int i = 0; i < confirmedOrders.length; i++) {
   if (confirmedOrders[i].month == month) {
       quantity++;
   }
 }
  return quantity;
}

}