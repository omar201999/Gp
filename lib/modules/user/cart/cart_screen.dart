import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gp/models/product_model.dart';
import 'package:gp/modules/user/cart/cubit/cubit.dart';
import 'package:gp/modules/user/cart/cubit/states.dart';
import 'package:gp/shared/componants/componants.dart';
import 'package:gp/shared/styles/icon_broken.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int cartQuantity = 1;
  int? productQuantity;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit,CartStates>(
        listener: (context, state)
        {
          if(state is! GetCartItemLoadingState)
            Center(child: CircularProgressIndicator());

        },
        builder: (context,state)
        {

          return Scaffold(
            appBar: buildAppBar(
              title: 'Your Cart',
              icon: IconBroken.Arrow___Left_2,

              onPressed: ()
              {
                Navigator.pop(context);
              },
            ),
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    ListView.separated(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) => BuildCartItem(CartCubit.get(context).cart[index],context),
                      separatorBuilder: (context, index) => SizedBox(height: 10,),
                      itemCount: CartCubit.get(context).cart.length,
                    ),
                  ],
                ),
              ),
            ),
          );

        }
    );
  }

  Widget  BuildCartItem (ProductModel model,context)=>SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          defaultContainer(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Image.network(
                        '${model.image}',
                        height: 90,
                        width: 90,
                      ),
                      SizedBox(width: 20),
                      Text(
                        '${model.name}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          CartCubit.get(context).deleteCartItem(model.uId);
                        },
                        icon: Icon (Icons.delete_forever),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            cartQuantity--;
                            productQuantity=model.quantity! + cartQuantity;
                            CartCubit.get(context).updateCartItem(
                              model.uId,
                              name: model.name,
                              image: model.image,
                              uId1: model.uId,
                              oldPrice: model.oldPrice,
                              currentPrice: model.currentPrice,
                              discount: model.discount,
                              quantity: productQuantity,
                              description: model.description,
                            );
                          });
                          print(productQuantity);
                        },
                        icon: Icon (Icons.remove),
                      ),
                      SizedBox(
                        height: 20,
                        width: 30,
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.black, width: 0.5)),
                          child: Text(
                            '${cartQuantity}',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            cartQuantity++;
                            productQuantity=model.quantity! - cartQuantity;
                            CartCubit.get(context).updateCartItem(
                              model.uId,
                              name: model.name,
                              image: model.image,
                              uId1: model.uId,
                              oldPrice: model.oldPrice,
                              currentPrice: model.currentPrice,
                              discount: model.discount,
                              quantity: productQuantity,
                              description: model.description,
                            );
                          });
                        },
                        icon: Icon (Icons.add),
                      ),

                      Spacer(),
                      Text(
                          "${model.currentPrice! * cartQuantity}"
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),

        ],
      ),
    ),
  );
}
