import 'package:flutter/material.dart';
import 'package:gp/modules/Lunch/lunch_screen.dart';
import 'package:gp/modules/breakfast/breakfast_screen.dart';
import 'package:gp/modules/dinner/dinner_screen.dart';
import 'package:gp/modules/nutrition/nutrition_screen.dart';
import 'package:gp/modules/snacks/snacks_screen.dart';
import 'package:gp/modules/water_tracker/water_tracker_screen.dart';
import 'package:gp/shared/componants/componants.dart';
import 'package:gp/shared/styles/colors.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: buildAppBar(
        title: 'Home',
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
                  defaultContainer(
                    child: Padding(
                      padding: const EdgeInsetsDirectional.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:
                        [
                          defaultHeadLineText(
                            context,
                            text: 'Calories Remaining',
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            children:
                            [
                              Expanded(

                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children:
                                  [
                                    Text(
                                      '2782',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Goal',
                                      style: TextStyle(
                                          color: Colors.grey[500]
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.only(
                                      bottom: 20
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children:
                                    [
                                      Text(
                                        '-',
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children:
                                  [
                                    Text(
                                      '0',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Food',
                                      style: TextStyle(
                                          color: Colors.grey[500]
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.only(
                                      bottom: 20
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children:
                                    [
                                      Text(
                                        '=',
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children:
                                  [
                                    Text(
                                      '2782',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: defaultColor
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Remaining',
                                      style: TextStyle(
                                          color: Colors.grey[500],
                                          fontSize: 13
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                            ],
                          ),

                        ],
                      ),
                    ),
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
                    prefixIcon: Icons.water_drop,
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
    );
  }
}
