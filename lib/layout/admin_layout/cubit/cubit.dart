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
    required num totalRating,
    required num averageRating,
    required num numOfRates,
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
          totalRating: totalRating,
          averageRating: averageRating,
          numOfRates: numOfRates
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
    required num numOfRates,
    required num averageRating,
    required num totalRating,
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
      numOfRates:numOfRates,
      averageRating:averageRating ,
      totalRating: totalRating,
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
        category: category,
        averageRating: 0 ,
        numOfRates: 0 ,
        totalRating:0 ,
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
    /*.get()
      .then((value) {
  value.docs.forEach((element)
  {
  breakfastRecipe.add(RecipeModel.fromJson(element.data()));
  });

  emit(GetAllBreakFastRecipeSuccessState());
  }).catchError((error) {
  print(error.toString());
  emit(GetAllBreakFastRecipeErrorState(error.toString()));
  });*/

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
    FirebaseFirestore.instance
        .collection('products')
        .snapshots()
        .listen((event) {
      products = [];
      event.docs.forEach((element) {
        products.add(ProductModel.fromJson(element.data()));
      });
      emit(GetProductsSuccessState());
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
  List<String> ordersNewId = [];
  List<String> ordersConfirmedId = [];
  List<String> ordersCanceledId = [];


  void getOrders()
  {
    /*.get()
      .then((value)
    {
    for (var element in value.docs) {
    orders.add(NewOrderModel.fromJson(element.data()));
    }
    emit(AdminGetAllOrdersSuccessState());
    print(orders);
    }).catchError((error) {
  emit(AdminGetAllOrdersErrorState(error.toString()));
  print(orders);
  print(error.toString());
  //print(orders);
  });*/
    emit(AdminGetAllOrdersLoadingState());
    {
      newOrders = [];
      confirmedOrders = [];
      canceledOrders = [];
      ordersNewId = [];
      ordersConfirmedId = [];
      ordersCanceledId = [];
      FirebaseFirestore.instance
          .collection('orders')
          //.where('status', isEqualTo: status)
          .orderBy('dateTime',descending: true)
          .get()
          .then((value) {
            for (var element in value.docs) {
              if(element.get('status') == 'new')
              {
                ordersNewId.add(element.id);
                newOrders.add(NewOrderModel.fromJson(element.data()));
              }
              else if(element.get('status') == 'confirmed') {
                ordersConfirmedId.add(element.id);
                confirmedOrders.add(NewOrderModel.fromJson(element.data()));
              }
              else {
                ordersCanceledId.add(element.id);
                canceledOrders.add(NewOrderModel.fromJson(element.data()));
              }
            }

            //print(newOrders.toString());
            //print(newOrders.length);
            //print(newOrders[0].cardItemList);
            //print(newOrders);
           // print(newOrders[0].orderId);
            //print(canceledOrders.length);
            //print(confirmedOrders.length);
            //getOrderId();
            emit(AdminGetAllOrdersSuccessState());
      }).catchError((error){
        emit(AdminGetAllOrdersErrorState(error.toString()));
        print(error.toString());
      });
        /*  .snapshots()
          .listen((event) {
        newOrders = [];
        confirmedOrders = [];
        canceledOrders = [];
        ordersId = [];
        for (var element in event.docs) {
          if(status == 'new') {
            ordersId.add(element.id);
            newOrders.add(NewOrderModel.fromJson(element.data()));
          } else if(status == 'confirmed') {
            ordersId.add(element.id);
            confirmedOrders.add(NewOrderModel.fromJson(element.data()));
          }
          else {
            ordersId.add(element.id);
            canceledOrders.add(NewOrderModel.fromJson(element.data()));
          }
        }
        print(ordersId.toString());
        print(newOrders.length);
        print(canceledOrders.length);
        print(confirmedOrders.length);

        emit(AdminGetAllNewOrdersSuccessState());
      });*/
    }
  }

 /* List<String> ordersId = [];
  void getOrderId()
  {
    ordersId = [];
    FirebaseFirestore.instance
        .collection('orders')
        .get()
        .then((value) {
          value.docs.forEach((element)
          {
            ordersId.add(element.id);
          });
      print(ordersId.toString());
    }).catchError((error){
      print(error.toString());
    });
  }*/

 void updateStatusOfOrdres(String id,{
  required String status,
   int? quantity,
   String? productName,
   String? dateTime,
   String? phone,
   String? address,
   String? orderId,
   String? userName,
   double? totalPrice,
   double? total,
   double? shipping,
   List<dynamic>? cardItemList,
})
  {
    NewOrderModel model = NewOrderModel(
      status: status,
      quantity: quantity,
      productName:productName,
      dateTime: dateTime,
      address:address ,
      orderId: orderId,
      phone:phone ,
      shipping:shipping ,
      total: total,
      totalPrice: totalPrice,
      userName:userName,
      cardItemList:cardItemList ,
    );
    FirebaseFirestore.instance
        .collection('orders')
        .doc(id)
        .update(model.toMap())
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

 /*
 List<ProductModel> productsOrders = [];
  void getProductsOrders({
    String? id
  })
  {
    //emit(AdminGetAllOrdersLoadingState());
    for(int i =0 ; i < orders.length; i++ )
    {
      productsOrders = [];
      FirebaseFirestore.instance
          .collection('orders')
          .doc(ordersId[i])
          .collection('products')
          .get()
          .then((value)
      {
        value.docs.forEach((element)
        {
          productsOrders.add(ProductModel.fromJson(element.data()));
        });
        for(int i=0; i<productsOrders.length;i++)
        {
          print(productsOrders[i].name);
        }
        emit(AdminGetAllProductsOrdersSuccessState());

        print(productsOrders);
        print(orders.length);
        print(ordersId);
      }).catchError((error) {
        emit(AdminGetAllProductsOrdersErrorState(error.toString()));
        print(error.toString());
      });
    }
    }
*/

}