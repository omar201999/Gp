import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/layout/home-layout/cubit/cubit.dart';
import 'package:gp/layout/home-layout/cubit/states.dart';
import 'package:gp/models/product_model.dart';
import 'package:gp/shared/componants/componants.dart';

import '../../../shared/styles/icon_broken.dart';

class BuyNowScreen extends StatelessWidget {

  ProductModel? productModel ;
  BuyNowScreen({
     this.productModel
  });
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<HomeCubit,HomeStates>(
      listener: (context,state) {},
      builder: (context,state) {
        return Scaffold(
          appBar: buildAppBar(
            title: 'Buy Now',
            icon: IconBroken.Arrow___Left_2,

            onPressed: ()
            {
              Navigator.pop(context);
            },
          ),
          body:SingleChildScrollView(
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
                              Expanded(
                                child: Text(
                                  '9 ali abdelfath street qsr elshama masr elqdema',
                                  style: Theme.of(context).textTheme.caption,
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
                              Text(
                                '01158822107',
                                style: Theme.of(context).textTheme.caption,
                                maxLines: 2,

                              ),
                              Spacer(),
                              TextButton(onPressed: (){}, child: Text('change'))
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  if(HomeCubit.get(context).cart != null)
                    ListView.separated(
                    itemBuilder: (context,index) =>buyNowItem(context , HomeCubit.get(context).cart[index],index) ,
                    separatorBuilder: (context,index) => SizedBox(height: 10,),
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
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        defaultHeadLineText(context, text: 'Name : '),
                                        Text(
                                          '${productModel!.name}',
                                          style: Theme.of(context).textTheme.caption,
                                          maxLines: 2,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        defaultHeadLineText(context, text: 'Quantity : '),
                                        Text(
                                          '${productModel!.quantity}',
                                          style: Theme.of(context).textTheme.caption,
                                          maxLines: 2,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        defaultHeadLineText(context, text: 'Price : '),
                                        Text(
                                          '${productModel!.currentPrice} \$',
                                          style: Theme.of(context).textTheme.caption,
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
                              defaultHeadLineText(context, text: 'Total Price : '),
                              Text(
                                '${HomeCubit.get(context).calculateTotalPriceOfCartItems()} \$',
                                style: Theme.of(context).textTheme.caption,
                                maxLines: 2,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              defaultHeadLineText(context, text: 'Shipping: '),
                              Text(
                                '100 \$',
                                style: Theme.of(context).textTheme.caption,
                                maxLines: 2,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              defaultHeadLineText(context, text: 'Total  : '),
                              Text(
                                '${(HomeCubit.get(context).calculateTotalPriceOfCartItems())+100} \$',
                                style: Theme.of(context).textTheme.caption,
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
          floatingActionButton: FloatingActionButton.extended(
            foregroundColor: Colors.white,
            onPressed: ()
            {
              //HomeCubit.get(context).createOrder(totalPrice: HomeCubit.get(context).calculateTotalPriceOfCartItems(), total: (HomeCubit.get(context).calculateTotalPriceOfCartItems())+100);
              HomeCubit.get(context).addProductToOrders();
            },
            label: Text('Buy Now'),

          ),
        );
      },
    );
  }
  Widget buyNowItem(BuildContext context,ProductModel model,index ) => defaultContainer(
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      defaultHeadLineText(context, text: 'Name : '),
                      Text(
                        '${model.name}',
                        style: Theme.of(context).textTheme.caption,
                        maxLines: 2,
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      defaultHeadLineText(context, text: 'Quantity : '),
                      Text(
                        '${model.quantity}',
                        style: Theme.of(context).textTheme.caption,
                        maxLines: 2,
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      defaultHeadLineText(context, text: 'Price : '),
                      Text(
                        '${model.currentPrice} \$',
                        style: Theme.of(context).textTheme.caption,
                        maxLines: 2,
                      ),
                    ],
                  ),
                ],
              ),
            ],

          ),


        ],
      ),
    ),
  );
}
