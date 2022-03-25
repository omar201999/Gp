import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/models/product_model.dart';
import 'package:gp/models/user_model.dart';
import 'package:gp/modules/user/cart/cubit/states.dart';
import 'package:gp/shared/componants/constant.dart';

class CartCubit extends Cubit<CartStates>{
  CartCubit() : super(CartInitialState());

  static CartCubit get(context) => BlocProvider.of(context);






  void addCartItem(String? prodId,{
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



   getTotalPrice(){
    double total = 0.0;
    cart.forEach((element) {
      total += (element.currentPrice)!.round() * (element.quantity)!.round();

    });
    return total;
  }

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

}