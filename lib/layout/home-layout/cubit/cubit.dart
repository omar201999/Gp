import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/layout/home-layout/cubit/states.dart';
import 'package:gp/models/meals_model.dart';
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
    int? totalProtein,
    int? totalCarbs,
    int? totalFats,

  }) {
    UserModel model = UserModel(
      height: userModel!.height,
      profileImage: profileImage ?? userModel!.profileImage,
      uId: userModel!.uId,
      name: name ?? userModel!.name,
      email: userModel!.email,
      active: active?? userModel!.active,
      age: age ?? userModel!.age,
      gender: userModel!.gender,
      goal: goal ?? userModel!.goal ,
      goalWeight: goalWeight ?? userModel!.goalWeight,
      status: userModel!.status,
      weeklyGoal: userModel!.weeklyGoal,
      totalCalorie: totalCalorie ?? userModel!.totalCalorie,
      totalCarbs: totalCarbs ?? userModel!.totalCarbs,
      totalFats: totalFats ?? userModel!.totalFats ,
      totalProtein: totalProtein ??userModel!.totalProtein ,
      weight: weight ?? userModel!.weight,
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

  List<RecipeModel> search = [];

  void getSearch(String value) {
    emit(SearchLoadingState());
    search = [];
    FirebaseFirestore.instance
        .collection('recipes')
        .where('title', isGreaterThanOrEqualTo: value)
        .where('title', isLessThan: value + 'z')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        search.add(RecipeModel.fromJson(element.data()));
      });
      emit(SearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SearchErrorState(error.toString()));
    });
  }

  List<MealsModel> searchBreakFast = [];

  void getSearchBreakFast(String value) {
    emit(SearchLoadingBreakFastState());
    searchBreakFast = [];
    FirebaseFirestore.instance
        .collection('meals')
        .where('Food', isGreaterThanOrEqualTo: value)
        .where('Food', isLessThan: value + 'z')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        searchBreakFast.add(MealsModel.fromJson(element.data()));
      });
      emit(SearchSuccessBreakFastState());
    }).catchError((error) {
      emit(SearchErrorBreakFastState(error.toString()));
      print(error.toString());
    });
  }

  List<MealsModel> searchLunch = [];

  void getSearchLunch(String value) {
    emit(SearchLoadingLunchState());
    searchLunch = [];
    FirebaseFirestore.instance
        .collection('meals')
        .where('Food', isGreaterThanOrEqualTo: value)
        .where('Food', isLessThan: value + 'z')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        searchLunch.add(MealsModel.fromJson(element.data()));
      });
      emit(SearchSuccessLunchState());
    }).catchError((error) {
      print(error.toString());
      emit(SearchErrorLunchState(error.toString()));
    });
  }

  List<MealsModel> searchDinner = [];

  void getSearchDinner(String value) {
    emit(SearchLoadingDinnerState());
    searchDinner = [];
    FirebaseFirestore.instance
        .collection('meals')
        .where('Food', isGreaterThanOrEqualTo: value)
        .where('Food', isLessThan: value + 'z')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        searchDinner.add(MealsModel.fromJson(element.data()));
      });
      emit(SearchSuccessDinnerState());
    }).catchError((error) {
      print(error.toString());
      emit(SearchErrorDinnerState(error.toString()));
    });
  }

  List<MealsModel> searchSnacks = [];

  void getSearchSnacks(String value) {
    emit(SearchLoadingSnacksState());
    searchSnacks = [];
    FirebaseFirestore.instance
        .collection('meals')
        .where('Food', isGreaterThanOrEqualTo: value)
        .where('Food', isLessThan: value + 'z')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        searchSnacks.add(MealsModel.fromJson(element.data()));
      });
      emit(SearchSuccessSnacksState());
    }).catchError((error) {
      print(error.toString());
      emit(SearchErrorSnacksState(error.toString()));
    });
  }

  List<ProductModel> searchitem = [];

  void getSearchitem(String value) {
    emit(SearchLoadingLunchState());
    searchitem = [];
    FirebaseFirestore.instance
        .collection('products')
        .where('name', isGreaterThanOrEqualTo: value)
        .where('name', isLessThan: value + 'z')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        searchitem.add(ProductModel.fromJson(element.data()));
      });
      emit(SearchitemState());
    }).catchError((error) {
      print(error.toString());
      emit(SearchErroritemState(error.toString()));
    });
  }

  List<bool> isCheckedBreakFast = List<bool>.filled(50, false);

  void changeCheckBoxBreakFast(value, index) {
    isCheckedBreakFast[index] = value;

    emit(ChangeCheckBoxState());
  }

  List<bool> isCheckedLunch = List<bool>.filled(50, false);

  void changeCheckBoxLunch(value, index) {
    isCheckedLunch[index] = value;

    emit(ChangeCheckBoxState());
  }

  List<bool> isCheckedDinner = List<bool>.filled(50, false);

  void changeCheckBoxDinner(value, index) {
    isCheckedDinner[index] = value;

    emit(ChangeCheckBoxState());
  }

  List<bool> isCheckedSnacks = List<bool>.filled(50, false,growable: true);

  void changeCheckBoxSnacks(value, index) {
    isCheckedSnacks[index] = value;
    emit(ChangeCheckBoxState());
  }

  void addSnacksMeal() {
    int i = 0;
    for ( i;isCheckedSnacks.length>0; i++) {
      if (isCheckedSnacks[i] == true) {
          FirebaseFirestore.instance
              .collection('users')
              .doc(userModel!.uId)
              .collection('userMeal')
              .add(searchSnacks[i].toMap())
              .then((value) {
                //emit(SearchAddSnacksSuccessState());
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
    for ( i;isCheckedLunch.length>0; i++) {
      if (isCheckedLunch[i] == true) {
        FirebaseFirestore.instance
            .collection('users')
            .doc(userModel!.uId)
            .collection('userMeal')
            .add(searchLunch[i].toMap())
            .then((value) {
          //emit(SearchAddLunchSuccessState());
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
    for ( i;isCheckedBreakFast.length>0; i++) {
      if (isCheckedBreakFast[i] == true) {
        FirebaseFirestore.instance
            .collection('users')
            .doc(userModel!.uId)
            .collection('userMeal')
            .add(searchBreakFast[i].toMap())
            .then((value) {
          //emit(SearchAddBreakFastSuccessState());
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
    for ( i;isCheckedDinner.length>0; i++) {
      if (isCheckedDinner[i] == true) {
        FirebaseFirestore.instance
            .collection('users')
            .doc(userModel!.uId)
            .collection('userMeal')
            .add(searchDinner[i].toMap())
            .then((value) {
         //emit(SearchAddDinnerSuccessState());
          getCompleteDiaryItems();
        }).catchError((error) {
          emit(SearchAddDinnerErrorState(error.toString()));
          print(error.toString());
        });
      }
    }
  }
  List<bool> isCheckeditem = List<bool>.filled(100, false);
  void changeCheckBoxitem(value, index) {
    isCheckeditem[index] = value;

    emit(ChangeCheckBoxState());
  }
  List<MealsModel> completeDiary = [];
  void getCompleteDiaryItems()
  {
    //emit(GetAllUsersMealsLoadingState());
    completeDiary = [];
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('userMeal')
        .get()
        .then((value)
    {
      value.docs.forEach((element)
      {
        completeDiary.add(MealsModel.fromJson(element.data()));
        emit(GetAllUsersMealsSuccessState());
      });
    }).catchError((error){
      emit(GetAllUsersMealsErrorState(error.toString()));
      print(error.toString());
    });
  }

  int counter = 0;
  int maximum = 16;
  int gaolGlass = 8;
  double countLiter = 0.0;
  int addWaterGlass () {
    if (counter < maximum) {
      counter++;
      if (counter == gaolGlass){
        showToast(
            text: 'Great job! You\'re reached your goal.',
            state: ToastStates.SUCCESS
        );
      }
      if (counter == gaolGlass+1){
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

  double addCountLiter () {
    if (counter < maximum) countLiter+=0.25;
      return countLiter;
  }

  double minusCountLiter () {
    if (counter > 0 ) countLiter-=0.25;
    return countLiter;
  }
  int minusWaterGlass () {

    if (counter > 0 ){
      counter--;
      userModel!.totalWater = counter;
      emit(MinusWaterGlassState());
    }

    return counter;
  }

  void addCartItem(String? prodId,{
    required String? name,
    String? image,
    required double? currentPrice,
    required double? oldPrice,
    required double? discount,
    required int? quantity,
    required String? description,
    required String? uId1,
  })
  {
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
        .set(model.toMap())
        .then((value) {
      getCartItem();
      emit(AddCartItemSuccessState());

    }).catchError((error) {
      emit(AddCartItemErrorState(error));
      print(error.toString());
    });

  }


  void updateCartItem(String? prodId,{
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

  void deleteCartItem(String? cartId){
    FirebaseFirestore.instance.collection('users').doc(uId)
        .collection('yourCart').doc(cartId).delete()
        .then((value) {
      getCartItem();
      emit(DeleteCartItemSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(DeleteCartItemErrorState(error.toString()));
    });
  }
  List <int> Counter = List<int>.filled(50,1) ;
  void minus (index)
  {
    if(Counter[index] > 0)
    {
      Counter [index] -- ;
      emit(minusState());
    }
  }
  void plus (index)
  {
    if(Counter[index] < (cart[index].quantity)!.round())
    {
      Counter [index] ++ ;
      emit(plusState());
    }
  }
  double totalPrice = 0 ;
  double calculateTotalPriceOfCartItems(){
    totalPrice = 0;
    for(int i = 0 ; i < cart.length ; i++){
      totalPrice = (totalPrice + (cart[i].currentPrice)!.round());
    }

    return totalPrice;
  }

  /*
  void createOrder ({
    required double totalPrice,
    required double total,
}) {
    emit(CreateOrderLoadingState());
    OrderModel createOrder = OrderModel(
      userId: uId,
      total: total,
      totalPrice: totalPrice,
      shipping: 100,
    );
    FirebaseFirestore.instance
    .collection('orders')
    .add(createOrder.toMap())
    .then((value){
      //addProductToOrders(postsId[]);
      emit(CreateOrderSuccessState());
    })
    .catchError((error){
      emit(CreateOrderErrorState());
    });
  }


  List<OrderModel> orders = [];
  List<String> ordersId = [];


  /*void getOrders()
  {
    emit(AdminGetAllOrdersLoadingState());
    orders = [];
    FirebaseFirestore.instance.collection('orders')
        .get().then((value)
    {
      value.docs.forEach((element)
      {
        orders.add(OrderModel.fromJson(element.data()));
        ordersId = [];
        ordersId.add(element.id);
      });
      emit(AdminGetAllOrdersSuccessState());

    }).catchError((error) {
      print(error.toString());
      emit(AdminGetAllOrdersErrorState(error.toString()));
    });
  }*/


  void addProductToOrders(String? prodId,{
    required String? name,
    String? image,
    required double? currentPrice,
    required double? oldPrice,
    required double? discount,
    required int? quantity,
    required String? description,
    required String? uId1,
  })
  {
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
    for(int i = 0 ; i < ordersId.length ; i++) {
      FirebaseFirestore.instance
          .collection('orders')
          .doc(ordersId[i])
          .collection('products')
          .add(model.toMap())
          .then((value) {
        //getCartItem();
        emit(AddCartItemSuccessState());
      }).catchError((error) {
        emit(AddCartItemErrorState(error));
        print(error.toString());
      });
    }
  }
  */

  List<String> ordersId = [] ;
  List<OrderModel> orders = [] ;

  void createOrder ({
    required double totalPrice,
    required double total,
  })
  {
    emit(CreateOrderLoadingState());
    OrderModel createOrder = OrderModel(
      totalPrice: totalPrice ,
      total: total,
      shipping: 100 ,
      userId: userModel!.uId ,
    );
    FirebaseFirestore.instance
    .collection('orders')
    .add(createOrder.toMap())
    .then((value){
      getOrders();
      emit(CreateOrderSuccessState());
    })
    .catchError((error){
      emit(CreateOrderErrorState());
    });
  }

  void getOrders(){
    FirebaseFirestore.instance
        .collection('orders')
        .get()
        .then((value){
          value.docs.forEach((element){
            element.reference.collection('products').get()
                .then((value) {
                  ordersId.add(element.id) ;
                  orders.add(OrderModel.fromJson(element.data()));
            })
                .catchError((error){});
          });
    })
        .catchError((error){});
  }

  void addProductToOrders (String orderId, {
    required String? name,
    String? image,
    required double? currentPrice,
    required double? oldPrice,
    required double? discount,
    required int? quantity,
    required String? description,
    String? uId1,
}){
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
    .collection('orders')
    .doc(orderId)
    .collection('products')
    .add(model.toMap())
    .then((value){})
    .catchError((error){});
}


  List<int> totalFoodCal = [];
  int totalCal = 0 ;
  int food()
  {
    totalFoodCal = [];
    totalCal = 0;
    completeDiary.forEach((element)
    {
      totalFoodCal.add(element.Calories!);
    });
    for(int i = 0 ; i <= totalFoodCal.length - 1 ; i++)
    {
      totalCal = totalCal + totalFoodCal[i] ;
    }
    print(totalCal);
    return totalCal;
  }


}





