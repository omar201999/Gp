import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/layout/home-layout/cubit/states.dart';
import 'package:gp/modules/user/buy_now/buy-now-screen.dart';
import 'package:gp/modules/user/cart/cart_screen.dart';
import 'package:gp/modules/user/complete_diary/complete_diary_screen.dart';
import 'package:gp/modules/user/market/search/search_market_screen.dart';
import 'package:gp/modules/user/nutrition/nutrition_screen.dart';
import 'package:gp/modules/user/search_recipe_screen/search_screen.dart';
import 'package:gp/shared/componants/componants.dart';
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
        return ConditionalBuilder(
          condition: HomeCubit.get(context).userModel != null && state is! GetUserDataLoadingState,
          builder: (context)=>Scaffold(
          drawer:Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                drawerHeader(HomeCubit.get(context).userModel!),

                  buildMenuItem(
                    text: 'Buy Now',
                    icon: IconBroken.Buy,
                    onClicked: () {
                      if(HomeCubit.get(context).cart.isNotEmpty)
                      {
                        navigateTo(context, BuyNowScreen());
                      }
                      else
                      {
                        showToast(
                            text: 'Your Cart is Empty',
                            state: ToastStates.ERROR);
                      }

                    }
                ),
                buildMenuItem(
                    text: 'My Cart ',
                    icon: Iconsax.shopping_cart,
                    onClicked: () {
                      navigateTo(context, CartScreen());
                    }
                ),
                buildMenuItem(
                    text: 'Complete Diary',
                    icon: Icons.food_bank_outlined,
                    onClicked: () {
                      navigateTo(context, CompleteDiaryScreen());
                    }
                ),
                buildMenuItem(
                    text: 'Nutrition',
                    icon: Icons.health_and_safety,
                    onClicked: () {
                      navigateTo(context, NutritionScreen());
                    }
                ),
                const Divider(),
                const SizedBox(
                  height: 15,
                ),
                buildMenuItem(
                    text: ' 🥺 Log Out ',
                    icon: Icons.logout,
                    onClicked: () {
                     signOut(context);
                    }
                ),
              ],
            ),
          ),
          appBar: AppBar(
            title: Text(
              cubit.titleAppBar[cubit.currentIndex],
            ),
            actions:
            [
              if(cubit.currentIndex == 1)
                IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    navigateTo(context, CartScreen());

                  },
                  icon: Icon(
                    Icons.shopping_cart,
                  ),
                ),
              if(cubit.currentIndex == 1)
                IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    navigateTo(context, SearchMarketingscreen());
                  },
                  icon: Icon(
                      IconBroken.Search
                  ),
                ),
              if(cubit.currentIndex == 2)
                IconButton(
                  onPressed:()
                  {
                    navigateTo(context,SearchRecipeScreen());
                  },
                  icon: Icon(
                    IconBroken.Search,
                  ),
                ),

            ],
          ),
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
        ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },

    );

  }
}
