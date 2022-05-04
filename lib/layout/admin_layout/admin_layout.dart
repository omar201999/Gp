import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/layout/admin_layout/cubit/states.dart';
import 'package:gp/modules/admin/feedback_management/feedback_management_screen.dart';
import 'package:gp/modules/admin/orders_management/order_layout_screen/order_layout_creen.dart';
import 'package:gp/modules/admin/market_management/search_product/search_product_screen.dart';
import 'package:gp/modules/admin/recipe_management/search_recipe/search_recipe_screen.dart';
import 'package:gp/modules/admin/users_management/search_users/search_users_screen.dart';
import 'package:gp/shared/componants/componants.dart';
import 'package:gp/shared/componants/constant.dart';
import 'package:gp/shared/styles/colors.dart';
import 'package:gp/shared/styles/icon_broken.dart';
import 'package:iconsax/iconsax.dart';
import 'cubit/cubit.dart';

class AdminLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit, AdminStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        AdminCubit cubit = AdminCubit.get(context);
        return ConditionalBuilder(
          condition: state is! GetStockProductsLoadingState ,
          builder: (context) => Scaffold(
            appBar: AppBar(
              title: Text(
                  cubit.titleAppBar[cubit.currentIndex]
              ),
              titleSpacing: 20.0,
              actions:
              [
                if(cubit.currentIndex == 0)
                  Padding(
                    padding: const EdgeInsetsDirectional.only(
                      top: 5,
                    ),
                    child: Stack(
                      alignment: AlignmentDirectional.topEnd,
                      children: [

                        IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            navigateTo(context,FeedBackManagementScreen());
                          },
                          icon: const Icon(Icons.feedback_outlined),
                        ),
                        defaultBodyText(context, text: '${AdminCubit.get(context).feedback.length}',color: defaultColor,fontSize: 12),

                      ],
                    ),
                  ),
                if(cubit.currentIndex == 0)
                  IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      signOut(context);
                    },
                    icon: const Icon(Icons.logout
                    ),

                  ),
                if(cubit.currentIndex == 1)
                  IconButton(
                    onPressed: () {
                      navigateTo(context, SearchUsersScreen());
                    },
                    icon: Icon(IconBroken.Search),

                  ),
                if(cubit.currentIndex == 2)
                  IconButton(
                    onPressed: () {
                      navigateTo(context, SearchRecipeItemScreen());
                    },
                    icon: Icon(IconBroken.Search),

                  ),
                if(cubit.currentIndex == 3)
                  IconButton(
                    onPressed: () {
                      navigateTo(context, SearchProductScreen());
                    },
                    icon: Icon(IconBroken.Search),

                  ),
                if(cubit.currentIndex == 3)
                  Padding(
                    padding: const EdgeInsetsDirectional.only(
                      top: 5,
                      end: 5
                    ),
                    child: Stack(
                      alignment: AlignmentDirectional.topEnd,

                      children: [
                        IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            navigateTo(context, OrderLayoutScreen());
                          },
                          icon: Icon(Icons.notification_important),

                        ),
                        defaultBodyText(context, text: '${AdminCubit.get(context).newOrders.length+AdminCubit.get(context).confirmedOrders.length+AdminCubit.get(context).canceledOrders.length}',color: defaultColor,fontSize: 16),

                      ],
                    ),
                  ),

              ],
            ),
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (index) {
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

          ),
            fallback: (context) => const Center(child: CircularProgressIndicator())
        );
      },

    );
  }
}