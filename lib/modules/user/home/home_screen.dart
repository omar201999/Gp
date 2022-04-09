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
import 'package:gp/shared/componants/constant.dart';

class HomePage extends StatelessWidget
{



  @override
  Widget build(BuildContext context)
  {

    return BlocConsumer<HomeCubit,HomeStates>(
      listener: (context, state)
      {

      },
      builder: (context,state)
      {


        return ConditionalBuilder(
          condition: HomeCubit.get(context).userModel != null && state is! GetUserDataLoadingState,
          builder: (context) => Scaffold(
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
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    title: Text('Item 1'),
                    onTap: () {
                      // Update the state of the app
                      // ...
                      // Then close the drawer
                      //navigateTo(context, MarketingScreen());
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: const Text('Item 2'),
                    onTap: () {
                      // Update the state of the app
                      // ...
                      // Then close the drawer
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
            appBar: AppBar(
              title: Text('Home'),
              actions:
              [
                defaultTextButton(
                  context,
                  text: 'log out',
                  fontSize: 14,
                  isUpper: false,
                  function: () {
                    signOut(context,);
                  },
                ),
              ],
            ),
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children:
                [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children:
                      [
                        // Container(
                        //   decoration: BoxDecoration(
                        //     color: Colors.white,
                        //
                        //   ),
                        //   child: Row(
                        //     children:
                        //     [
                        //       Expanded(
                        //         flex: 1,
                        //         child: IconButton(
                        //           onPressed: (){},
                        //           icon: Icon
                        //             (
                        //             Icons.arrow_back,
                        //           ),
                        //         ),
                        //       ),
                        //       Expanded(
                        //         flex: 2,
                        //         child: TextButton(
                        //           onPressed: (){},
                        //           child: Text(
                        //             'Today',
                        //             textAlign: TextAlign.center,
                        //             style: TextStyle
                        //               (
                        //                 fontWeight: FontWeight.w300,
                        //                 color: Colors.black
                        //             ),
                        //           ),
                        //         ),
                        //       ),
                        //       Expanded(
                        //         flex: 1,
                        //         child: IconButton(
                        //           onPressed: (){},
                        //           icon: Icon
                        //             (
                        //             Icons.arrow_forward,
                        //           ),
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        buildNutritionItem(
                          context,
                          title: 'Calories Remaining',
                          calorieText: '${HomeCubit.get(context).userModel!.totalCalorie}',
                          foodText: '${HomeCubit.get(context).food()}',
                          remainingText: '${HomeCubit.get(context).userModel!.totalCalorie! - HomeCubit.get(context).food()}',
                        ),

                        SizedBox(
                          height:10,
                        ),
                        buildHomeScreenItem(
                          context,
                          prefixIcon: Icons.breakfast_dining_outlined,
                          text: 'Breakfast',
                          screen: BreakFastScreen(),
                        ),
                        SizedBox(
                          height:10,
                        ),
                        buildHomeScreenItem(
                          context,
                          prefixIcon: Icons.lunch_dining_outlined,
                          text: 'Lunch',
                          screen: LunchScreen(),
                        ),
                        SizedBox(
                          height:10,
                        ),
                        buildHomeScreenItem(
                          context,
                          prefixIcon: Icons.dinner_dining_outlined,
                          text: 'Dinner',
                          screen: DinnerScreen(),
                        ),
                        SizedBox(
                          height:10,
                        ),
                        buildHomeScreenItem(
                          context,
                          prefixIcon: Icons.nights_stay_outlined,
                          text: 'Snacks',
                          screen: SnacksScreen(),
                        ),
                        SizedBox(
                          height:10,
                        ),
                        buildHomeScreenItem(
                          context,
                          prefixIcon: Icons.water_rounded,
                          text: 'Water Tracker',
                          screen: WaterTrackerScreen(),
                        ),
                        SizedBox(
                          height:10,
                        ),
                        defaultButton(
                          context,
                          onPreesed: ()
                          {
                            navigateTo(context, NutritionScreen());
                          },
                          text: 'Nutrition',
                          textStyle: Theme.of(context).textTheme.headline1!.copyWith(
                              color: Colors.white
                          ),
                        ),
                        SizedBox(
                          height:10,
                        ),
                        defaultButton(
                          context,
                          onPreesed: ()
                          {
                            navigateTo(context, CompleteDiaryScreen());

                          },
                          text: 'Complete Diary',
                          textStyle: Theme.of(context).textTheme.headline1!.copyWith(
                              color: Colors.white
                          ),
                        ),



                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },

    );
  }
}
