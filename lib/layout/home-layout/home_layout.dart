import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/layout/home-layout/cubit/states.dart';
import 'package:gp/models/meals_model.dart';
import 'package:gp/shared/componants/constant.dart';
import 'package:gp/shared/styles/icon_broken.dart';
import 'package:iconsax/iconsax.dart';

import 'cubit/cubit.dart';

class HomeLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<HomeCubit,HomeStates>(
      listener: (context, state)
      {

      },
      builder: (context, state)
      {
        HomeCubit cubit = HomeCubit.get(context);
        return Scaffold(

          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex ,
            onTap: (index)
            {
              cubit.changeBottomNavBar(index);
            },
            items:
            const [
              BottomNavigationBarItem(
                  icon: Icon(
                      IconBroken.Home
                  ),
                  label: 'Home'
              ),
              BottomNavigationBarItem(
                  icon: Icon(
                      Iconsax.shop4
                  ),
                  label: 'Marketing'
              ),
              BottomNavigationBarItem(
                  icon: Icon(
                      Icons.restaurant_menu_outlined
                  ),
                  label: 'Recipe'
              ),
              BottomNavigationBarItem(
                  icon: Icon(
                      Iconsax.user
                  ),
                  label: 'Me'
              ),

            ],
          ),
          body: cubit.bodyScreen[cubit.currentIndex],
        );
      },

    );

  }
}
