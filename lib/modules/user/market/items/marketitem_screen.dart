import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/layout/home-layout/cubit/cubit.dart';
import 'package:gp/layout/home-layout/cubit/states.dart';
import 'package:gp/models/product_model.dart';
import 'package:gp/modules/user/address_and_phone_change_screen/address_and_phone_change_screen.dart';
import 'package:gp/modules/user/cart/cart_screen.dart';
import 'package:gp/shared/componants/componants.dart';
import 'package:gp/shared/componants/constant.dart';
import 'package:gp/shared/localization/app_localization%20.dart';
import 'package:gp/shared/styles/icon_broken.dart';
class MarketItemScreen extends StatefulWidget {

  late ProductModel productModel;
  late int index;
  MarketItemScreen({
    required this.productModel,
    required this.index,
  });
  @override
  State<MarketItemScreen> createState() => _MarketItemScreenState();
}


class _MarketItemScreenState extends State<MarketItemScreen> {

  late ProductModel productModel = widget.productModel;
  late int index = widget.index;

  //var quantityController = TextEditingController();
  //var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {

    int selectedQuantity = HomeCubit.get(context).selectedQuantity;

    return BlocConsumer<HomeCubit,HomeStates>(
      listener: (context,state){},
      builder: (context,state)
      {
        return Scaffold(
          //backgroundColor: Colors.grey[50],
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            /*child: Form(
              key: formKey,*/
            child: Column(
              children:
              [
                Stack(
                  children:
                  [
                    Container(
                      width: double.infinity,
                      height: 400,
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
                          HomeCubit.get(context).initSelectedQuantity();
                          Navigator.pop(context);
                        },
                        icon: const Icon(
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
                        context,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if(lan== 'en')
                                defaultContainer(
                                context,
                                child: defaultHeadLineText(
                                    context,
                                    fontWeight: FontWeight.w900,
                                    text: '${productModel.name}',
                                    maxLines: 2
                                ),
                              ),
                              if(lan == 'ar')
                                defaultContainer(
                                  context,
                                  child: defaultHeadLineText(
                                      context,
                                      fontWeight: FontWeight.w900,
                                      text: '${productModel.nameAr}',
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
                        context,
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                defaultHeadLineText(context, text: AppLocalizations.of(context).translate("price"),
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
                        context,
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                defaultHeadLineText(
                                  context,
                                  text: AppLocalizations.of(context).translate("Description"),//'Description',
                                  fontWeight: FontWeight.w900,
                                ),
                                if(lan=='en')
                                  defaultBodyText(
                                  context,
                                  text: '${productModel.description}',
                                ),
                                if(lan=='ar')
                                  defaultBodyText(
                                    context,
                                    text: '${productModel.descriptionAr}',
                                  ),
                              ],
                            ),
                          )
                      ),

                      const SizedBox(
                        height: 10,
                      ),
                      defaultContainer(
                        context,
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                defaultHeadLineText(
                                    context, text:
                                '${AppLocalizations.of(context).translate("Availability In Stock")} ${productModel.quantity }',
                                    fontWeight: FontWeight.w900
                                ),
                              ],
                            ),
                          )
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      /*defaultTextFormField(
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

                        ),*/

                      if(productModel.quantity != 0)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            defaultRawButton(
                                onPressed: () {
                                  setState(() {
                                    HomeCubit.get(context).addQuantity(productModel);
                                    productModel.selectedQuantity = selectedQuantity;
                                  });

                                },
                                icon: Icons.add
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            defaultBodyText(context, text: '$selectedQuantity'),
                            const SizedBox(
                              width: 10,
                            ),

                            defaultRawButton(
                                onPressed: () {
                                  setState(() {
                                    HomeCubit.get(context).minusQuantity();
                                    productModel.selectedQuantity = selectedQuantity;
                                  });

                                },
                                icon: Icons.remove
                            )
                          ],
                        ),


                      const SizedBox(
                        height: 10,
                      ),

                      //if (productModel.quantity != 0)
                      defaultButton(
                          context,
                          onPreesed: ()
                          {
                            /*if(formKey.currentState!.validate())
                              {*/


                            if (productModel.quantity != 0) {
                              /*if(HomeCubit.get(context).cart.isNotEmpty) {
                                for(int i = 0; i < HomeCubit.get(context).cart.length; i++) {
                                  if(productModel.name == HomeCubit.get(context).cart[i].name) {
                                    productModel.quantity = HomeCubit.get(context).addStockQuantity(HomeCubit.get(context).cart[i])! - selectedQuantity;
                                    HomeCubit.get(context).addStockQuantity(HomeCubit.get(context).cart[i]);
                                    HomeCubit.get(context).updateCartItem(
                                        HomeCubit.get(context).productsIDs[index],
                                        name: productModel.name,
                                        currentPrice: productModel.currentPrice,
                                        oldPrice: productModel.oldPrice,
                                        discount: productModel.discount,
                                        quantity: productModel.quantity,
                                        selectedQuantity: selectedQuantity,
                                        description: productModel.description,
                                        image: productModel.image,
                                        //uId1: productModel.uId,
                                        status: productModel.status
                                    );
                                  } else {
                                    productModel.quantity = productModel.quantity! - selectedQuantity;
                                    HomeCubit.get(context).addCartItem(
                                      HomeCubit.get(context).productsIDs[index],
                                      name: productModel.name,
                                      image: productModel.image,
                                      //uId1: productModel.uId,
                                      oldPrice: productModel.oldPrice,
                                      currentPrice: productModel.currentPrice,
                                      discount: productModel.discount,
                                      quantity: productModel.quantity,
                                      selectedQuantity: selectedQuantity,
                                      //int.parse(quantityController.text),
                                      description: productModel.description,
                                      status: productModel.status,
                                    );
                                  }
                                }
                              } else {*/
                                productModel.quantity = productModel.quantity! - selectedQuantity;
                                HomeCubit.get(context).addCartItem(
                                  HomeCubit.get(context).productsIDs[index],
                                  name: productModel.name,
                                  image: productModel.image,
                                  //uId1: productModel.uId,
                                  oldPrice: productModel.oldPrice,
                                  currentPrice: productModel.currentPrice,
                                  discount: productModel.discount,
                                  quantity: productModel.quantity,
                                  selectedQuantity: selectedQuantity,
                                  //int.parse(quantityController.text),
                                  description: productModel.description,
                                  status: productModel.status,
                                  nameAr:productModel.nameAr,
                                  descriptionAr: productModel.descriptionAr,

                                );

                             /*
                              HomeCubit.get(context).updateProductForOneBuy(
                                HomeCubit.get(context).productsIDs[index],
                                quantity: productModel.quantity,
                                selectedQuantity: selectedQuantity,
                                name: productModel.name,
                                image: productModel.image,
                                status: productModel.status,
                                oldPrice: productModel.oldPrice,
                                currentPrice: productModel.currentPrice,
                                discount: productModel.discount,
                                description: productModel.description,
                                //uId: productModel.uId

                              );*/

                              HomeCubit.get(context).initSelectedQuantity();
                              navigateTo(context, CartScreen());
                            }
                            else {
                              HomeCubit.get(context).updateProductForOneBuy(
                                HomeCubit.get(context).productsIDs[index],
                                quantity: productModel.quantity,
                                selectedQuantity: selectedQuantity,
                                name: productModel.name,
                                image: productModel.image,
                                status: 'notInStock',
                                oldPrice: productModel.oldPrice,
                                currentPrice: productModel.currentPrice,
                                discount: productModel.discount,
                                description: productModel.description,
                                nameAr: productModel.nameAr,
                                descriptionAr:productModel.descriptionAr,
                                //uId: productModel.uId

                              );
                              showToast(text: AppLocalizations.of(context).translate("not_in_stock"),
                                  state: ToastStates.ERROR
                              );
                            }

                            //}

                          },
                        text: AppLocalizations.of(context).translate("Add to Your Card"),//'Add to Your Card',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      //if (productModel.quantity != 0)
                      defaultButton(
                        context,
                        onPreesed: ()
                        {
                          /*if(formKey.currentState!.validate())
                              {*/
                          if( HomeCubit.get(context).userModel!.address != null && HomeCubit.get(context).userModel!.phone != null && HomeCubit.get(context).userModel!.address != "" && HomeCubit.get(context).userModel!.phone != "" && productModel.quantity != 0 )
                          {
                            /* HomeCubit.get(context).createOrderForOneProduct(
                              total: productModel.currentPrice! + 100 ,
                              totalPrice: productModel.currentPrice!,
                              productName: productModel.name!,
                              quantity: selectedQuantity,
                              //int.parse(quantityController.text),
                            );*/
                            productModel.quantity = productModel.quantity! - selectedQuantity;
                            HomeCubit.get(context).createOrderForOneProduct(
                                quantity: productModel.quantity!,
                                name: productModel.name!,
                                image: productModel.image!,
                                status: productModel.status!,
                                oldPrice: productModel.oldPrice!,
                                currentPrice: productModel.currentPrice!,
                                discount: productModel.discount!,
                                description: productModel.description!,
                                //uId: productModel.uId,
                                selectedQuantity: selectedQuantity,
                              prodId: HomeCubit.get(context).productsIDs[index],
                              productName: productModel.name!,
                              totalPrice:  productModel.currentPrice!,
                              total: productModel.currentPrice! + 30,
                              descriptionAr: "productModel.descriptionAr!",//productModel.descriptionAr!
                              nameAr:  productModel.nameAr!,
                            );

                           /* HomeCubit.get(context).createOrderForOneProduct(
                              total: productModel.currentPrice! + 100 ,
                              totalPrice: productModel.currentPrice!,
                              productName: productModel.name!,
                              quantity: selectedQuantity,
                              //int.parse(quantityController.text),
                            );*/

                            HomeCubit.get(context).initSelectedQuantity();


                            showToast(text:AppLocalizations.of(context).translate("Your order done Successfully"),// 'Your order done Successfully',
                                state: ToastStates.SUCCESS);
                          }

                          if(HomeCubit.get(context).userModel!.address == null && HomeCubit.get(context).userModel!.phone == null && HomeCubit.get(context).userModel!.address == "" && HomeCubit.get(context).userModel!.phone == "")
                          {
                            showToast(text: AppLocalizations.of(context).translate("validate_phone_and_address"),//'please enter your address and your phone',
                                state: ToastStates.ERROR);
                          }

                          //}
                          if (productModel.quantity == 0) {
                            HomeCubit.get(context).updateProductForOneBuy(
                                HomeCubit.get(context).productsIDs[index],
                                quantity: productModel.quantity,
                                name: productModel.name,
                                image: productModel.image,
                                status: 'notInStock',
                                oldPrice: productModel.oldPrice,
                                currentPrice: productModel.currentPrice,
                                discount: productModel.discount,
                                description: productModel.description,
                                //uId: productModel.uId,
                                selectedQuantity: selectedQuantity,
                                descriptionAr: productModel.descriptionAr,
                                nameAr: productModel.nameAr,


                            );
                            showToast(text: AppLocalizations.of(context).translate("not_in_stock"),
                                state: ToastStates.ERROR
                            );
                          }
                        },
                        text: AppLocalizations.of(context).translate("buy_now"),//'Buy Now',
                      ),

                      const SizedBox(
                        height: 10,
                      ),
                      defaultButton(
                          context,
                          onPreesed: ()
                          {
                            navigateTo(context, AddressAndPhoneChangeScreen());
                          },
                          text: AppLocalizations.of(context).translate("change_phone"),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // ),

        );
      },
    );
  }
}
