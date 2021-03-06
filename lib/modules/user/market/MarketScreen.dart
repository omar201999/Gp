import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/layout/admin_layout/cubit/cubit.dart';
import 'package:gp/layout/admin_layout/cubit/states.dart';
import 'package:gp/layout/home-layout/cubit/cubit.dart';

import 'package:gp/shared/componants/componants.dart';

class MarketingScreen extends StatefulWidget {
  @override
  State<MarketingScreen> createState() => _MarketingScreenState();
}

class _MarketingScreenState extends State<MarketingScreen> {

  @override
  void initState() {
    super.initState();
    HomeCubit.get(context).getFavoritesProducts();
  }
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<AdminCubit,AdminStates>(
      listener:  (context,state){},
     builder: (context,state)
     {
       return SingleChildScrollView(
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
                 childAspectRatio: 2 / 3,
                 children: List.generate(
                   AdminCubit.get(context).products.length,
                       (index) => buildProduct(AdminCubit.get(context).products[index], context, index),
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






