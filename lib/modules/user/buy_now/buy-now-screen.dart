import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/layout/home-layout/cubit/cubit.dart';
import 'package:gp/layout/home-layout/cubit/states.dart';
import 'package:gp/models/product_model.dart';
import 'package:gp/modules/user/address_and_phone_change_screen/address_and_phone_change_screen.dart';
import 'package:gp/shared/componants/componants.dart';

import '../../../shared/styles/icon_broken.dart';

class BuyNowScreen extends StatelessWidget {

  ProductModel? productModel;

  BuyNowScreen({
    this.productModel
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(

      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: buildAppBar(
            title: 'Buy Now',
            icon: IconBroken.Arrow___Left_2,

            onPressed: () {
              Navigator.pop(context);
            },
          ),
          floatingActionButton: FloatingActionButton.extended(
            foregroundColor: Colors.white,
            onPressed: ()
            {
              if( HomeCubit.get(context).userModel!.address != null ||HomeCubit.get(context).userModel!.phone!= null  )
              {
                HomeCubit.get(context).createOrder(total: HomeCubit.get(context).calculateTotalPriceOfCartItems()+100 , totalPrice: HomeCubit.get(context).calculateTotalPriceOfCartItems());
                showToast(text: 'Your order done Successfully', state: ToastStates.SUCCESS);
              }
              else
              {
                showToast(text: 'pleas enter your address and your phone', state: ToastStates.ERROR);
              }


            },
            label: Text('Buy Now'),

          ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  defaultContainer(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              defaultHeadLineText(context, text: 'Address : '),
                              SizedBox(width: 5,),
                              if(HomeCubit.get(context).userModel!.address! != null)
                                Expanded(
                                child: Text(
                                  HomeCubit.get(context).userModel!.address!,
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .caption,
                                  maxLines: 2,

                                ),
                              ),
                              if(HomeCubit.get(context).userModel!.address! == null)
                                Expanded(
                                child: Text(
                                  'Pleas enter your address ',
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .caption,
                                  maxLines: 2,

                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              defaultHeadLineText(context, text: 'Phone : '),
                              SizedBox(width: 5,),
                              if(HomeCubit.get(context).userModel!.phone! != null)
                                Text(
                                HomeCubit.get(context).userModel!.phone!,
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .caption,
                                maxLines: 2,

                              ),
                              if(HomeCubit.get(context).userModel!.phone! == null)
                                Text(
                                 'Pleas enter your phone',
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .caption,
                                  maxLines: 2,

                                ),
                                Spacer(),
                              TextButton(
                                  onPressed: () {
                                    navigateTo(context, AddressAndPhoneChangeScreen());
                                  }, child: Text('change'))
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  if(HomeCubit.get(context).cart != null)
                    ListView.separated(
                      itemBuilder: (context, index) => buyNowItem(context, HomeCubit.get(context).cart[index],index),
                      separatorBuilder: (context, index) => SizedBox(height: 10,),
                      itemCount: HomeCubit.get(context).cart.length,
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                    ),
                  SizedBox(height: 10,),
                  if(productModel != null)
                    defaultContainer(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image(
                                  image: NetworkImage('${productModel!.image}'),
                                  width: 100,
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .center,
                                      children: [
                                        defaultHeadLineText(
                                            context, text: 'Name : '),
                                        Text(
                                          '${productModel!.name}',
                                          style: Theme
                                              .of(context)
                                              .textTheme
                                              .caption,
                                          maxLines: 2,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .center,
                                      children: [
                                        defaultHeadLineText(
                                            context, text: 'Quantity : '),
                                        Text(
                                          '${productModel!.quantity}',
                                          style: Theme
                                              .of(context)
                                              .textTheme
                                              .caption,
                                          maxLines: 2,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .center,
                                      children: [
                                        defaultHeadLineText(
                                            context, text: 'Price : '),
                                        Text(
                                          '${productModel!.currentPrice} \$',
                                          style: Theme
                                              .of(context)
                                              .textTheme
                                              .caption,
                                          maxLines: 2,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],

                            )
                          ],
                        ),
                      ),
                    ),
                  SizedBox(height: 10,),
                  defaultContainer(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              defaultHeadLineText(
                                  context, text: 'Total Price : '),
                              Text(
                                '${HomeCubit.get(context)
                                    .calculateTotalPriceOfCartItems()} \$',
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .caption,
                                maxLines: 2,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              defaultHeadLineText(context, text: 'Shipping: '),
                              Text(
                                '100 \$',
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .caption,
                                maxLines: 2,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              defaultHeadLineText(context, text: 'Total  : '),
                              Text(
                                '${(HomeCubit.get(context)
                                    .calculateTotalPriceOfCartItems()) +
                                    100} \$',
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .caption,
                                maxLines: 2,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),


          /*floatingActionButton: FloatingActionButton.extended(
            foregroundColor: Colors.white,
            onPressed: ()
            {
              HomeCubit.get(context).createOrder(
                  totalPrice: HomeCubit.get(context).calculateTotalPriceOfCartItems(),
                  total: (HomeCubit.get(context).calculateTotalPriceOfCartItems())+100
              );

              HomeCubit.get(context).addProductToOrders(
                  HomeCubit.get(context).ordersId[index],
                  name: HomeCubit.get(context).products[].name,
                  currentPrice: currentPrice,
                  oldPrice: oldPrice,
                  discount: discount,
                  quantity: quantity,
                  description: description,
                  uId1: uId1
              )
            },
            label: Text('Buy Now'),

          ),*/
        );
      },
    );
  }

  Widget buyNowItem(BuildContext context, ProductModel model, index) =>
      defaultContainer(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image(
                    image: NetworkImage('${model.image}'),
                    width: 100,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            defaultBodyText(context, text: 'Name : '),
                            Expanded(
                              child: Text(
                                '${model.name}',
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .caption,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            defaultBodyText(context, text: 'Quantity : '),
                            Text(
                              '${HomeCubit.get(context).Counter[index]}',
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .caption,
                              maxLines: 2,
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            defaultBodyText(context, text: 'Price per one : '),
                            Text(
                              '${model.currentPrice} \$',
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .caption,
                              maxLines: 2,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],

              ),

              /*defaultButton(
                context,
                onPreesed: () {
                  HomeCubit.get(context).createOrder(
                      totalPrice: HomeCubit.get(context).calculateTotalPriceOfCartItems(),
                      total: (HomeCubit.get(context).calculateTotalPriceOfCartItems()) + 100
                  );
                  HomeCubit.get(context).addProductToOrders(
                      HomeCubit.get(context).ordersId[1],
                      name: HomeCubit.get(context).products[index].name,
                      currentPrice: HomeCubit.get(context).products[index].currentPrice,
                      oldPrice: HomeCubit.get(context).products[index].oldPrice,
                      discount: HomeCubit.get(context).products[index].discount,
                      quantity: HomeCubit.get(context).products[index].quantity,
                      description: HomeCubit.get(context).products[index].description,
                      //uId1: HomeCubit.get(context).products[index].uId,
                  );
                },
                text: 'Buy Now',
              ),*/
            ],
          ),
        ),
      );
}
