import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/layout/home-layout/cubit/cubit.dart';
import 'package:gp/layout/home-layout/cubit/states.dart';
import 'package:gp/models/product_model.dart';
import 'package:gp/modules/user/cart/cart_screen.dart';
import 'package:gp/shared/componants/componants.dart';
import 'package:gp/shared/styles/icon_broken.dart';
class MarketitemScreen extends StatelessWidget {
  late ProductModel productModel;
  MarketitemScreen({
    required this.productModel,
  });
  var quantityController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
     listener: (context,state){},
      builder: (context,state)
      {
        return Scaffold(
          //backgroundColor: Colors.grey[50],
          body: SingleChildScrollView(
            child: Form(
              key: formKey,
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
                                  defaultBodyText(
                                    context,
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
                                     'Availability In Stock ${productModel.quantity }',
                                     fontWeight: FontWeight.w900
                                    ),
                                ],
                              ),
                            )
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        defaultTextFormField(
                          controller: quantityController,
                          type: TextInputType.number,
                          validate: (String? value)
                          {
                            if(value!.isEmpty)
                            {
                              return 'please enter your quantity';
                            }
                          },
                          label: 'Quantity',
                          border: OutlineInputBorder(),

                        ),

                        const SizedBox(
                          height: 10,
                        ),

                       if (productModel.quantity != 0)
                        defaultButton(
                            context,
                            onPreesed: ()
                            {
                              if(formKey.currentState!.validate())
                              {
                                HomeCubit.get(context).addCartItem(
                                  productModel.uId,
                                  name: productModel.name,
                                  image: productModel.image,
                                  uId1: productModel.uId,
                                  oldPrice: productModel.oldPrice,
                                  currentPrice: productModel.currentPrice,
                                  discount: productModel.discount,
                                  quantity: int.parse(quantityController.text),
                                  description: productModel.description,
                                  status: productModel.status,
                                );
                                navigateTo(context, CartScreen());
                              }


                            },
                            text: 'Add to Your Card'),
                        const SizedBox(
                          height: 10,
                        ),
                        if (productModel.quantity != 0)
                          defaultButton(
                            context,
                            onPreesed: ()
                            {
                              if(formKey.currentState!.validate())
                              {
                                if( HomeCubit.get(context).userModel!.address != null && HomeCubit.get(context).userModel!.phone != null && HomeCubit.get(context).userModel!.address != "" && HomeCubit.get(context).userModel!.phone != ""  )
                                {
                                  HomeCubit.get(context).createOrderForOneProduct(
                                      total: productModel.currentPrice! + 100 ,
                                      totalPrice: productModel.currentPrice!,
                                    productName: productModel.name!,
                                    quantity: int.parse(quantityController.text),
                                  );
                                  showToast(text: 'Your order done Successfully', state: ToastStates.SUCCESS);
                                }
                                else
                                {
                                  showToast(text: 'please enter your address and your phone', state: ToastStates.ERROR);
                                }
                              }

                            },
                            text: 'Buy Now',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

        );
      },
    );
  }
}
