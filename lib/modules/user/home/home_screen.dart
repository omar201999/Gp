import 'package:carousel_slider/carousel_slider.dart';
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
import 'package:gp/modules/user/recipe/recipe_item_screen.dart';
import 'package:gp/modules/user/snacks/snacks_screen.dart';
import 'package:gp/modules/user/water_tracker/water_tracker_screen.dart';
import 'package:gp/shared/componants/componants.dart';
import 'package:gp/shared/componants/constant.dart';
import 'package:gp/shared/localization/app_localization%20.dart';
import 'package:gp/shared/styles/icon_broken.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _current = 0;

  final CarouselController _controller = CarouselController();

  bool isLast = false;



  @override
  void initState()
  {
    super.initState();
    HomeCubit.get(context).getCompleteDiaryItems2(DateFormat('d MMMM y').format(DateTime.now()));
    HomeCubit.get(context).getFavoritesRecipes();

  }

  DateTime selectedDate = DateTime.now()  ;


  @override
  Widget build(BuildContext context) {

    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state)
      {

        List<String> boarding =
        [
          'https://firebasestorage.googleapis.com/v0/b/nutrition-system-873a0.appspot.com/o/recipes%2Fimage_picker2949530721345817905.jpg?alt=media&token=ab1ab2cb-1689-4f67-aeb8-06a94a2889d6',
          'https://firebasestorage.googleapis.com/v0/b/nutrition-system-873a0.appspot.com/o/recipes%2Fimage_picker4480257411949826948.jpg?alt=media&token=b74f2d72-a77d-4a02-a3c6-fb1d7c0caeda',
          'https://firebasestorage.googleapis.com/v0/b/nutrition-system-873a0.appspot.com/o/recipes%2Fimage_picker706153797030710715.jpg?alt=media&token=762bbc48-afb7-42c2-bb8b-9a2f37722193',

        ];
        return ConditionalBuilder(
          //&& HomeCubit.get(context).userModel!.userActive != null
          condition: HomeCubit.get(context).userModel != null && state is! GetUserDataLoadingState && state is !GetAllUsersMealsLoadingState,
          builder: (context) => SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  TextButton(
                    onPressed: () {
                      //print('omar essam $selectedDate');
                      pickDate(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:
                      [
                        Icon(
                          IconBroken.Calendar,
                          color: Theme.of(context).iconTheme.color,
                        ),
                        SizedBox(width: 5,),
                        defaultBodyText(
                          context,
                          text:DateFormat('d MMMM y',lan).format(selectedDate),//Today
                          fontSize: 20,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 300,
                    child: Column(
                      children: [
                        Expanded(
                          child: CarouselSlider(
                            carouselController: _controller,
                            items: boarding
                                .map(
                                  (e) => InkWell(
                                    onTap: ()
                                    {
                                      if(_current==0) {
                                        navigateTo(context, RecipeItemScreen(recipeModel: HomeCubit.get(context).allRecipe[1], index: 1,));
                                      }
                                      if(_current==1) {
                                        navigateTo(context, RecipeItemScreen(recipeModel: HomeCubit.get(context).allRecipe[3],index: 3,));
                                      }
                                      if(_current==2) {
                                        navigateTo(context, RecipeItemScreen(recipeModel: HomeCubit.get(context).allRecipe[4],index: 4,));
                                      }
                                    },
                                    child: Card(
                                      shape:RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(15)),
                                      ),
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      child: Image(
                                        image:NetworkImage(e),
                                        fit: BoxFit.cover,
                                        width: MediaQuery.of(context).size.width,
                                        height:MediaQuery.of(context).size.height,
                                      ),

                                    ),
                                  ),
                            )
                                .toList(),
                            options: CarouselOptions(
                              aspectRatio: 2.0,
                              enlargeCenterPage: true,
                              height: 300,
                              enableInfiniteScroll: true,
                              reverse: false,
                              autoPlay: true,
                              autoPlayInterval: Duration(seconds: 3),
                              autoPlayAnimationDuration: Duration(seconds: 1),
                              autoPlayCurve: Curves.fastOutSlowIn,
                              scrollDirection: Axis.horizontal,
                              onPageChanged: (index, reason)
                              {
                                setState(() {
                                  _current = index;
                                });
                              }
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: boarding.asMap().entries.map((entry) {
                            return GestureDetector(
                              onTap: () => _controller.animateToPage(entry.key),
                              child: Container(
                                width: 12.0,
                                height: 12.0,
                                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: (Theme.of(context).brightness == Brightness.dark
                                        ? Colors.white
                                        : Colors.blue)
                                        .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                              ),
                            );
                          }).toList(),
                        ),

                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  buildHomeScreenProgressItem(context),
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
          ),
          fallback: (context) => const Scaffold(
              backgroundColor: Colors.white,
              body: Center(
                  child: Image(
                      image: AssetImage('assets/images/logo.png')
                  )
              )
          ),
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
        HomeCubit.get(context).getCompleteDiaryItems2(DateFormat('d MMMM y').format(selectedDate));
      });
    }
  }
}
