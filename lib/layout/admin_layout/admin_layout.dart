import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/layout/admin_layout/cubit/states.dart';
import 'package:gp/shared/styles/icon_broken.dart';
import 'package:iconsax/iconsax.dart';
import 'cubit/cubit.dart';

class AdminLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<AdminCubit,AdminStates>(
      listener: (context, state)
      {

      },
      builder: (context, state)
      {
        AdminCubit cubit = AdminCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {

                },
                icon: Icon(IconBroken.Category)
            ),
            title: Text(cubit.titles[cubit.currentIndex]),
            actions: [
              IconButton(
                onPressed: () {

                },
                icon: Icon(IconBroken.Search),

              ),
              IconButton(
                onPressed: () {

                },
                icon: Icon(IconBroken.Notification),

              )
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex ,
            onTap: (index)
            {
              cubit.changeBottomNav(index);
            },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Chart),
                  label: 'Dashboard'
              ),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.User),
                  label: 'Users'
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.restaurant_menu_outlined),
                  label: 'Recipes'
              ),
              BottomNavigationBarItem(
                  icon: Icon(Iconsax.shop),
                  label: 'Market'
              ),
            ],
          ),
        );
      },

    );

  }
}