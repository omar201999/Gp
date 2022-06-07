import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/layout/home-layout/cubit/states.dart';
import 'package:gp/main.dart';
import 'package:gp/modules/user/buy_now/buy-now-screen.dart';
import 'package:gp/modules/user/cart/cart_screen.dart';
import 'package:gp/modules/user/complete_diary/complete_diary_screen.dart';
import 'package:gp/modules/user/favorite_products/favorite_products.dart';
import 'package:gp/modules/user/favorite_recipes/favorite_recipes.dart';
import 'package:gp/modules/user/feedback_screen/feedback_screen.dart';
import 'package:gp/modules/user/market/search/search_market_screen.dart';
import 'package:gp/modules/user/nutrition/nutrition_screen.dart';
import 'package:gp/modules/user/orders_layout/order_layout_screen/order_layout_creen.dart';
import 'package:gp/modules/user/search_recipe_screen/search_screen.dart';
import 'package:gp/shared/componants/componants.dart';
import 'package:gp/shared/componants/constant.dart';
import 'package:gp/shared/cubit/cubit.dart';
import 'package:gp/shared/localization/app_localization%20.dart';
import 'package:gp/shared/localization/language.dart';
import 'package:gp/shared/styles/icon_broken.dart';
import 'package:iconsax/iconsax.dart';
import 'package:gp/shared/styles/colors.dart';
import 'cubit/cubit.dart';

class HomeLayout extends StatefulWidget {

  @override
  State<HomeLayout> createState() => _HomeLayoutState();

}

class _HomeLayoutState extends State<HomeLayout> {

@override
  void initState() {
    super.initState();
    HomeCubit.get(context).getUserData();
}
  void _changeLanguage(Language language) async {
    Locale _locale = await setLocale(language.languageCode);
    MyApp.setLocale(context, _locale);
  }

  @override
  Widget build(BuildContext context)
  {
    List<String> titleAppBar =
    [
      AppLocalizations.of(context).translate("home_app_bar"),//'Home',
      AppLocalizations.of(context).translate("market"),//'Market',
      AppLocalizations.of(context).translate("recipe"),//'Recipe',
      AppLocalizations.of(context).translate("me"),//'Me'
    ];
    return BlocConsumer<HomeCubit,HomeStates>(
      listener: (context, state)
      {

      },
      builder: (context, state)
      {

        HomeCubit cubit = HomeCubit.get(context);
        return ConditionalBuilder(
        //&& HomeCubit.get(context).userModel!.userActive != null
          condition: HomeCubit.get(context).userModel != null  ,
          builder: (context)=>Scaffold(
          drawer:Drawer(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.zero,
              children: [
                Container(
                  color: defaultColor,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: drawerHeader(HomeCubit.get(context).userModel!),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: SwitchListTile(
                    value: AppCubit.get(context).isDark,
                    onChanged: (value) {
                      setState(() {
                        AppCubit.get(context).changeAppMode(fromCache: value);
                      });
                    },
                    title: defaultHeadLineText(context, text: AppLocalizations.of(context).translate("dark_mood")),//'Dark Mode'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      DropdownButton<Language>(
                        iconSize: 30,
                        hint: defaultHeadLineText(context,text: AppLocalizations.of(context).translate("change_language")),
                        onChanged: (Language? language) {
                          _changeLanguage(language!);
                        },
                        items: Language.languageList()
                            .map<DropdownMenuItem<Language>>(
                              (e) => DropdownMenuItem<Language>(
                            value: e,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Text(
                                  e.flag,
                                  style: TextStyle(fontSize: 30),
                                ),
                                Text(e.name)
                              ],
                            ),
                          ),
                        ).toList(),
                      ),
                    ],
                  ),
                ),
                  buildMenuItem(
                      context,
                    text: AppLocalizations.of(context).translate("buy_now"),//'Buy Now',
                    icon: IconBroken.Buy,
                    onClicked: () {
                      if(HomeCubit.get(context).cart.isNotEmpty)
                      {
                        navigateTo(context, BuyNowScreen());
                      }
                      else
                      {
                        showToast(
                            text: AppLocalizations.of(context).translate("your_cart"),//'Your Cart is Empty',
                            state: ToastStates.ERROR);
                      }

                    }
                ),
                SizedBox(height: 5,),
                buildMenuItem(
                    context,
                    text: AppLocalizations.of(context).translate("my_cart"),//'My Cart ',
                    icon: Iconsax.shopping_cart,
                    onClicked: () {
                      navigateTo(context, CartScreen());
                    }
                ),
                SizedBox(height: 5,),
                buildMenuItem(
                    context,

                    text: AppLocalizations.of(context).translate("complete_daily"),//'Complete Diary',
                    icon: Icons.food_bank_outlined,
                    onClicked: () {
                      navigateTo(context, CompleteDiaryScreen());
                    }
                ),
                SizedBox(height: 5,),
                buildMenuItem(
                    context,
                    text: AppLocalizations.of(context).translate("nutrition"),//'Nutrition',
                    icon: Icons.health_and_safety,
                    onClicked: () {
                      navigateTo(context, NutritionScreen());
                    }
                ),
                SizedBox(height: 5,),
                buildMenuItem(
                    context,
                    text:AppLocalizations.of(context).translate("FeedBack"),
                    icon:Icons.feedback_outlined,
                    onClicked: () {
                      navigateTo(context, FeedbackScreen());
                    }
                ),
                SizedBox(height: 5,),
                buildMenuItem(
                    context,
                    text:AppLocalizations.of(context).translate("Orders"),
                    icon:IconBroken.Category,
                    onClicked: () {
                      navigateTo(context, OrderLayoutScreen());
                    }
                ),
                SizedBox(height: 5,),
                buildMenuItem(
                    context,
                    text:AppLocalizations.of(context).translate("Favorite Recipes"),
                    icon: Icons.restaurant_menu_outlined,
                    onClicked: () {
                      navigateTo(context, FavoriteRecipes());
                    }
                ),
                SizedBox(height: 5,),
                buildMenuItem(
                    context,
                    text:AppLocalizations.of(context).translate("Favorite Products"),
                    icon: Iconsax.shop4,
                    onClicked: () {
                      navigateTo(context, FavoriteProducts());
                    }
                ),
                const Divider(),
                const SizedBox(
                  height: 15,
                ),
                buildMenuItem(
                    context,
                    text: AppLocalizations.of(context).translate("log_out"),//' 🥺 Log Out ',
                    icon: Icons.logout,
                    onClicked: () {
                     signOut(context);
                    }
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          appBar: AppBar(
            title: Text(
              titleAppBar[cubit.currentIndex],
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
             [
              BottomNavigationBarItem(
                  icon: Icon(
                      IconBroken.Home
                  ),
                  label: AppLocalizations.of(context).translate("home_app_bar"),//'Home'
              ),
              BottomNavigationBarItem(
                  icon: Icon(
                      Iconsax.shop4
                  ),
                  label:  AppLocalizations.of(context).translate("marketing"),//'Marketing'
              ),
              BottomNavigationBarItem(
                  icon: Icon(
                      Icons.restaurant_menu_outlined
                  ),
                  label:  AppLocalizations.of(context).translate("recipe"),//'Recipe'
              ),
              BottomNavigationBarItem(
                  icon: Icon(
                      Iconsax.user
                  ),
                  label:  AppLocalizations.of(context).translate("me"),//'Me'
              ),

            ],
          ),
          body: cubit.bodyScreen[cubit.currentIndex],
        ),
          fallback: (context) => const Scaffold(
              backgroundColor: Colors.white,
              body: Center(
                  child:CircularProgressIndicator(),
              )
          ),
        );
      },

    );

  }
}
