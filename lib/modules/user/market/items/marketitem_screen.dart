import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/layout/home-layout/cubit/cubit.dart';
import 'package:gp/layout/home-layout/cubit/states.dart';
import 'package:gp/models/product_model.dart';
import 'package:gp/modules/user/buy_now/buy-now-screen.dart';
import 'package:gp/modules/user/cart/cart_screen.dart';
import 'package:gp/shared/componants/componants.dart';
import 'package:gp/shared/styles/icon_broken.dart';
class MarketitemScreen extends StatelessWidget {
  late ProductModel productModel;
  MarketitemScreen({
    required this.productModel,
  });
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
     listener: (context,state){},
      builder: (context,state)
      {
        return Scaffold(
          //backgroundColor: Colors.grey[50],
          body: SingleChildScrollView(
            child: Column(
              children:
              [
                Stack(
                  children:
                  [
                    Container(
                      width: double.infinity,
                      height: 350,
                      decoration:  BoxDecoration(
                        image: DecorationImage(
                          image:NetworkImage('${productModel.image}'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(
                          top: 30
                      ),
                      child: IconButton(
                        color: Colors.blue,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          IconBroken.Arrow___Left_2,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:
                    [
                      defaultContainer(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              defaultContainer(
                                child: defaultHeadLineText(
                                    context,
                                    fontWeight: FontWeight.w900,
                                    text: '${productModel.name}',
                                    maxLines: 2
                                ),
                              ),
                            ],
                          ),
                        ),
                        width: double.infinity,

                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      defaultContainer(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                defaultHeadLineText(context, text: 'Price',
                                  fontWeight: FontWeight.w900,
                                ),
                                defaultBodyText(context,
                                    text: '${productModel.currentPrice}'
                                ),
                              ],
                            ),
                          )
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      defaultContainer(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                defaultHeadLineText(
                                    context,
                                    text: 'Description',
                                  fontWeight: FontWeight.w900,
                                ),
                                defaultBodyText(context,
                                    text: '${productModel.description}',
                                ),
                              ],
                            ),
                          )
                      ),

                      const SizedBox(
                        height: 10,
                      ),
                      defaultContainer(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                defaultHeadLineText(
                                    context, text:
                                'Availability In Stock',
                                  fontWeight: FontWeight.w900
                                ),
                                defaultBodyText(context,
                                    text: '${productModel.quantity }'
                                ),
                              ],
                            ),
                          )
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      defaultButton(
                          context,
                          onPreesed: ()
                          {
                            HomeCubit.get(context).addCartItem(
                              productModel.uId,
                              name: productModel.name,
                              image: productModel.image,
                              uId1: productModel.uId,
                              oldPrice: productModel.oldPrice,
                              currentPrice: productModel.currentPrice,
                              discount: productModel.discount,
                              quantity: productModel.quantity,
                              description: productModel.description,
                            );
                            navigateTo(context, CartScreen());
                          },
                          text: 'Add to Your Card'),
                      const SizedBox(
                        height: 10,
                      ),
                      defaultButton(
                          context,
                          onPreesed: ()
                          {
                            navigateTo(context, BuyNowScreen(productModel: productModel,));
                          },
                          text: 'Buy Now',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

        );
      },
    );
  }
}
