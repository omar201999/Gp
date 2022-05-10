import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/layout/home-layout/cubit/cubit.dart';
import 'package:gp/layout/home-layout/cubit/states.dart';
import 'package:gp/models/product_model.dart';
import 'package:gp/modules/user/buy_now/buy-now-screen.dart';
import 'package:gp/shared/componants/componants.dart';
import 'package:gp/shared/componants/constant.dart';
import 'package:gp/shared/localization/app_localization%20.dart';
import 'package:gp/shared/styles/icon_broken.dart';

class CartScreen extends StatelessWidget {
  //List<int>? cartQuantity;
  ProductModel? productModel;

  @override
  Widget build(BuildContext context) {

    int? productQuantity;

    return BlocConsumer<HomeCubit,HomeStates>(
        listener: (context, state)
        {

        },
        builder: (context,state)
        {
          return ConditionalBuilder(
            condition: HomeCubit.get(context).cart.isNotEmpty ,
            builder: (context)=>Scaffold(
              appBar: buildAppBar(
                title: AppLocalizations.of(context).translate("your_cart_app_bar"),//'Your Cart',
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
                  if(HomeCubit.get(context).cart.isNotEmpty )
                  {
                    navigateTo(context, BuyNowScreen());
                  }
                  else
                  {
                    showToast(
                        text: AppLocalizations.of(context).translate("your_cart"),//'Your Cart is Empty',
                        state: ToastStates.ERROR);
                  }
                },
                label:  Text(AppLocalizations.of(context).translate("buy_now")),//'Buy Now'),

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
            ),
              fallback: (context) => Scaffold(
                appBar: buildAppBar(
                title: AppLocalizations.of(context).translate("your_cart_app_bar"),
                icon: IconBroken.Arrow___Left_2,

                onPressed: ()
                {
                  Navigator.pop(context);
                },
              ),
                body: const Center(
                  child: Text(
                      'No products here!',
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      color: Colors.black38,
                    ),
                  ),
                ),
              )
                  //Center(child: CircularProgressIndicator())
          );

        }
    );
  }

  Widget  BuildCartItem (ProductModel model,context,index)=>SingleChildScrollView(

    child: Column(
      children: [
        defaultContainer(
          context,
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
                    if(lan=='en')
                      Expanded(
                      //fontSize: 14,
                      child: defaultBodyText(context, text: '${model.name}',maxLines: 2,overflow: TextOverflow.ellipsis,fontSize: 14),
                    ),
                    if(lan=='ar')
                      Expanded(
                        //fontSize: 14,
                        child: defaultBodyText(context, text: '${model.nameAr}',maxLines: 2,overflow: TextOverflow.ellipsis,fontSize: 14),
                      ),
                    IconButton(
                      onPressed: () {
                        HomeCubit.get(context).deleteCartItem(HomeCubit.get(context).cartId[index],);
                        HomeCubit.get(context).updateProductForOneBuy(
                            HomeCubit.get(context).cartId[index],
                            name: model.name,
                            currentPrice: model.currentPrice,
                            image: model.image,
                            oldPrice: model.oldPrice,
                            discount: model.discount,
                            quantity: (HomeCubit.get(context).addStockQuantity(model))!.toInt(),
                            selectedQuantity: model.selectedQuantity,
                            description: model.description,
                            //uId: model.uId,
                            status: model.status,
                            nameAr: model.nameAr,
                            descriptionAr: model.descriptionAr,
                        );
                      },
                      icon: Icon (Icons.delete_forever),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    //AppLocalizations.of(context).translate("  "),//
                    defaultBodyText(context, text: '${AppLocalizations.of(context).translate("quantity")}${model.selectedQuantity}'),
                    /*IconButton(
                      onPressed: () {
                        HomeCubit.get(context).minus(index);
                        productQuantity = model.quantity! + 1;


                      },
                      icon: Icon (Icons.remove),
                    ),*/
                   /* SizedBox(
                      width: 30,
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.black, width: 0.5)),
                        child: Text(
                          '${model.quantity}',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        HomeCubit.get(context).plus(index);
                          productQuantity = model.quantity! - 1;


                      },
                      icon: Icon (Icons.add),
                    ),*/
                    Spacer(),
                    defaultBodyText(context, text: (model.currentPrice! * (model.selectedQuantity)!.round()).toStringAsFixed(2)),
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
