import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/layout/home-layout/cubit/cubit.dart';
import 'package:gp/layout/home-layout/cubit/states.dart';
import 'package:gp/models/product_model.dart';
import 'package:gp/modules/user/address_and_phone_change_screen/address_and_phone_change_screen.dart';
import 'package:gp/modules/user/cart/cart_screen.dart';
import 'package:gp/shared/componants/componants.dart';
import 'package:gp/shared/localization/app_localization%20.dart';
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
          body: ConditionalBuilder(
            condition: state is !GetProductsLoadingState,
            builder: (context) => SingleChildScrollView(
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
                           context,
                           child: Padding(
                             padding: const EdgeInsets.all(10),
                             child: Column(
                               mainAxisAlignment: MainAxisAlignment.center,
                               children: [
                                 defaultContainer(
                                   context,
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
                             context,
                             width: double.infinity,
                             child: Padding(
                               padding: const EdgeInsets.all(10),
                               child: Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                   defaultHeadLineText(context, text: AppLocalizations.of(context).translate("price"),//'Price',
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
                             context,
                             width: double.infinity,
                             child: Padding(
                               padding: const EdgeInsets.all(10),
                               child: Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                   defaultHeadLineText(
                                       context, text:
                                   //AppLocalizations.of(context).translate("  "),//
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
                         defaultTextFormField(
                           controller: quantityController,
                           type: TextInputType.number,
                           validate: (String? value)
                           {
                             if(value!.isEmpty)
                             {
                               return AppLocalizations.of(context).translate("please enter your quantity");//'please enter your quantity';
                             }
                           },
                           label: AppLocalizations.of(context).translate("quantity"),//'Quantity',
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
                               text: AppLocalizations.of(context).translate("Add to Your Card"),//'Add to Your Card',
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
                                 //if( HomeCubit.get(context).userModel!.address != null && HomeCubit.get(context).userModel!.phone != null && HomeCubit.get(context).userModel!.address != "" && HomeCubit.get(context).userModel!.phone != ""  )

                                 if( HomeCubit.get(context).userModel!.address != null && HomeCubit.get(context).userModel!.phone != null)
                                 {
                                   HomeCubit.get(context).createOrderForOneProduct(
                                     prodId: productModel.uId!,
                                     currentPrice: productModel.currentPrice!,
                                     description: productModel.description!,
                                     discount: productModel.discount!,
                                     image: productModel.image!,
                                     name: productModel.name!,
                                     oldPrice: productModel.oldPrice!,
                                     uId: productModel.uId!,
                                     total: productModel.currentPrice! + 100,
                                     totalPrice: productModel.currentPrice!,
                                     productName: productModel.name!,
                                     status: productModel.status!,
                                     quantityAfterBuy: productModel.quantity! - int.parse(quantityController.text),
                                     quantity: int.parse(quantityController.text,
                                     ),
                                   );
                                   showToast(text:AppLocalizations.of(context).translate("Your order done Successfully"),// 'Your order done Successfully',
                                       state: ToastStates.SUCCESS);
                                 }
                                 else
                                 {
                                   showToast(text: AppLocalizations.of(context).translate("validate_phone_and_address"),//'please enter your address and your phone',
                                       state: ToastStates.ERROR);
                                 }
                               }
                             },
                             text: AppLocalizations.of(context).translate("buy_now"),//'Buy Now',
                           ),
                         const SizedBox(
                           height: 10,
                         ),

                         if( HomeCubit.get(context).userModel!.address == null || HomeCubit.get(context).userModel!.phone == null)
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
           ),
            fallback: (context) => const Center(child: CircularProgressIndicator()),

          ),

        );
      },
    );
  }
}
