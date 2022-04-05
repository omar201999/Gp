import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/layout/admin_layout/cubit/cubit.dart';
import 'package:gp/layout/admin_layout/cubit/states.dart';
import 'package:gp/modules/user/cart/cart_screen.dart';
import 'package:gp/modules/user/market/search/search_market_screen.dart';
import 'package:gp/shared/componants/componants.dart';
import 'package:gp/shared/styles/icon_broken.dart';

class MarketingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<AdminCubit,AdminStates>(
      listener:  (context,state){},
     builder: (context,state)
     {
       return Scaffold(
         appBar: buildAppBar(
             title: 'Marketing ',
             actions:
             [
               IconButton(
                 padding: EdgeInsets.zero,
                 onPressed: () {
                   navigateTo(context, CartScreen());

                 },
                 icon: Icon(
                   Icons.shopping_cart,
                 ),
               ),
               IconButton(
                 padding: EdgeInsets.zero,
                 onPressed: () {
                   navigateTo(context, SearchMarketingscreen());
                 },
                 icon: Icon(
                  IconBroken.Search
                 ),
               ),
             ]
         ),
         body: SingleChildScrollView(
           physics: const BouncingScrollPhysics(),
           child: Padding(
             padding: const EdgeInsets.all(16.0),
             child: Column(
               children:
               [
                 GridView.count(
                   crossAxisCount: 2,
                   shrinkWrap: true,
                   physics: const NeverScrollableScrollPhysics(),
                   mainAxisSpacing: 10,
                   crossAxisSpacing: 10,
                   childAspectRatio: 1 / 1.50,
                   children: List.generate(
                     AdminCubit.get(context).products.length,
                         (index) => buildmarket_item(AdminCubit.get(context).products[index], context),
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






