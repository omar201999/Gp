import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/layout/home-layout/cubit/states.dart';
import 'package:gp/models/meals_model.dart';
import 'package:gp/models/product_model.dart';
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

  HomeCubit() : super(HomeIntitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  UserModel? userModel;

  void getUserData() {
    emit(GetUserDataLoadingState());
    FirebaseFirestore.instance.
    collection('users').
    doc(uId).
    get().
    then((value) {
      userModel = UserModel.fromJson(value.data());
      emit(GetUserDataSuccessState());
    }).catchError((error) {
      emit(GetUserDataErrorState(error));
      print(error.toString());
    });
  }

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
    emit(HomeChangeBottonNavState());
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
    int? totalProtein
  }) {
    UserModel model = UserModel(
      height: userModel!.height,
      profileImage: profileImage ?? userModel!.profileImage,
      uId: userModel!.uId,
      name: name,
      email: userModel!.email,
      active: userModel!.active,
      age: age,
      gender: userModel!.gender,
      goal: userModel!.goal,
      goalWeight: goalWeight,
      status: userModel!.status,
      weeklyGoal: userModel!.weeklyGoal,
      totalCalorie: userModel!.totalCalorie,
      totalCarbs: userModel!.totalCarbs,
      totalFats: userModel!.totalFats,
      totalProtein: userModel!.totalProtein,
      weight: weight,
      totalWater: userModel!.totalWater ?? totalWater,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
    })
        .catchError((error) {
      emit(UpdateUserDataErrorState());
    });
  }

  List<ProductModel> products = [];

  void getProduct() {
    FirebaseFirestore.instance
        .collection('products')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        products.add(ProductModel.fromJson(element.data()));
      });

      emit(protienSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(protienErrorState(error.toString()));
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
      emit(GetALlMealsSuccessState());
    });
  }

  List<MealsModel> searchBreakFast = [];

  void getSearchBreakFast(String value) {
    searchBreakFast = [];
    searchBreakFast = allMeals.where((element) =>
        element.Food!.toLowerCase().contains(value.toLowerCase())).toList();
    emit(SearchSuccessBreakFastState());
  }

  List<MealsModel> searchLunch = [];

  void getSearchLunch(String value) {
    emit(SearchLoadingLunchState());
    searchLunch = [];
    searchLunch = allMeals.where((element) =>
        element.Food!.toLowerCase().contains(value.toLowerCase())).toList();
    emit(SearchSuccessLunchState());
  }

  List<MealsModel> searchDinner = [];

  void getSearchDinner(String value) {
    searchDinner = [];
    searchDinner = allMeals.where((element) =>
        element.Food!.toLowerCase().contains(value.toLowerCase())).toList();
    emit(SearchSuccessDinnerState());
  }

  List<MealsModel> searchSnacks = [];

  void getSearchSnacks(String value) {
    emit(SearchLoadingSnacksState());
    searchSnacks = [];
    searchSnacks = allMeals.where((element) =>
        element.Food!.toLowerCase().contains(value.toLowerCase())).toList();
    emit(SearchSuccessSnacksState());
  }

  List<bool> isCheckedBreakFast = List<bool>.filled(50, false);

  void changeCheckBoxBreakFast(value, index) {
    isCheckedBreakFast[index] = value;

    emit(ChangeCheckBoxState());
  }

  List<bool> isCheckedLunch = List<bool>.filled(334, false);

  void changeCheckBoxLunch(value, index) {
    isCheckedLunch[index] = value;
    emit(ChangeCheckBoxState());
  }

  List<bool> isCheckedDinner = List<bool>.filled(50, false);

  void changeCheckBoxDinner(value, index) {
    isCheckedDinner[index] = value;

    emit(ChangeCheckBoxState());
  }

  List<bool> isCheckedSnacks = List<bool>.filled(50, false, growable: true);

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
        .doc(uId)
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
    required double? currentPrice,
    required double? oldPrice,
    required double? discount,
    required int? quantity,
    required String? description,
    required String? uId1,
  }) {
    ProductModel model = ProductModel(
      name: name,
      image: image,
      description: description,
      currentPrice: currentPrice,
      oldPrice: oldPrice,
      discount: discount,
      quantity: quantity,
      uId: uId1,
      userName: userModel!.name,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('yourCart')
        .doc(prodId)
        .set(model.toMap())
        .then((value) {
      getCartItem();
      emit(AddCartItemSuccessState());

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
    required String? description,
    required String? uId1,
  }) {
    ProductModel model = ProductModel(
      name: name,
      image: image,
      description: description,
      currentPrice: currentPrice,
      oldPrice: oldPrice,
      discount: discount,
      quantity: quantity,
      uId: uId1,
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

  void getCartItem() {
    emit(GetCartItemLoadingState());
    cart = [];
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('yourCart')
        .get()
        .then((value) {
      value.docs.forEach((element) {
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
      emit(DeleteCartItemSuccessState());
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

  double totalPrice = 0;

  double calculateTotalPriceOfCartItems() {
    totalPrice = 0;
    for (int i = 0; i < cart.length; i++) {
      totalPrice = (totalPrice + (cart[i].currentPrice)!.round());
    }

    return totalPrice;
  }

  void addProductToOrders() {
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
  }

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


/*void createOrder ({
  /*
  void createOrder ({
    required double totalPrice,
    required double total,

}) {
    //emit(CreateOrderLoadingState());
    OrderModel createOrder = OrderModel(
      userName: userModel!.name,
      total: total,
      totalPrice: totalPrice,
      shipping: 100,
    );
      FirebaseFirestore.instance
          .collection('orders')
          .add(createOrder.toMap())
          .then((value)
      {
        //getOrdersId();
        addProductToOrders();
      })
          .catchError((error){
        emit(CreateOrderErrorState());
      });



  }


  List<OrderModel> orders = [];
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




*/
}
