import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/layout/home-layout/cubit/cubit.dart';
import 'package:gp/layout/home-layout/cubit/states.dart';
import 'package:gp/models/product_model.dart';
import 'package:gp/modules/user/buy_now/buy-now-screen.dart';
import 'package:gp/shared/componants/componants.dart';
import 'package:gp/shared/styles/icon_broken.dart';

class CartScreen extends StatelessWidget {
  //List<int>? cartQuantity;
  int? productQuantity;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
        listener: (context, state)
        {
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
            floatingActionButton: FloatingActionButton.extended(
              foregroundColor: Colors.white,
              onPressed: ()
              {
                navigateTo(context, BuyNowScreen());
              },
              label: Text('Buy Now'),

            ),
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    ListView.separated(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) => BuildCartItem(HomeCubit.get(context).cart[index],context,index),
                      separatorBuilder: (context, index) => SizedBox(height: 5,),
                      itemCount: HomeCubit.get(context).cart.length,
                    ),
                  ],
                ),
              ),
            ),
          );

        }
    );
  }

  Widget  BuildCartItem (ProductModel model,context,index)=>SingleChildScrollView(

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
                    Expanded(
                      child: Text(
                        '${model.name}',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                          //fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        HomeCubit.get(context).deleteCartItem(model.uId);
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
                        HomeCubit.get(context).minus(index);
                        productQuantity = model.quantity! + 1;
                          /* HomeCubit.get(context).updateCartItem(
                            model.uId,
                            name: model.name,
                            image: model.image,
                            uId1: model.uId,
                            oldPrice: model.oldPrice,
                            currentPrice: model.currentPrice,
                            discount: model.discount,
                            quantity: productQuantity,
                            description: model.description,
                          );*/

                      },
                      icon: Icon (Icons.remove),
                    ),
                    SizedBox(
                      width: 30,
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.black, width: 0.5)),
                        child: Text(
                          '${HomeCubit.get(context).Counter[index]}',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        HomeCubit.get(context).plus(index);
                          productQuantity = model.quantity! - 1;
                          /* HomeCubit.get(context).updateCartItem(
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
*/

                      },
                      icon: Icon (Icons.add),
                    ),

                    Spacer(),
                    Text(
                        "${model.currentPrice! * HomeCubit.get(context).Counter[index]}"
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
  );
}
