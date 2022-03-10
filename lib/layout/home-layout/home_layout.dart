import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/layout/home-layout/cubit/states.dart';

import 'cubit/cubit.dart';

class HomeLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context)
  {
    return BlocProvider(
      create: (BuildContext context) => HomeCubit(),
      child: BlocConsumer<HomeCubit,HomeStates>(
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
              [
                BottomNavigationBarItem(
                    icon: Icon(
                        Icons.food_bank_outlined
                    ),
                    label: 'Home'
                ),
                BottomNavigationBarItem(
                    icon: Icon(
                        Icons.inventory_2_outlined
                    ),
                    label: 'Marketing'
                ),
                BottomNavigationBarItem(
                    icon: Icon(
                        Icons.receipt
                    ),
                    label: 'Recipe'
                ),
                BottomNavigationBarItem(
                    icon: Icon(
                        Icons.account_box_outlined
                    ),
                    label: 'Me'
                ),

              ],
            ),
            body: cubit.bodyScreen[cubit.currentIndex],
          );
        },

      ),
    );

  }
}
