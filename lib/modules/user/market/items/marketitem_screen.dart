import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:glass/glass.dart';
import 'package:gp/layout/home-layout/cubit/cubit.dart';
import 'package:gp/layout/home-layout/cubit/states.dart';
import 'package:gp/models/product_model.dart';
import 'package:gp/modules/user/address_and_phone_change_screen/address_and_phone_change_screen.dart';
import 'package:gp/modules/user/cart/cart_screen.dart';
import 'package:gp/shared/componants/componants.dart';
import 'package:gp/shared/componants/constant.dart';
import 'package:gp/shared/cubit/cubit.dart';
import 'package:gp/shared/localization/app_localization%20.dart';
import 'package:gp/shared/styles/colors.dart';
import 'package:gp/shared/styles/icon_broken.dart';
import 'package:iconsax/iconsax.dart';
import 'package:simple_shadow/simple_shadow.dart';


class CurvePainter extends CustomClipper<Path> {

  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0,size.height-40);
    path.quadraticBezierTo(size.width / 4, size.height , size.width / 2, size.height);
    path.quadraticBezierTo(size.width - (size.width / 4), size.height , size.width, size.height-40);
    path.lineTo(size.width, 0);
    return path;
  }
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

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
  double? rating = 3 ;

  late ProductModel productModel = widget.productModel;
  late int index = widget.index;

  //var quantityController = TextEditingController();
  //var formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    if(HomeCubit.get(context).favoritesProducts.isNotEmpty)
    {
      for(int i=0;i < HomeCubit.get(context).favoritesProducts.length;i++)
      {
        if(HomeCubit.get(context).favoritesProducts[i].name == widget.productModel.name)
        {
          setState(() {
            HomeCubit.get(context).isFavoriteProduct[widget.index]=true;
          });
        }
      }
    }
    else
    {
      setState(() {
        HomeCubit.get(context).isFavoriteProduct[index]=false;
      });
    }


  }
  @override
  Widget build(BuildContext context) {

    int selectedQuantity = HomeCubit.get(context).selectedQuantity;

    return BlocConsumer<HomeCubit,HomeStates>(
      listener: (context,state){},
      builder: (context,state)
      {

        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child:  Column(
                  children:
                  [
                    Stack(
                      children:
                      [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            ClipPath(
                              clipper: CurvePainter(),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 400,
                                color: AppCubit.get(context).constantColor5,
                              ),
                            ),
                            SimpleShadow(
                              child:Image(
                                image: NetworkImage('${productModel.image}'),
                                width: 290,
                                height: 290,
                              ),
                              opacity: 0.5,
                              //color: Colors.blue,
                              offset: Offset(1, 1),
                              sigma: 8,
                            ),



                          ],
                        ),
                        Row(
                          children: [
                            IconButton(
                              color: Colors.blue,
                              onPressed: () {
                                HomeCubit.get(context).initSelectedQuantity();
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                IconBroken.Arrow___Left_2,
                              ),
                            ),
                            Spacer(),
                            Padding(
                              padding: const EdgeInsetsDirectional.only(
                                  top: 5,
                                  end: 5
                              ),
                              child: Container(
                                height: 40,
                                width: 40,
                                //color: Colors.black12.withOpacity(.5),
                                child: IconButton(
                                  //color: defaultColor,
                                  onPressed: ()
                                  {
                                    HomeCubit.get(context).changeFavoritesOfProduct(index: index);
                                    if(HomeCubit.get(context).isFavoriteProduct[index]==true)
                                    {
                                      HomeCubit.get(context).addProductToFavorites(
                                        HomeCubit.get(context).productsIDs[index],
                                        image: productModel.image!,
                                        status: productModel.status!,
                                        name: productModel.name!,
                                        nameAr: productModel.nameAr!,
                                        description: productModel.description!,
                                        quantity: productModel.quantity!,
                                        descriptionAr: productModel.descriptionAr!,
                                        averageRating: productModel.averageRating! ,
                                        numOfRates: productModel.numOfRates! ,
                                        totalRating:productModel.totalRating! ,
                                        currentPrice: productModel.currentPrice!,
                                        oldPrice: productModel.oldPrice!,
                                        discount:productModel.discount!,
                                        selectedQuantity:0,
                                        //isFavorite: true
                                      );
                                    }
                                    else
                                    {
                                      HomeCubit.get(context).deleteFavoritesProducts(HomeCubit.get(context).productsIDs[index],);
                                    }
                                  },
                                  icon: Icon(
                                    Icons.favorite,
                                    color: HomeCubit.get(context).isFavoriteProduct[index] == true ?  Color(0xffe41e3f) : Colors.grey ,
                                  ),
                                ),
                              ).asGlass(
                                tintColor: Colors.black,
                                clipBorderRadius: BorderRadius.circular(50.0),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:
                        [
                            if(lan== 'en')
                              defaultHeadLineText(
                                  context,
                                  fontWeight: FontWeight.w900,
                                  text: '${productModel.name}',
                                  maxLines: 2
                              ),

                            if(lan == 'ar')
                              defaultHeadLineText(
                                    context,
                                    fontWeight: FontWeight.w900,
                                    text: '${productModel.nameAr}',
                                    maxLines: 2
                                ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children:
                            [
                              Expanded(
                                child: RatingBar.builder(
                                  initialRating: (productModel.averageRating)!.toDouble(),
                                  itemSize: 25,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  updateOnDrag: true,
                                  itemCount: 5,
                                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                  itemBuilder: (context, _) => Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  onRatingUpdate: (rating)
                                  {
                                    this.rating = rating;
                                  },
                                ),
                              ),
                              Row(
                                children: [
                                  defaultBodyText(context, text: '(${productModel.averageRating!.toStringAsFixed(1)} ${AppLocalizations.of(context).translate("Avg rating")})'),
                                  IconButton(
                                    padding: EdgeInsetsDirectional.only(
                                      start: 15
                                    ),
                                      onPressed: ()
                                      {
                                        HomeCubit.get(context).updateProductForOneBuy(
                                          HomeCubit.get(context).productsIDs[index],
                                          quantity: productModel.quantity,
                                          selectedQuantity: productModel.selectedQuantity,
                                          name: productModel.name,
                                          image: productModel.image,
                                          status:productModel.status,
                                          oldPrice: productModel.oldPrice,
                                          currentPrice: productModel.currentPrice,
                                          discount: productModel.discount,
                                          description: productModel.description,
                                          nameAr: productModel.nameAr,
                                          descriptionAr:productModel.descriptionAr,
                                          averageRating: (productModel.totalRating! + rating!) / (productModel.numOfRates! + 1),
                                          numOfRates: productModel.numOfRates! + 1 ,
                                          totalRating: productModel.totalRating! + rating!,
                                          //uId: productModel.uId
                                        );
                                        if(HomeCubit.get(context).favoritesProducts.isNotEmpty)
                                        {
                                          for(int i=0;i < HomeCubit.get(context).favoritesProducts.length;i++)
                                          {
                                            if(HomeCubit.get(context).favoritesProducts[i].name == widget.productModel.name)
                                            {
                                              HomeCubit.get(context).updateFavoriteProduct(
                                                HomeCubit.get(context).productsIDs[index],
                                                quantity: productModel.quantity,
                                                selectedQuantity: productModel.selectedQuantity,
                                                name: productModel.name,
                                                image: productModel.image,
                                                status:productModel.status,
                                                oldPrice: productModel.oldPrice,
                                                currentPrice: productModel.currentPrice,
                                                discount: productModel.discount,
                                                description: productModel.description,
                                                nameAr: productModel.nameAr,
                                                descriptionAr:productModel.descriptionAr,
                                                averageRating: (productModel.totalRating! + rating!) / (productModel.numOfRates! + 1),
                                                numOfRates: productModel.numOfRates! + 1 ,
                                                totalRating: productModel.totalRating! + rating!,
                                                //uId: productModel.uId
                                              );
                                            }
                                          }
                                        }

                                      },
                                      icon: Icon(
                                          IconBroken.Send,
                                      ),
                                  ),
                                ],
                              ),

                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Row(
                                children: [
                                  defaultHeadLineText(
                                    context,
                                    text: '${AppLocalizations.of(context).translate("dol")}${productModel.currentPrice}',
                                    fontWeight: FontWeight.w900,
                                  ),
                                  SizedBox(width: 10,),
                                  if (productModel.discount != 0)
                                    Text(
                                     '${AppLocalizations.of(context).translate("dol")}${productModel.oldPrice}',
                                   style: Theme.of(context).textTheme.caption!.copyWith(
                                     decoration: TextDecoration.lineThrough,

                                   ),
                                 ),
                                ],
                              ),
                              Spacer(),
                              if (productModel.quantity != 0)
                                defaultBodyText(
                                context,
                                  text: '${AppLocalizations.of(context).translate("Availability In Stock")}${productModel.quantity }',
                                ),
                              if (productModel.quantity == 0)
                                defaultBodyText(
                                  context,
                                  text: AppLocalizations.of(context).translate("not_available"),

                                ),
                            ],
                          ),

                          const SizedBox(
                            height: 15,
                          ),
                           Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               defaultHeadLineText(
                                 context,
                                 text: AppLocalizations.of(context).translate("Description"),//'Description',
                                 fontWeight: FontWeight.w900,
                               ),
                               if(lan=='en')
                                 Padding(
                                   padding: const EdgeInsetsDirectional.only(
                                     start: 5
                                   ),
                                   child: defaultBodyText(
                                   context,
                                   text: '${productModel.description}',
                                     height: 1.3,
                                     fontSize: 15,
                                     fontWeight: FontWeight.w100,
                               ),
                                 ),
                               if(lan=='ar')
                                 defaultBodyText(
                                   context,
                                   text: '${productModel.descriptionAr}',
                                 ),
                             ],
                           ),


                          const SizedBox(
                            height: 10,
                          ),
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
                          Row(
                            children: [
                              Expanded(
                                child:  Container(
                                  decoration: BoxDecoration(
                                    color: defaultColor,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: MaterialButton(
                                    onPressed: (){
                                      showAnimatedDialog(
                                        context: context,
                                        barrierDismissible: true,
                                        builder: (context) => Center(
                                          child:  Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 15),
                                            child: defaultContainer(
                                              context,
                                              radius: 15,
                                              child: Padding(
                                                padding: const EdgeInsets.all(10.0),
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children:
                                                  [
                                                     Column(
                                                       children: [
                                                         Row(
                                                           crossAxisAlignment: CrossAxisAlignment.center,
                                                           children: [
                                                             defaultHeadLineText(context, text: '${AppLocalizations.of(context).translate("address")} : '),//'Address : '),
                                                             SizedBox(width: 5,),
                                                             if(HomeCubit.get(context).userModel!.address != null)
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
                                                             if(HomeCubit.get(context).userModel!.address == null)
                                                               Expanded(
                                                                 child: Text(
                                                                   AppLocalizations.of(context).translate("validate_address"),//'Pleas enter your address ',
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
                                                             defaultHeadLineText(context, text:'${ AppLocalizations.of(context).translate("phone")} : '),//'Phone : '),
                                                             SizedBox(width: 5,),
                                                             if(HomeCubit.get(context).userModel!.phone != null)
                                                               Text(
                                                                 HomeCubit.get(context).userModel!.phone!,
                                                                 style: Theme
                                                                     .of(context)
                                                                     .textTheme
                                                                     .caption,
                                                                 maxLines: 2,

                                                               ),
                                                             if(HomeCubit.get(context).userModel!.phone == null)
                                                               Text(
                                                                 AppLocalizations.of(context).translate("validate_phone"),//'Please enter your phone',
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
                                                                 }, child: Text(AppLocalizations.of(context).translate("change"))
                                                             ),//'change'))
                                                           ],
                                                         ),
                                                       ],
                                                     ),

                                                    SizedBox(height: 5,),
                                                    defaultHeadLineText(
                                                      context,
                                                      //AppLocalizations.of(context).translate("  "),//
                                                      text: '${AppLocalizations.of(context).translate("quantity")} : $selectedQuantity',
                                                    ),
                                                    defaultHeadLineText(
                                                      context,
                                                      text: '${AppLocalizations.of(context).translate("total_price")} : ${productModel.currentPrice! * HomeCubit.get(context).selectedQuantity} ',
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    defaultButton(
                                                      context,
                                                      onPreesed: ()
                                                      {
                                                        if( HomeCubit.get(context).userModel!.address != null && HomeCubit.get(context).userModel!.phone != null && HomeCubit.get(context).userModel!.address != "" && HomeCubit.get(context).userModel!.phone != "" && productModel.quantity != 0 )
                                                        {
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
                                                            totalPrice:  productModel.currentPrice! * HomeCubit.get(context).selectedQuantity,
                                                            total: (productModel.currentPrice! * HomeCubit.get(context).selectedQuantity) + 30,
                                                            descriptionAr: productModel.descriptionAr!,
                                                            nameAr:  productModel.nameAr!,
                                                            numOfRates: productModel.numOfRates!,
                                                            averageRating: productModel.averageRating!,
                                                            totalRating: productModel.totalRating!,

                                                          );
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
                                                            numOfRates: productModel.numOfRates!,
                                                            averageRating: productModel.averageRating!,
                                                            totalRating: productModel.totalRating!,



                                                          );
                                                          showToast(text: AppLocalizations.of(context).translate("not_in_stock"),
                                                              state: ToastStates.ERROR
                                                          );
                                                        }

                                                      },
                                                      text: AppLocalizations.of(context).translate("buy_now"),
                                                    ),

                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),

                                        ),
                                        animationType: DialogTransitionType.fadeScale,
                                        curve: Curves.fastOutSlowIn,
                                        duration: const Duration(seconds: 1),
                                      );
                                    },
                                    child: Text(
                                      AppLocalizations.of(context).translate("buy_now"),
                                      style: Theme.of(context).textTheme.headline1!.copyWith(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 5,),
                              //if (productModel.quantity != 0)
                              Container(
                                decoration: BoxDecoration(
                                  color: defaultColor,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: MaterialButton(
                                  onPressed: (){
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
                                        numOfRates: productModel.numOfRates!,
                                        averageRating: productModel.averageRating!,
                                        totalRating: productModel.totalRating!,


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
                                        numOfRates: productModel.numOfRates!,
                                        averageRating: productModel.averageRating!,
                                        totalRating: productModel.totalRating!,


                                        //uId: productModel.uId

                                      );
                                      showToast(text: AppLocalizations.of(context).translate("not_in_stock"),
                                          state: ToastStates.ERROR
                                      );
                                    }
                                  },
                                  child: Icon(
                                      Iconsax.shopping_cart,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          /*   defaultButton(
                              context,
                              onPreesed: ()
                              {
                                navigateTo(context, AddressAndPhoneChangeScreen());
                              },
                              text: AppLocalizations.of(context).translate("change_phone"),
                            ),*/
                        ],
                      ),
                    ),
                  ],
                ),

            ),
          ),
          // ),

        );
      },
    );
  }
}
