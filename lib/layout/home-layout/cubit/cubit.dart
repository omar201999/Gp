import 'dart:io';
import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/layout/home-layout/cubit/states.dart';
import 'package:gp/models/feedback_model.dart';
import 'package:gp/models/meals_model.dart';
import 'package:gp/models/new_order_model.dart';
import 'package:gp/models/order-model.dart';
import 'package:gp/models/product_model.dart';
import 'package:gp/models/recipes_model.dart';
import 'package:gp/models/user_model.dart';
import 'package:gp/modules/user/customer_dashboard/CustomerDashBoard_Screen.dart';
import 'package:gp/modules/user/home/home_screen.dart';
import 'package:gp/modules/user/market/MarketScreen.dart';
import 'package:gp/modules/user/recipe/recipe_screen.dart';
import 'package:gp/shared/componants/componants.dart';
import 'package:gp/shared/componants/constant.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage ;



class HomeCubit extends Cubit<HomeStates> {

  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);
  UserModel? userModel;
  void getUserData()
 {
   emit(GetUserDataLoadingState());
   FirebaseFirestore.instance.
   collection('users').
   doc(uId).
   get().then((value)
   {
    userModel = UserModel.fromJson(value.data());
 emit(GetUserDataSuccessState());
 }).catchError((error) {
 emit(GetUserDataErrorState(error.toString()));
 print(error.toString());
 });
 }
  /*Future<DocumentSnapshot> getUserData() async{
    emit(GetUserDataLoadingState());
    DocumentSnapshot x = await FirebaseFirestore.instance.
    collection('users').
    doc(uId).
    get();
    userModel = UserModel.fromJson(x.data());
    return x;
    *//*.
    then((value) {
      userModel = UserModel.fromJson(value.data());
      emit(GetUserDataSuccessState());
    }).catchError((error) {
      emit(GetUserDataErrorState(error));
      print(error.toString());
    });*//*
  }*/

  int currentIndex = 0;
  List<Widget> bodyScreen =
  [
    HomePage(),
    MarketingScreen(),
    RecipeScreen(),
    CustomerDashBoardScreen(),
  ];
  List<String> titleAppBar =
  [
    'Home',
    'Market',
    'Recipe',
    'Me'
  ];

  void changeBottomNavBar(int index) {
    currentIndex = index;
    emit(HomeChangeBottomNavState());
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

  void uploadProfileImage({
    required String name,
    required int age,
    required double goalWeight,
    required double weight,
  }) {
    emit(UploadProfileImageLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri
        .file(profileImage!.path)
        .pathSegments
        .last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL()
          .then((value) {
        print(value);
        updateUser(
          weight: weight,
          name: name,
          age: age,
          goalWeight: goalWeight,
          profileImage: value,
        );
      })
          .catchError((error) {
        emit(UploadProfileImageErrorState());
      });
    })
        .catchError((error) {
      emit(UploadProfileImageErrorState());
    });
  }


  void updateUser({
    double? height,
    String? name,
    double? active,
    int? age,
    String? goal,
    double? goalWeight,
    String? profileImage,
    double? weight,
    int? totalWater,
    int? totalCalorie,
    int? totalCarbs,
    int? totalFats,
    int? totalProtein,
    String? phone,
    String? address,
  }) {
    UserModel model = UserModel(
      height: userModel!.height,
      profileImage: profileImage ?? userModel!.profileImage,
      uId: userModel!.uId,
      name: name ?? userModel!.name,
      email: userModel!.email,
      active: userModel!.active,
      age: age ?? userModel!.age,
      gender: userModel!.gender,
      goal: userModel!.goal,
      goalWeight: goalWeight ?? userModel!.goalWeight,
      status: userModel!.status,
      weeklyGoal: userModel!.weeklyGoal,
      totalCalorie: userModel!.totalCalorie,
      totalCarbs: userModel!.totalCarbs,
      totalFats: userModel!.totalFats,
      totalProtein: userModel!.totalProtein,
      weight: weight ?? userModel!.weight,
      totalWater: userModel!.totalWater ?? totalWater,
      phone: phone ?? userModel!.phone,
      address: address ?? userModel!.address,
      userActive: true,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
     //emit(UpdateUserDataSuccessState());
    })
        .catchError((error) {
      emit(UpdateUserDataErrorState());
    });
  }


  List<MealsModel> allMeals = [];

  void getAllMeals() {
    FirebaseFirestore.instance
        .collection('meals')
        .snapshots()
        .listen((event) {
      event.docs.forEach((element) {
        allMeals.add(MealsModel.fromJson(element.data()));
      });
     /* for(int i=0 ; i<allMeals.length;i++)
      {
        print(allMeals[i].ar);
      }*/
      emit(GetALlMealsSuccessState());
    });
  }

  List<MealsModel> searchBreakFast = [];

  void getSearchBreakFast(String value,String lan) {
    if(lan == 'en') {
      searchBreakFast = [];
      searchBreakFast = allMeals.where((element) => element.Food!.toLowerCase().contains(value.toLowerCase())).toList();
      emit(SearchSuccessBreakFastState());
    }else{
      searchBreakFast = [];
      searchBreakFast = allMeals.where((element) => element.foodAr!.contains(value)).toList();
      emit(SearchSuccessBreakFastState());
    }
  }

  List<MealsModel> searchLunch = [];

  void getSearchLunch(String value,String lan)
  {
    if(lan == 'en')
    {
      searchLunch = [];
      searchLunch = allMeals.where((element) => element.Food!.toLowerCase().contains(value.toLowerCase())).toList();
      emit(SearchSuccessLunchState());
    } else
      {
        searchLunch = [];
        searchLunch = allMeals.where((element) => element.foodAr!.contains(value)).toList();
        emit(SearchSuccessBreakFastState());
      }
  }

  List<MealsModel> searchDinner = [];

  void getSearchDinner(String value,String lan)
  {
    if(lan=='en')
    {
      searchDinner = [];
      searchDinner = allMeals
          .where((element) =>
              element.Food!.toLowerCase().contains(value.toLowerCase()))
          .toList();
      emit(SearchSuccessDinnerState());
    }else
      {
        searchDinner = [];
        searchDinner = allMeals.where((element) => element.foodAr!.contains(value)).toList();
        emit(SearchSuccessBreakFastState());
      }
  }

  List<MealsModel> searchSnacks = [];

  void getSearchSnacks(String value,String lan)
  {
    if(lan=='en')
    {
      searchSnacks = [];
      searchSnacks = allMeals
          .where((element) =>
              element.Food!.toLowerCase().contains(value.toLowerCase()))
          .toList();
      emit(SearchSuccessSnacksState());
    } else
      {
        searchSnacks = [];
        searchSnacks = allMeals.where((element) => element.foodAr!.contains(value)).toList();
        emit(SearchSuccessBreakFastState());
      }
  }
  List<MealsModel> searchPredictedMeal = [];

  void getSearchPredictedMeal(String value) {
    searchPredictedMeal = [];
    searchPredictedMeal = allMeals.where((element) => element.Food!.toLowerCase() == value.toLowerCase()).toList();
    print(value.toLowerCase());
    emit(SearchPredictedMealState());
  }

  List<bool> isCheckedBreakFast = List<bool>.filled(334, false);

  void changeCheckBoxBreakFast(value, index) {
    isCheckedBreakFast[index] = value;

    emit(ChangeCheckBoxState());
  }

  List<bool> isCheckedLunch = List<bool>.filled(334, false);

  void changeCheckBoxLunch(value, index) {
    isCheckedLunch[index] = value;
    emit(ChangeCheckBoxState());
  }

  List<bool> isCheckedDinner = List<bool>.filled(334, false);

  void changeCheckBoxDinner(value, index) {
    isCheckedDinner[index] = value;

    emit(ChangeCheckBoxState());
  }

  List<bool> isCheckedSnacks = List<bool>.filled(334, false, growable: true);

  void changeCheckBoxSnacks(value, index) {
    isCheckedSnacks[index] = value;
    emit(ChangeCheckBoxState());
  }

  void addSnacksMeal() {
    int i = 0;
    for (i; isCheckedSnacks.length > 0; i++) {
      if (isCheckedSnacks[i] == true) {
        FirebaseFirestore.instance
            .collection('users')
            .doc(userModel!.uId)
            .collection('userMeal')
            .add(searchSnacks[i].toMap())
            .then((value) {
          //emit(SearchAddSnacksSuccessState());
          calculateTotalFoodCalories();
          isCheckedSnacks = List<bool>.filled(334, false, growable: true);
          getCompleteDiaryItems();
        }).catchError((error) {
          emit(SearchAddSnacksErrorState(error.toString()));
          print(error.toString());
        });
      }
    }
  }

  void addLunchMeal() {
    int i = 0;
    for (i; isCheckedLunch.length > 0; i++) {
      if (isCheckedLunch[i] == true) {
        FirebaseFirestore.instance
            .collection('users')
            .doc(userModel!.uId)
            .collection('userMeal')
            .add(searchLunch[i].toMap())
            .then((value) {
          isCheckedLunch = List<bool>.filled(334, false, growable: true);

          //emit(SearchAddLunchSuccessState());
          calculateTotalFoodCalories();
          getCompleteDiaryItems();
        }).catchError((error) {
          emit(SearchAddLunchErrorState(error.toString()));
          print(error.toString());
        });
      }
    }
  }

  void addBreakFastMeal() {
    int i = 0;
    for (i; isCheckedBreakFast.length > 0; i++) {
      if (isCheckedBreakFast[i] == true) {
        FirebaseFirestore.instance
            .collection('users')
            .doc(userModel!.uId)
            .collection('userMeal')
            .add(searchBreakFast[i].toMap())
            .then((value) {
          isCheckedBreakFast = List<bool>.filled(334, false, growable: true);

          //emit(SearchAddBreakFastSuccessState());
          calculateTotalFoodCalories();

          getCompleteDiaryItems();
        }).catchError((error) {
          emit(SearchAddBreakFastErrorState(error.toString()));
          print(error.toString());
        });
      }
    }
  }

  void addDinnerMeal() {
    int i = 0;
    for (i; isCheckedDinner.length > 0; i++) {
      if (isCheckedDinner[i] == true) {
        FirebaseFirestore.instance
            .collection('users')
            .doc(userModel!.uId)
            .collection('userMeal')
            .add(searchDinner[i].toMap())
            .then((value) {
          isCheckedDinner = List<bool>.filled(334, false, growable: true);
          //emit(SearchAddDinnerSuccessState());
          calculateTotalFoodCalories();

          getCompleteDiaryItems();
        }).catchError((error) {
          emit(SearchAddDinnerErrorState(error.toString()));
          print(error.toString());
        });
      }
    }
  }

  void addRecipeToMeals({
    required num calories,
    required num carbs,
    required num fat,
    required num protein,
    required String? title,


  }) {
    MealsModel model = MealsModel(
      Food: title,
      Measure: 'Follow the Recipe',
      Calories: calories,
      Carbs: carbs,
      Fat: fat,
      Protein: protein,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('userMeal')
        .add(model.toMap())
        .then((value) {
      calculateTotalFoodCalories();
      getCompleteDiaryItems();
    }).catchError((error) {
      emit(AddRecipeToMealErrorState(error.toString()));
      print(error.toString());
    });
  }

  List<bool> isCheckeditem = List<bool>.filled(100, false);

  void changeCheckBoxitem(value, index) {
    isCheckeditem[index] = value;

    emit(ChangeCheckBoxState());
  }

  List<MealsModel> completeDiary = [];
  List<String> completeDiaryId = [];

  void getCompleteDiaryItems() {
    emit(GetAllUsersMealsLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId!)
        .collection('userMeal')
        .snapshots()
        .listen((event) {
      completeDiary = [];
      completeDiaryId = [];
      event.docs.forEach((element) {
        completeDiaryId.add(element.id);
        completeDiary.add(MealsModel.fromJson(element.data()));
      });
      emit(GetAllUsersMealsSuccessState());
    });
  }

  void deleteCompleteDiaryItem(String? id) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('userMeal')
        .doc(id).delete()
        .then((value) {
      getCompleteDiaryItems();
    }).catchError((error) {
      emit(GetAllUsersMealsErrorState(error.toString()));
      print(error.toString());
    });
  }

  int counter = 0;
  int maximum = 16;
  int gaolGlass = 8;
  double countLiter = 0.0;

  int addWaterGlass() {
    if (counter < maximum) {
      counter++;
      if (counter == gaolGlass) {
        showToast(
            text: 'Great job! You\'re reached your goal.',
            state: ToastStates.SUCCESS
        );
      }
      if (counter == gaolGlass + 1) {
        showToast(
            text: 'Remember to drink more if you\'re thirsty or if you exercise.',
            state: ToastStates.NOTE
        );
      }
      userModel!.totalWater = counter;

      emit(AddWaterGlassState());
    }
    return counter;
  }

  double addCountLiter() {
    if (counter < maximum) countLiter += 0.25;
    return countLiter;
  }

  double minusCountLiter() {
    if (counter > 0) countLiter -= 0.25;
    return countLiter;
  }

  int minusWaterGlass() {
    if (counter > 0) {
      counter--;
      userModel!.totalWater = counter;
      emit(MinusWaterGlassState());
    }

    return counter;
  }

  void addCartItem(String? prodId, {
    required String? name,
    String? image,
    int? quantity,
    required double? currentPrice,
    required double? oldPrice,
    required double? discount,
    required int? selectedQuantity,
    required String? description,
    //required String? uId1,
    required String? status,
    required String? descriptionAr,
    required String? nameAr,

  }) {
    ProductModel model = ProductModel(
      name: name,
      image: image,
      quantity: quantity,
      description: description,
      currentPrice: currentPrice,
      oldPrice: oldPrice,
      discount: discount,
      selectedQuantity: selectedQuantity,
      //uId: uId1,
      status: status,
      descriptionAr:descriptionAr ,
      nameAr: nameAr
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('yourCart')
        .doc(prodId)
        .set(model.toMap())
        .then((value) {
      updateProductForOneBuy(
          prodId,
        name: name,
        quantity: quantity,
        status: status,
        currentPrice:currentPrice,
        description: description,
        discount: discount,
        oldPrice: oldPrice,
        selectedQuantity:selectedQuantity ,
        image:image,
        nameAr: nameAr,
        descriptionAr: descriptionAr
      );
      getCartItem();
      //emit(AddCartItemSuccessState());

    }).catchError((error) {
      emit(AddCartItemErrorState(error));
      print(error.toString());
    });

  }


  void updateCartItem(String? prodId, {
    required String? name,
    String? image,
    required double? currentPrice,
    required double? oldPrice,
    required double? discount,
    required int? quantity,
    required int? selectedQuantity,
    required String? description,
    required String? status,
    //required String? uId1,
  }) {
    ProductModel model = ProductModel(
      name: name,
      image: image,
      description: description,
      status: status,
      currentPrice: currentPrice,
      oldPrice: oldPrice,
      discount: discount,
      quantity: quantity,
      selectedQuantity: selectedQuantity,
      //uId: uId1,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('yourCart')
        .doc(prodId)
        .update(model.toMap())
        .then((value) {
      getCartItem();
      //emit(UpdateCartItemSuccessState());

    }).catchError((error) {
      emit(UpdateCartItemErrorState(error));
      print(error.toString());
    });
  }

  List<ProductModel> cart = [];
  List<String> cartId=[];

  void getCartItem() {
    //emit(GetCartItemLoadingState());
    cartId=[];
    cart = [];
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('yourCart')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        cartId.add(element.id);
        cart.add(ProductModel.fromJson(element.data()));
      });
      emit(GetCartItemSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetCartItemErrorState(error.toString()));
    });
  }


  /* getTotalPrice(){
    double total = 0.0;
    cart.forEach((element) {
      total += (element.currentPrice)!.round() * (element.quantity)!.round();

    });
    return total;
  }*/

  void deleteCartItem(String? cartId) {
    FirebaseFirestore.instance.collection('users').doc(uId)
        .collection('yourCart').doc(cartId).delete()
        .then((value) {
      getCartItem();
      //emit(DeleteCartItemSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(DeleteCartItemErrorState(error.toString()));
    });
  }

  List <int> Counter = List<int>.filled(50, 1);

  void minus(index) {
    if (Counter[index] > 0) {
      Counter [index] --;
      emit(minusState());
    }
  }

  void plus(index) {
    if (Counter[index] < (cart[index].quantity)!.round()) {
      Counter [index] ++;
      emit(plusState());
    }
  }


  int selectedQuantity = 1;

  int addQuantity(ProductModel productModel) {
    if (selectedQuantity < productModel.quantity!.toInt()) {
      selectedQuantity++;
      //productModel!.selectedQuantity = selectedQuantity;
      emit(AddQuantityState());
    }
    return selectedQuantity;
  }

  int minusQuantity() {
    if (selectedQuantity > 1) {
      selectedQuantity--;
      //productModel!.selectedQuantity = selectedQuantity;
      emit(MinusQuantityState());
    }

    return selectedQuantity;
  }

  int initSelectedQuantity() {
    selectedQuantity =1;
    return selectedQuantity;
  }
  int? productQuantity;

  int? addStockQuantity(ProductModel model) {
    productQuantity = model.quantity! + model.selectedQuantity!.toInt();
    return productQuantity;
  }

 /* void updateQuantityProduct({
    required int? quantity,
    required int? selectedQuantity,
    String? status,
    String? name,
    String? image,
    String? description,
    double? discount,
    double? oldPrice,
    double? currentPrice,
    String? uId
}) {
    ProductModel model = ProductModel(
      name: name,
      image: image,
      description: description,
      oldPrice: oldPrice,
      discount: discount,
      currentPrice: currentPrice,
      quantity: quantity,
      selectedQuantity: selectedQuantity,
      status: status,
      uId: uId

    );

    FirebaseFirestore.instance
        .collection('products')
        .doc(uId)
        .update(model.toMap())
        .then((value) {
          getProducts();
          emit(UpdateProductSuccessState());
    }).catchError((error) {
      emit(UpdateProductsErrorState(error.toString()));
      print(error.toString());
    });
  }*/

  void updateProductForOneBuy(String? prodId, {
    required String? name,
    String? image,
    required double? currentPrice,
    required double? oldPrice,
    required double? discount,
    required int? quantity,
    required int? selectedQuantity,
    required String? description,
    //required String? uId,
    required String? status,
    required String? descriptionAr,
    required String? nameAr,

  }) {
    ProductModel model = ProductModel(
        name: name,
        image: image,
        description: description,
        currentPrice: currentPrice,
        oldPrice: oldPrice,
        discount: discount,
        quantity: quantity,
        selectedQuantity: selectedQuantity,
        //uId: uId,
        status: status,
      descriptionAr:descriptionAr ,
      nameAr: nameAr,
    );

    FirebaseFirestore.instance
        .collection('products')
        .doc(prodId)
        .update(model.toMap())
        .then((value) {
      getProducts();
      //emit(UpdateCartItemSuccessState());
    }).catchError((error) {
      emit(UpdateCartItemErrorState(error.toString()));
      print(error.toString());
    });
  }


 /* void addProductToOrders() {
    int i = 0;
    for (i; i < cart.length; i++) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(userModel!.uId)
          .collection('orders')
          .add(cart[i].toMap())
          .then((value) {
        //getCartItem();
        emit(AddCartItemSuccessState());
      }).catchError((error) {
        emit(AddCartItemErrorState(error));
        print(error.toString());
      });
    }
  }*/

  int totalFood = 0;

  int? calculateTotalFoodCalories() {
    totalFood = 0;
    for (int i = 0; i <= completeDiary.length - 1; i++) {
      totalFood = totalFood + (completeDiary[i].Calories)!.round();
    }
    if (totalFood >= (userModel!.totalCalorie)!.round()) {
      //totalFood = 0;
      print('the biggest $totalFood');
      return totalFood;
    }
    else {
      print('the smallest $totalFood');
      return totalFood;
    }
  }

  num totalProtein = 0;

  num totalCarbs = 0;

  num totalFats = 0;

  num calculateTotalProtein() {
    totalProtein = 0;
    for (int i = 0; i <= completeDiary.length - 1; i++) {
      totalProtein = totalProtein + (completeDiary[i].Protein)!.round();
    }
    return totalProtein;
  }

  num calculateTotalCarbs() {
    totalCarbs = 0;
    for (int i = 0; i <= completeDiary.length - 1; i++) {
      totalCarbs = totalCarbs + (completeDiary[i].Carbs)!.round();
    }
    return totalCarbs;
  }

  num calculateTotalFats() {
    totalFats = 0;
    for (int i = 0; i <= completeDiary.length - 1; i++) {
      totalFats = totalFats + (completeDiary[i].Fat)!.round();
    }
    return totalFats;
  }


  double totalPrice = 0;
  double calculateTotalPriceOfCartItems() {
    totalPrice = 0;
    for (int i = 0; i < cart.length; i++) {
      totalPrice = totalPrice + (cart[i].currentPrice)!.round() * (cart[i].selectedQuantity)!.round();
    }

    return totalPrice;
  }

/*
 Future<void> createOrder ({
    required double totalPrice,
    required double total,

}) async{
    OrderModel createOrder = OrderModel(
      userName: userModel!.name,
      total: total,
      totalPrice: totalPrice,
      shipping: 100,
      phone: userModel!.phone,
      address: userModel!.address,
      dateTime: DateTime.now().toString(),

    );
    DocumentReference x = await FirebaseFirestore.instance
           .collection('orders')
          .add(createOrder.toMap());
    for (int i = 0; i < cart.length; i++) {
      await FirebaseFirestore.instance
          .collection('orders')
          .doc(x.id)
          .collection('products')
          .add(cart[i].toMap());
    }
    emit(CreateOrderSuccessState());
  }*/
  int creatOrderNumberForOneBuy()
  {
    return Random().nextInt(1000);
  }
/*  updateProductForOneBuy(
  prodId,
  name: name,
  currentPrice: currentPrice,
  oldPrice: oldPrice,
  discount: discount,
  quantity: quantity,
  selectedQuantity: selectedQuantity,
  description: description,
  //uId: uId,
  image: image,
  status: status
  );*/
/*      .then((value) {

  }).catchError((error){
  emit(GetProductsErrorState(error.toString()));
  print(error.toString());
  });*/
  Future<void> createOrderForOneProduct ({
    required double totalPrice,
    required double total,
    required String productName,
    required int quantity,
    required int selectedQuantity,
    //required int quantityAfterBuy,
    required String prodId,
    required String image,
    //required String uId,
    required String description,
    required double currentPrice,
    required double oldPrice,
    required double discount,
    required String name,
    required String status,
    required String nameAr,
    required String descriptionAr,

  }) async{
    DocumentReference? orderForOneProduct;
    OrderModel createOrderForOneProduct = OrderModel(
      orderNumber: creatOrderNumberForOneBuy().toString(),
      userEmail: userModel!.email,
      userName: userModel!.name,
      total: total,
      totalPrice: totalPrice,
      shipping: 100,
      phone: userModel!.phone,
      address: userModel!.address,
      dateTime: DateTime.now().toString(),
      productName: productName,
      quantity: selectedQuantity,
      productNameAr: nameAr,
      status: 'new'

    );
    orderForOneProduct = await FirebaseFirestore.instance
        .collection('orders')
        .add(createOrderForOneProduct.toMap());
    FirebaseFirestore.instance.collection('orders').doc(orderForOneProduct.id).update({
      'orderId':orderForOneProduct.id,
      'orderNumber':createOrderForOneProduct.orderNumber,
      'userName': createOrderForOneProduct.userName,
      'totalPrice': createOrderForOneProduct.totalPrice,
      'shipping':createOrderForOneProduct.shipping,
      'total': createOrderForOneProduct.total,
      'phone':createOrderForOneProduct.phone,
      'address': createOrderForOneProduct.address,
      'dateTime': createOrderForOneProduct.dateTime,
      'productName': createOrderForOneProduct.productName,
      'quantity': createOrderForOneProduct.quantity,
      'status': createOrderForOneProduct.status,
      'userEmail': createOrderForOneProduct.userEmail,
      'productNameAr': createOrderForOneProduct.productNameAr,


    }).then((value) {
      updateProductForOneBuy(
          prodId,
          name: name,
          currentPrice: currentPrice,
          oldPrice: oldPrice,
          discount: discount,
          quantity: quantity,
          selectedQuantity: selectedQuantity,
          description: description,
          //uId: uId,
          image: image,
          status: status,
        descriptionAr:descriptionAr ,
        nameAr: nameAr
      );
      getOrdersForUser();
    }).catchError((error){
      emit(GetProductsErrorState(error.toString()));
      print(error.toString());
    });


    //emit(CreateOrderSuccessState());
  }
  int creatOrderNumber()
  {
    return Random().nextInt(1000);
  }

  Future<void> createOrderModel ({
    required double totalPrice,
    required double total,
    //required List<dynamic>? cart,
  }) async{
    DocumentReference? order;
    NewOrderModel createOrder = NewOrderModel(
      userName: userModel!.name,
      userEmail: userModel!.email,
      total: total,
      totalPrice: totalPrice,
      shipping: 100,
      phone: userModel!.phone,
      address: userModel!.address,
      dateTime: DateTime.now().toString(),

      /*
      name: e['name'],
      image: e['image'],
      description: e['description'],
      currentPrice: e['currentPrice'],
      oldPrice: e['oldPrice'],
      discount: e['discount'],
      quantity: e['quantity'],
      status: e['status'],
      uId: e['uId'],
      */
      cardItemList: cart,
      status: 'new',
      orderNumber: creatOrderNumber().toString(),

    );
     order = await FirebaseFirestore.instance
        .collection('orders')
        .add(createOrder.toMap());
       FirebaseFirestore.instance.collection('orders').doc(order.id).update({
         'orderId':order.id,
         'userName': createOrder.userName,
         'totalPrice': createOrder.totalPrice,
         'shipping': createOrder.shipping,
         'total':createOrder.total,
         'phone': createOrder.phone,
         'address':createOrder.address,
         'dateTime':createOrder.dateTime,
         'status': createOrder.status,
         'productName':createOrder.productName,
         'quantity': createOrder.quantity,
         'userEmail': createOrder.userEmail,
         'orderNumber':createOrder.orderNumber,
         'cardItemList' :cart.map((e) => e.toMap()).toList(),
       }).then((value) {
         getOrdersForUser();
         //emit(CreateOrderSuccessState());
       }).catchError((error){
         emit(CreateOrderErrorState(error.toString()));
         print(error.toString());
       });
       //print(creatOrderNumber().toString());
       //updateProductForCartItem();


  }

  File? feedBackImage;
  Future? getFeedbackImage() async {
    final pickedFile = await picker!.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      feedBackImage = File(pickedFile.path);
      emit(GetFeedBackImageSuccessState());
    } else {
      emit(GetFeedBackImageErrorState());
    }
  }
  void removeFeedBackImage() {
    feedBackImage = null;
    emit(RemoveFeedBackImageState());
  }
  void uploadFeedBackImage({
    required String feedback,
    required String goalAchieve,
    required double rating,
  }) {
    emit(UploadProfileImageLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('feedback/${Uri.file(feedBackImage!.path).pathSegments.last}').putFile(feedBackImage!)
        .then((value) {
      value.ref.getDownloadURL()
          .then((value) {
        createFeedBack(
         rating: rating,
          feedbackImage:value ,
          feedback: feedback,
            goalAchieve: goalAchieve
        );
      })
          .catchError((error) {
        emit(UploadFeedBackImageErrorState(error.toString()));
      });
    })
        .catchError((error) {
      emit(UploadFeedBackImageErrorState(error.toString()));
    });
  }
  void createFeedBack({
  required String feedback,
  required String goalAchieve,
   String? feedbackImage,
  required double rating,

})
  {
    FeedBackModel model = FeedBackModel(
      userName:userModel!.name,
      userEmail: userModel!.email,
      userImage: userModel!.profileImage,
      feedback: feedback,
      feedbackImage:feedbackImage ,
      rating: rating,
      goalAchieve:goalAchieve

    );
    FirebaseFirestore.instance
        .collection('feedback')
        .add(model.toMap())
        .then((value) {
          emit(CreateFeedBackSuccessState());
    }).catchError((error){
      emit(CreateFeedBackErrorState(error.toString()));
      print(error.toString());
    });
  }
  void updateRecipe(String Id,{
    required num totalRating,
    required num averageRating,
    required num numOfRates,
    required String uId,
    required String image,
    required double calories,
    required double carbs,
    required String category,
    required String directions,
    required String titleAr,
    required String ingredientsAr,
    required String directionsAr,
    required double fats,
    required String ingredients,
    required double protein,
    required String title,
    //5required double weight,

  })
  {
    RecipeModel model = RecipeModel(
     totalRating: totalRating,
      averageRating:averageRating ,
      numOfRates: numOfRates,
      uId:uId ,
      image:image ,
      calories: calories,
      carbs:carbs ,
      category:category ,
      directions:directions ,
      fats:fats ,
      ingredients:ingredients ,
      protein:protein ,
      title:title ,
     titleAr: titleAr,
     ingredientsAr:ingredientsAr ,
     directionsAr:directionsAr
     // weight:weight ,
    );
    FirebaseFirestore.instance
        .collection('recipes').doc(Id).update(model.toMap())
        .then((value) {
      emit(UpdateRecipeSuccessState());
    }).catchError((error){
      emit(UpdateRecipeErrorState(error.toString()));
      print(error.toString());
    });
  }
  List<ProductModel> products = [];
  List<String> productsIDs = [];
  void getProducts()
  {
    emit(GetProductLoadingState());
    products = [];
    productsIDs = [];
    FirebaseFirestore.instance.collection('products')
        .get()
        .then((value) {
      value.docs.forEach((element) {
            products.add(ProductModel.fromJson(element.data()));
            productsIDs.add(element.id);
          });
          emit(GetProductSuccessState());
        }).catchError((error) {
          print(error.toString());
          emit(GetProductErrorState(error.toString()));
          emit(GetProductsSuccessState());
        });
      }

  List<NewOrderModel> newOrders = [];
  List<NewOrderModel> confirmedOrders = [];
  List<NewOrderModel> canceledOrders = [];
  void getOrdersForUser()
  {

    emit(GetAllOrdersLoadingState());
    {
      newOrders = [];
      confirmedOrders = [];
      canceledOrders = [];
      FirebaseFirestore.instance
          .collection('orders')
          .orderBy('dateTime',descending: true)
          .get()
          .then((value) {
        for (var element in value.docs)
        {
          if(element.get('userName') == userModel!.name)
          {
            if(element.get('status') == 'new')
            {
              newOrders.add(NewOrderModel.fromJson(element.data()));
            }
            else if(element.get('status') == 'confirmed')
            {
              confirmedOrders.add(NewOrderModel.fromJson(element.data()));
            }
            else {
              canceledOrders.add(NewOrderModel.fromJson(element.data()));
            }
          }

        }
       emit(GetAllOrdersSuccessState());
      }).catchError((error){
       // emit(AdminGetAllOrdersErrorState(error.toString()));
        print(error.toString());
      });
    }
  }





/*List<OrderModel> orders = [];
  List<String> ordersId = [];
  void getOrdersId()
  {
    //emit(AdminGetAllOrdersLoadingState());
    ordersId = [];
    FirebaseFirestore.
    instance.
    collection('orders').
    get().
    then((value)
    {
      value.docs.forEach((element)
      {
        ordersId.add(element.id);
        print(ordersId);
      });
      emit(GetOrderIdSuccessState());
    }).catchError((error) {

      emit(GetOrderIdErrorState());
      print(error.toString());
    });
  }*/


}



