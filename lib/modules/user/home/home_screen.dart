import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/layout/home-layout/cubit/cubit.dart';
import 'package:gp/layout/home-layout/cubit/states.dart';
import 'package:gp/modules/user/Lunch/lunch_screen.dart';
import 'package:gp/modules/user/breakfast/breakfast_screen.dart';
import 'package:gp/modules/user/complete_diary/complete_diary_screen.dart';
import 'package:gp/modules/user/dinner/dinner_screen.dart';
import 'package:gp/modules/user/nutrition/nutrition_screen.dart';
import 'package:gp/modules/user/snacks/snacks_screen.dart';
import 'package:gp/modules/user/water_tracker/water_tracker_screen.dart';
import 'package:gp/shared/componants/componants.dart';
import 'package:gp/shared/localization/app_localization%20.dart';
import 'package:intl/intl.dart';

String? dateTime = DateFormat.yMMMEd().format(DateTime.now());

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void initState(){
    HomeCubit.get(context).getCompleteDiaryItems(selectedDate: DateTime.now());
  }

  DateTime selectedDate = DateTime.now()  ;


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          //&& HomeCubit.get(context).userModel!.userActive != null
          condition: HomeCubit.get(context).userModel != null &&
              state is! GetUserDataLoadingState,
          builder: (context) => SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16,left: 16,right: 16),
                  child: Center(
                    child: defaultContainer(
                      context,
                      width: double.infinity,
                      child: TextButton(
                        onPressed: () {
                          print('omar essam $selectedDate');
                          pickDate(context);
                        },
                        child: defaultBodyText(
                          context,
                          text:'${DateFormat('yyyy-MM-dd').format(selectedDate)}',
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 16 ,
                    top: 0 ,
                    right: 16,
                    left: 16,
                  ),
                  child: Column(
                    children: [
                      defaultContainer(
                        context,
                        child: Row(
                          children: [
                            // Expanded(
                            //   flex: 1,
                            //   child: IconButton(
                            //     onPressed: () {
                            //       setState(() {
                            //         dateTime = DateFormat.yMMMEd().format(DateTime.now().add(Duration(days: -1)));
                            //         print('yasterDay = ${dateTime}');
                            //       });
                            //     },
                            //     icon: Icon(
                            //       Icons.arrow_back,
                            //     ),
                            //   ),
                            // ),
                            // Expanded(
                            //   flex: 1,
                            //   child: IconButton(
                            //     onPressed: () {
                            //       setState(() {
                            //         dateTime = DateFormat.yMMMEd().format(DateTime.now().add(Duration(days: 1)));
                            //         print('tommorw = ${dateTime}');
                            //       });
                            //     },
                            //     icon: Icon(
                            //       Icons.arrow_forward,
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      buildNutritionItem(
                        context,
                        title: AppLocalizations.of(context).translate(
                            "calories_remaining"), //'Calories Remaining',
                        calorieText:
                            '${HomeCubit.get(context).userModel!.totalCalorie}',
                        foodText:
                            '${HomeCubit.get(context).calculateTotalFoodCalories()}',
                        remainingText:
                            '${HomeCubit.get(context).userModel!.totalCalorie! - HomeCubit.get(context).calculateTotalFoodCalories()!}',
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      buildHomeScreenItem(
                        context,
                        prefixIcon: Icons.breakfast_dining_outlined,
                        text: AppLocalizations.of(context)
                            .translate("breakfast"), //'Breakfast',
                        screen: BreakFastScreen(),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      buildHomeScreenItem(
                        context,
                        prefixIcon: Icons.lunch_dining_outlined,
                        text: AppLocalizations.of(context)
                            .translate("lunch"), //'Lunch',
                        screen: LunchScreen(),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      buildHomeScreenItem(
                        context,
                        prefixIcon: Icons.dinner_dining_outlined,
                        text: AppLocalizations.of(context)
                            .translate("dinner"), //'Dinner',
                        screen: DinnerScreen(),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      buildHomeScreenItem(
                        context,
                        prefixIcon: Icons.nights_stay_outlined,
                        text: AppLocalizations.of(context)
                            .translate("snacks"), //'Snacks',
                        screen: SnacksScreen(),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      buildHomeScreenItem(
                        context,
                        prefixIcon: Icons.water_rounded,
                        text: AppLocalizations.of(context)
                            .translate("Water Tracker"), //'Water Tracker',
                        screen: WaterTrackerScreen(),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      defaultButton(
                        context,
                        onPreesed: () {
                          navigateTo(context, NutritionScreen());
                        },
                        text: AppLocalizations.of(context)
                            .translate("nutrition"), //'Nutrition',
                        textStyle: Theme.of(context)
                            .textTheme
                            .headline1!
                            .copyWith(color: Colors.white),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      defaultButton(
                        context,
                        onPreesed: () {
                          navigateTo(context, CompleteDiaryScreen());
                        },
                        text: AppLocalizations.of(context)
                            .translate("complete_daily"),
                        //'Complete Diary',
                        textStyle: Theme.of(context)
                            .textTheme
                            .headline1!
                            .copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
  pickDate(BuildContext context)async{
    DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2022),
      lastDate: DateTime(2205),
    );
    if(selected != null && selected != selectedDate)
    {

      setState(() {
        selectedDate = selected ;
        HomeCubit.get(context).getCompleteDiaryItems(selectedDate: selectedDate);
      });
    }
  }
}
/*Scaffold(
            drawer:Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                DrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                    ),
                    child:Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                      [
                        CircleAvatar(
                          radius: 40.0,
                          backgroundImage: NetworkImage(
                              '${HomeCubit.get(context).userModel!.profileImage}'
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          '${HomeCubit.get(context).userModel!.name}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      navigateTo(context, CustomerDashBoardScreen());
                    },
                    child: drawerHeader(HomeCubit.get(context).userModel!),
                  ),
                  buildMenuItem(
                      text: 'Home',
                      icon: IconBroken.Home,
                      onClicked: () {
                        navigateTo(context, HomePage());
                      }
                  ),
                  buildMenuItem(
                      text: 'Market',
                      icon: Iconsax.shop,
                      onClicked: () {
                        navigateTo(context, MarketingScreen());
                      }
                  ),
                  buildMenuItem(
                      text: 'Recipes',
                      icon: Icons.restaurant_menu,
                      onClicked: () {
                        navigateTo(context, RecipeScreen());
                      }
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 15,
                  ),
                  buildMenuItem(
                      text: 'Log Out',
                      icon: Icons.logout,
                      onClicked: () {
                        signOut(context,);
                      }
                  ),
                ],
              ),
            ),
            appBar: AppBar(
              title: Text('Home'),
            ),
            body: ,
          ),
          */
