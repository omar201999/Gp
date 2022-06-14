import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/layout/home-layout/cubit/cubit.dart';
import 'package:gp/layout/home-layout/cubit/states.dart';
import 'package:gp/shared/componants/componants.dart';
import 'package:gp/shared/localization/app_localization%20.dart';

class FavoriteProducts extends StatefulWidget {

  @override
  State<FavoriteProducts> createState() => _FavoriteProductsState();
}

class _FavoriteProductsState extends State<FavoriteProducts> {

  @override
  void initState()
  {
    super.initState();
    HomeCubit.get(context).getFavoritesProducts();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
      listener: (context,state)
      {

      },
      builder: (context,state)
      {

        var list = HomeCubit.get(context).favoritesProducts;
        return Scaffold(
          appBar: AppBar(
            title: Text(AppLocalizations.of(context).translate("Favorite Products")),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children:
              [
                Expanded(
                  child: ConditionalBuilder(
                    condition:  list.isNotEmpty ,
                    builder: (context) => ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context,index) => buildProduct(list[index],context,index),
                        separatorBuilder: (context,index) =>  const SizedBox(height: 8,),
                        itemCount: list.length
                    ),
                    fallback: (context) => Center(child: CircularProgressIndicator(),),
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
