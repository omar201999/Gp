import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gp/layout/admin_layout/cubit/cubit.dart';
import 'package:gp/layout/home-layout/cubit/cubit.dart';
import 'package:gp/layout/home-layout/cubit/states.dart';
import 'package:gp/models/meals_model.dart';
import 'package:gp/models/new_order_model.dart';
import 'package:gp/models/product_model.dart';
import 'package:gp/models/recipes_model.dart';
import 'package:gp/models/user_model.dart';
import 'package:gp/modules/admin/market_management/products_for_order.dart';
import 'package:gp/modules/user/camera/Camera_Screen.dart';
import 'package:gp/modules/user/market/items/marketitem_screen.dart';
import 'package:gp/modules/user/meal_item/meal_item_screen.dart';
import 'package:gp/modules/user/orders_layout/products_for_order_user.dart';
import 'package:gp/modules/user/recipe/recipe_item_screen.dart';
import 'package:gp/shared/componants/constant.dart';
import 'package:gp/shared/cubit/cubit.dart';
import 'package:gp/shared/localization/app_localization%20.dart';
import 'package:gp/shared/styles/colors.dart';
import 'package:gp/shared/styles/icon_broken.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:simple_shadow/simple_shadow.dart';
AppBar buildAppBar({
  required String title,
  void Function()? onPressed,
  IconData? icon,
  //IconData? icon,
  Widget? leadingIcon,
  List<Widget>? actions,
  double? titleSpacing = 15.0,

}) =>  AppBar(
  leading: leadingIcon??IconButton(
       onPressed: onPressed,
       icon: Icon(icon)
  ),
  title: Text(
    title,
  ),
  titleSpacing: titleSpacing,
  actions: actions,

  /*[
    IconButton(
      onPressed: onPressed ,
      icon: Icon(icon),
    ),
  ],*/
);


Widget defaultTextFormField({

  TextEditingController? controller,
  required TextInputType type,
  void Function()? onTap,
  void Function(String)? onChanged,
  void Function(String)? onSubmitted,
  bool obscure = false,
  String? Function(String?)? validate,
  int? maxLines = 1,
  Color? color = constantColor5,

  //////////////////////////////////////
  String? label ,
  IconData? prefix,
  IconData? suffix,
  void Function()? suffixPressed,
  String? hintText,
  InputBorder? border ,
  BorderRadius? borderRadius
}) => TextFormField(
  controller: controller,
  keyboardType: type,
  onTap: onTap,
  onChanged: onChanged,
  onFieldSubmitted: onSubmitted,
  obscureText: obscure,
  validator: validate,
  maxLines: maxLines,

  //decoration of textFormField

  decoration: InputDecoration(
    hintText: hintText,
    labelText : label,
    filled: true,
    fillColor: color,
    suffixIcon: IconButton(
      onPressed: suffixPressed,
      icon: Icon(suffix),
    ),
    prefixIcon: Icon(
      prefix,
    ),
    border: border??OutlineInputBorder(
        borderRadius: borderRadius??BorderRadius.all(
          Radius.circular(15.0),
        ),
        borderSide: BorderSide.none
    ),

  ),

);

Widget defaultButton(BuildContext context,{
  required void Function()? onPreesed,
  required String text ,
  double radius = 10,
  TextStyle? textStyle ,
}
    ) => Container(
  decoration: BoxDecoration(
    color: defaultColor,
    borderRadius: BorderRadius.circular(radius),
  ),
  width: double.infinity,
  child: MaterialButton(
    onPressed: onPreesed,
    child: Text(
      text,
      style: textStyle??Theme.of(context).textTheme.headline1!.copyWith(
        color: Colors.white,
      ),
    ),
  ),
);


void navigateTo (context , widget) => Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => widget  ,
    )
);

void navigateToAndReplacement (context , widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget  ,
    ),(route){
  return false;
}
);

Widget defaultContainer(BuildContext context,{
  double? width,
  double? height,
  double radius = 10,
  Clip clip = Clip.antiAliasWithSaveLayer,
  //Color? color = constantColor1,
  Widget? child,
  BoxDecoration? decoration ,
}) => Container(
  width: width,
  height: height,
  clipBehavior: clip,
  decoration: decoration??BoxDecoration(
    /*gradient:  LinearGradient(
      colors: [
        Colors.grey[50]!,
        HexColor('#1c1c1c '),
      ],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ),*/
    color: AppCubit.get(context).constantColor1,//HexColor('#4d4d4d')
    borderRadius: BorderRadius.circular(radius),
  ),
  child: child,
);

Widget defaultGestureDetector({
  required void Function()? onTap ,
  required Widget child ,
}) => GestureDetector(
  onTap: onTap,
  child:child,
);

Widget defaultHeadLineText(BuildContext context, {
  TextOverflow? overflow = TextOverflow.ellipsis ,
  int? maxLines,
  required String text,
  FontWeight? fontWeight ,
  Color? color,
  double? fontSize,
}) => Text(
  text,
  style: Theme.of(context).textTheme.headline1?.copyWith(
    fontWeight: fontWeight,
    color: color,
    fontSize: fontSize
  ),
  maxLines: maxLines,
  overflow: overflow,
);

Widget defaultBodyText(BuildContext context,{
  required String text,
  FontWeight? fontWeight ,
  double? fontSize,
  Color? color,
  int? maxLines,
  double? height,
  double? letterSpacing,
  TextOverflow? overflow


}) => Text(
  text,
  style: Theme.of(context).textTheme.bodyText1?.copyWith(
    fontWeight: fontWeight,
    fontSize: fontSize,
    color: color,
    height: height,
      letterSpacing:letterSpacing,
    overflow: overflow,
  ),
  maxLines: maxLines,

);

Widget buildRecipeItem(RecipeModel model,context,index) => defaultGestureDetector(
  onTap: ()
  {
    navigateTo(context, RecipeItemScreen(
      recipeModel: model, index: index,
    ));
  },
  child: defaultContainer(
    context,
    height: 250,
    width: 180,
    //color: constantColor5,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
      [
        Expanded(
          flex: 4,
          child: Image(
            image: NetworkImage('${model.image}'),
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        if(lan=='en')
          Expanded(
          child: Padding(
            padding: const EdgeInsetsDirectional.only(
                start: 10
            ),
            child: defaultBodyText(context, text: '${model.title}',maxLines: 2,height: 1.3),
          ),
        ),
        if(lan=='ar')
          Expanded(
            child: Padding(
              padding: const EdgeInsetsDirectional.only(
                  start: 10
              ),
              child: defaultBodyText(context, text: '${model.titleAr}',maxLines: 2,height: 1.3),
            ),
          ),
        Expanded(
          child: Padding(
            padding: const EdgeInsetsDirectional.only(
              start: 10,
            ),
            child: Row(
              children:
              [
                defaultBodyText(context, text: '${model.calories}',letterSpacing: 1),
                SizedBox(
                  width: 4,
                ),
                defaultBodyText(context, text: 'cal',fontSize: 15),
              ],
            ),
          ),
        ),
      ],
    ),
  ),
);



Widget headOfRecipeItem(BuildContext context, {
  required String head,
}) => Padding(
    padding: EdgeInsets.symmetric(
        vertical: 15
    ),
    child: Row(
      children:
      [
        Expanded(
          child: defaultHeadLineText(
            context,
            text: head,
          ),
        ),

      ],
    )
);

Widget buildHomeScreenItem(BuildContext context,{
  required Widget screen,
  required IconData prefixIcon,
  IconData suffixIcon = Icons.add,
  required String text,

}) => defaultGestureDetector(
  onTap: ()
  {
    navigateTo(context, screen);
  },
  child: defaultContainer(
    context,

    child: Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children:
        [
          Icon(
            prefixIcon,
          ),
          SizedBox(
            width: 8,
          ),
          defaultHeadLineText(
            context,
            text: text,
          ),
          Spacer(),
          Icon(
            suffixIcon,
          ),
        ],
      ),
    ),
  ),
);


Widget afterTitleOfRecipeItem(BuildContext context, {
   String? percentage,
  required String? numberOfGrams,
  required String? nameOfType,
  Color? color,
}) => Expanded(
  child: Column(
    mainAxisSize: MainAxisSize.min,
    children:
    [
      //defaultBodyText(context, text: percentage! ,color: color),
      defaultBodyText(context, text: numberOfGrams! ),
      defaultBodyText(context, text: nameOfType! ),
    ],
  ),
);

Widget defaultTextButton( BuildContext context,{
  required void Function()? function,
  required String text,
  Color? color = defaultColor,
  bool isUpper = true,
  double? fontSize,

}) =>
    TextButton(

      onPressed:function,
      child: defaultBodyText(
          context,
          text: isUpper ? text.toUpperCase() : text,
          color: color,
          fontSize: fontSize,
      ),
    );

void showToast({
  required String text,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0,
    );

// enum
enum ToastStates { SUCCESS, ERROR, WARNING, NOTE }

Color chooseToastColor(ToastStates state) {
  Color color;

  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
    case ToastStates.NOTE:
      color = Colors.grey;
      break;
  }

  return color;
}
Widget myDivider() => Padding(
  padding: const EdgeInsetsDirectional.only(
    start: 20,
  ),
  child: Container(
    width: double.infinity,
    height: 1,
    color: Colors.grey[300],
  ),
);

/*Widget defaultTextButton1 ({
  required void Function()? onPressed,
  required String text,
  required BuildContext context,
  Color? color = defaultColor,
}) => TextButton(
    onPressed: onPressed,
    child: defaultBodyText(
        context,
        text: text,
        color: color
    )
);*/

/*defaultAppBar( BuildContext context,{
  required String title,
  List<Widget>? actions
}) => AppBar(
  leading: IconButton(
    onPressed: () {
      Navigator.pop(context);
    },
    icon: const Icon(
      IconBroken.Arrow___Left_2,
    ),
  ),
  titleSpacing: 5.0,
  title: Text(title),
  actions: actions,

);*/

Widget buildHomeScreenProgressItem(BuildContext context) =>defaultContainer(
  context,
  child: Padding(
    padding: const EdgeInsets.all(10.0),
    child: Column(
      children: [
        Row(
          children:
          [
            Expanded(
              child: Column(
                children:
                [
                  defaultHeadLineText(context, text: '${HomeCubit.get(context).calculateTotalFoodCalories()}'),
                  Text(
                    AppLocalizations.of(context).translate("food"),//'Food',
                    style: Theme.of(context).textTheme.caption,
                    textAlign: TextAlign.center,
                  ),

                ],
              ),
            ),
            if(HomeCubit.get(context).calculateTotalFoodCalories()! / HomeCubit.get(context).userModel!.totalCalorie! >= 0 &&  HomeCubit.get(context).calculateTotalFoodCalories()! / HomeCubit.get(context).userModel!.totalCalorie! <= 1)
              Expanded(
                child: CircularPercentIndicator(
                  radius: 60,
                  animation: true,
                  animationDuration: 1000,
                  lineWidth: 5,
                  percent: HomeCubit.get(context).calculateTotalFoodCalories()! / HomeCubit.get(context).userModel!.totalCalorie!,
                  center: Column(
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:
                    [
                      defaultHeadLineText(context, text:  '${HomeCubit.get(context).userModel!.totalCalorie! - HomeCubit.get(context).calculateTotalFoodCalories()!}',fontSize: 18),
                      Text(
                        AppLocalizations.of(context).translate("remaining"),//'Food',
                        style: Theme.of(context).textTheme.caption,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,

                      ),


                    ],
                  ),
                  circularStrokeCap: CircularStrokeCap.butt,
                  backgroundColor: Colors.grey,
                  progressColor: Colors.blue,
                ),
              ),
            if(HomeCubit.get(context).calculateTotalFoodCalories()! / HomeCubit.get(context).userModel!.totalCalorie! > 1)
              Expanded(
                child: CircularPercentIndicator(
                  radius: 60,
                  animation: true,
                  animationDuration: 1000,
                  lineWidth: 5,
                  percent:1,
                  center: Column(
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:
                    [
                      if(HomeCubit.get(context).calculateTotalFoodCalories()! < (HomeCubit.get(context).userModel!.totalCalorie)!.round() )
                        defaultHeadLineText(context, text:  '${HomeCubit.get(context).userModel!.totalCalorie! - HomeCubit.get(context).calculateTotalFoodCalories()!}',fontSize: 18),
                      if(HomeCubit.get(context).calculateTotalFoodCalories()! >= (HomeCubit.get(context).userModel!.totalCalorie)!.round() )
                        defaultHeadLineText(context, text:  '0',fontSize: 18),

                      Text(
                        AppLocalizations.of(context).translate("remaining"),//'Food',
                        style: Theme.of(context).textTheme.caption,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),


                    ],
                  ),
                  circularStrokeCap: CircularStrokeCap.butt,
                  backgroundColor: Colors.grey,
                  progressColor: Colors.blue,
                ),
              ),
            Expanded(
              child: Column(
                children:
                [
                  if(HomeCubit.get(context).calculateTotalFoodCalories()! - HomeCubit.get(context).userModel!.totalCalorie! < 0)
                    defaultHeadLineText(context, text: '0'),
                  if(HomeCubit.get(context).calculateTotalFoodCalories()! - HomeCubit.get(context).userModel!.totalCalorie! >= 0)
                    defaultHeadLineText(context, text: '${HomeCubit.get(context).calculateTotalFoodCalories()! - HomeCubit.get(context).userModel!.totalCalorie!}'),
                  Text(
                    AppLocalizations.of(context).translate("goal"),//'Food',
                    style: Theme.of(context).textTheme.caption,
                    textAlign: TextAlign.center,

                  ),

                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children:
          [
            Expanded(
              child: defaultContainer(
                context,
                radius: 0,
                child: Column(
                  children:
                  [
                    defaultBodyText(context, text:  AppLocalizations.of(context).translate("Carbs")),
                    SizedBox(
                      height: 5,
                    ),
                    if( HomeCubit.get(context).calculateTotalCarbs() / HomeCubit.get(context).userModel!.totalCarbs! >= 0 && HomeCubit.get(context).calculateTotalCarbs()/ HomeCubit.get(context).userModel!.totalCarbs! <= 1)
                      LinearPercentIndicator(
                        animation: true,
                        animationDuration: 500,
                        curve: Curves.easeInOut,
                        barRadius: const Radius.circular(15),
                        //width: MediaQuery.of(context).size.width,
                        lineHeight: 5,
                        percent: HomeCubit.get(context).calculateTotalCarbs()/ HomeCubit.get(context).userModel!.totalCarbs! ,
                        backgroundColor: Colors.grey,
                        progressColor: Colors.blue,
                      ),
                    if( HomeCubit.get(context).calculateTotalCarbs() / HomeCubit.get(context).userModel!.totalCarbs! > 1)
                      LinearPercentIndicator(
                        animation: true,
                        animationDuration: 500,
                        curve: Curves.easeInOut,
                        barRadius: const Radius.circular(15),
                        //width: MediaQuery.of(context).size.width,
                        lineHeight: 5,
                        percent: 1,
                        backgroundColor: Colors.grey,
                        progressColor: Colors.blue,
                      ),

                    SizedBox(
                      height: 5,
                    ),
                    defaultBodyText(context, text: '${HomeCubit.get(context).calculateTotalCarbs()} / ${HomeCubit.get(context).userModel!.totalCarbs!}${AppLocalizations.of(context).translate("g")}'),

                  ],
                ),
              ),
            ),
            Expanded(
              child: defaultContainer(
                context,
                radius: 0,
                child: Column(
                  children:
                  [
                    defaultBodyText(context, text: AppLocalizations.of(context).translate("Protein")),
                    SizedBox(
                      height: 5,
                    ),
                    if( HomeCubit.get(context).calculateTotalProtein()/ HomeCubit.get(context).userModel!.totalProtein! >= 0 && HomeCubit.get(context).calculateTotalProtein() / HomeCubit.get(context).userModel!.totalProtein! <= 1)
                      LinearPercentIndicator(
                        animation: true,
                        animationDuration: 500,
                        curve: Curves.easeInOut,
                        barRadius: const Radius.circular(15),
                        //width: MediaQuery.of(context).size.width,
                        lineHeight: 5,
                        percent: HomeCubit.get(context).calculateTotalProtein()/ HomeCubit.get(context).userModel!.totalProtein! ,
                        backgroundColor: Colors.grey,
                        progressColor: Colors.blue,
                      ),
                    if((HomeCubit.get(context).userModel!.totalProtein! - HomeCubit.get(context).calculateTotalProtein()) / HomeCubit.get(context).userModel!.totalProtein! < 0)
                      LinearPercentIndicator(
                        animation: true,
                        animationDuration: 500,
                        curve: Curves.easeInOut,
                        barRadius: const Radius.circular(15),
                        //width: MediaQuery.of(context).size.width,
                        lineHeight: 5,
                        percent: 1,
                        backgroundColor: Colors.grey,
                        progressColor: Colors.blue,
                      ),
                    SizedBox(
                      height: 5,
                    ),
                    defaultBodyText(context, text: '${HomeCubit.get(context).calculateTotalProtein()} / ${HomeCubit.get(context).userModel!.totalProtein!}${AppLocalizations.of(context).translate("g")}'),

                  ],
                ),
              ),
            ),
            Expanded(
              child: defaultContainer(
                context,
                radius: 0,
                child: Column(
                  children:
                  [
                    defaultBodyText(context, text: AppLocalizations.of(context).translate("Fats")),
                    SizedBox(
                      height: 5,
                    ),
                    if( HomeCubit.get(context).calculateTotalFats() / HomeCubit.get(context).userModel!.totalFats!>= 0 && HomeCubit.get(context).calculateTotalFats() / HomeCubit.get(context).userModel!.totalFats! <= 1 )
                      LinearPercentIndicator(
                        animation: true,
                        animationDuration: 500,
                        curve: Curves.easeInOut,
                        barRadius: const Radius.circular(15),
                        // width: MediaQuery.of(context).size.width,
                        lineHeight: 5,
                        percent:  HomeCubit.get(context).calculateTotalFats() / HomeCubit.get(context).userModel!.totalFats! ,
                        backgroundColor: Colors.grey,
                        progressColor: Colors.blue,
                      ),
                    if(HomeCubit.get(context).calculateTotalFats() / HomeCubit.get(context).userModel!.totalFats! >1)
                      LinearPercentIndicator(
                        animation: true,
                        animationDuration: 500,
                        curve: Curves.easeInOut,
                        barRadius: const Radius.circular(15),
                        // width: MediaQuery.of(context).size.width,
                        lineHeight: 5,
                        percent: 1,
                        backgroundColor: Colors.grey,
                        progressColor: Colors.blue,
                      ),
                    SizedBox(
                      height: 5,
                    ),
                    defaultBodyText(context, text: '${HomeCubit.get(context).calculateTotalFats()} / ${HomeCubit.get(context).userModel!.totalFats!}${AppLocalizations.of(context).translate("g")}'),

                  ],
                ),
              ),
            ),

          ],
        ),
      ],
    ),
  ),
);




Widget buildNutritionItem(BuildContext context) => Column(
  children: [
    Row(
      children:
      [
        CircleAvatar(
          radius: 30,
          backgroundColor: AppCubit.get(context).constantColor5,
          child: defaultBodyText(context, text: '${HomeCubit.get(context).userModel!.totalCarbs!}g',color: defaultColor),
        ),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:
            [
              Padding(
                padding: const EdgeInsetsDirectional.only(start: 5),
                child: defaultHeadLineText(context, text: AppLocalizations.of(context).translate("Carbs")),
              ),
              SizedBox(
                height: 8,
              ),
              if( HomeCubit.get(context).calculateTotalCarbs() / HomeCubit.get(context).userModel!.totalCarbs! >= 0 && HomeCubit.get(context).calculateTotalCarbs()/ HomeCubit.get(context).userModel!.totalCarbs! <= 1)
                LinearPercentIndicator(
                  animation: true,
                  animationDuration: 500,
                  curve: Curves.easeInOut,
                  barRadius: const Radius.circular(15),
                  //width: MediaQuery.of(context).size.width,
                  lineHeight: 8,
                  percent: HomeCubit.get(context).calculateTotalCarbs()/ HomeCubit.get(context).userModel!.totalCarbs! ,
                  backgroundColor: Colors.grey,
                  progressColor: Colors.blue,
                ),
              if( HomeCubit.get(context).calculateTotalCarbs() / HomeCubit.get(context).userModel!.totalCarbs! > 1)
                LinearPercentIndicator(
                  animation: true,
                  animationDuration: 500,
                  curve: Curves.easeInOut,
                  barRadius: const Radius.circular(15),
                  //width: MediaQuery.of(context).size.width,
                  lineHeight: 8,
                  percent: 1,
                  backgroundColor: Colors.grey,
                  progressColor: Colors.blue,
                ),
            ],
          ),
        ),
        defaultBodyText(context, text: '${((HomeCubit.get(context).calculateTotalCarbs()/ HomeCubit.get(context).userModel!.totalCarbs!) * 100).toStringAsFixed(1)}%'),
      ],
    ),
    SizedBox(
      height: 15,
    ),
    Row(
      children:
      [
        CircleAvatar(
          radius: 30,
          backgroundColor: AppCubit.get(context).constantColor5,
          child: defaultBodyText(context, text: '${HomeCubit.get(context).userModel!.totalProtein!}g',color: defaultColor),

        ),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:
            [
              Padding(
                padding: const EdgeInsetsDirectional.only(start: 5),
                child: defaultHeadLineText(context, text: AppLocalizations.of(context).translate("Protein")),
              ),
              SizedBox(
                height: 8,
              ),
              if( HomeCubit.get(context).calculateTotalProtein()/ HomeCubit.get(context).userModel!.totalProtein! >= 0 && HomeCubit.get(context).calculateTotalProtein() / HomeCubit.get(context).userModel!.totalProtein! <= 1)
                LinearPercentIndicator(
                  animation: true,
                  animationDuration: 500,
                  curve: Curves.easeInOut,
                  barRadius: const Radius.circular(15),
                  //width: MediaQuery.of(context).size.width,
                  lineHeight: 8,
                  percent: HomeCubit.get(context).calculateTotalProtein()/ HomeCubit.get(context).userModel!.totalProtein! ,
                  backgroundColor: Colors.grey,
                  progressColor: Colors.blue,
                ),
              if((HomeCubit.get(context).userModel!.totalProtein! - HomeCubit.get(context).calculateTotalProtein()) / HomeCubit.get(context).userModel!.totalProtein! < 0)
                LinearPercentIndicator(
                  animation: true,
                  animationDuration: 500,
                  curve: Curves.easeInOut,
                  barRadius: const Radius.circular(15),
                  //width: MediaQuery.of(context).size.width,
                  lineHeight: 8,
                  percent: 1,
                  backgroundColor: Colors.grey,
                  progressColor: Colors.blue,
                ),
            ],
          ),
        ),
        defaultBodyText(context, text: '${((HomeCubit.get(context).calculateTotalProtein() / HomeCubit.get(context).userModel!.totalProtein!) * 100).toStringAsFixed(1)}%'),
      ],
    ),
    SizedBox(
      height: 15,
    ),
    Row(
      children:
      [
        CircleAvatar(
          radius: 30,
          backgroundColor: AppCubit.get(context).constantColor5,
          child: defaultBodyText(context, text: '${HomeCubit.get(context).userModel!.totalFats}g',color: defaultColor),

        ),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:
            [
              Padding(
                padding: const EdgeInsetsDirectional.only(start: 5),
                child: defaultHeadLineText(context, text: AppLocalizations.of(context).translate("Fats")),
              ),
              SizedBox(
                height: 8,
              ),
              if( HomeCubit.get(context).calculateTotalFats() / HomeCubit.get(context).userModel!.totalFats!>= 0 && HomeCubit.get(context).calculateTotalFats() / HomeCubit.get(context).userModel!.totalFats! <= 1 )
                LinearPercentIndicator(
                  animation: true,
                  animationDuration: 500,
                  curve: Curves.easeInOut,
                  barRadius: const Radius.circular(15),
                  //width: MediaQuery.of(context).size.width,
                  lineHeight: 8,
                  percent:  HomeCubit.get(context).calculateTotalFats() / HomeCubit.get(context).userModel!.totalFats! ,
                  backgroundColor: Colors.grey,
                  progressColor: Colors.blue,
                ),
              if(HomeCubit.get(context).calculateTotalFats() / HomeCubit.get(context).userModel!.totalFats! >1)
                LinearPercentIndicator(
                  animation: true,
                  animationDuration: 500,
                  curve: Curves.easeInOut,
                  barRadius: const Radius.circular(15),
                  //width: MediaQuery.of(context).size.width,
                  lineHeight: 8,
                  percent: 1,
                  backgroundColor: Colors.grey,
                  progressColor: Colors.blue,
                ),
            ],
          ),
        ),
        defaultBodyText(context, text: '${((HomeCubit.get(context).calculateTotalFats() / HomeCubit.get(context).userModel!.totalFats!) * 100).toStringAsFixed(1)}%'),
      ],
    ),
  ],
);

Widget buildmarket_item(ProductModel model,context, index) => defaultGestureDetector(
  onTap: ()
  {
    navigateTo(context, MarketItemScreen(
      productModel: model,
      index: index,
    ));
  },
  child:
  Container(
    decoration: BoxDecoration (
      color: constantColor5,
      borderRadius: BorderRadius.circular(15.0),
    ),
    //color: constantColor5,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
      [
        Stack(
          children: [

            Padding(
              padding: const EdgeInsetsDirectional.only(
                top: 20
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      SimpleShadow(
                        child: Image(
                          alignment: Alignment.center,
                          image: NetworkImage('${model.image}'),
                          width: 140.0,
                          height: 140.0,
                          fit: BoxFit.cover,
                        ),
                        opacity: 0.5,
                        //color: Colors.blue,
                        offset: Offset(1, 1),
                        sigma: 8,
                      ),
                      if (model.discount != 0 && model.quantity != 0)
                        Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(25)
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 5.0
                            ),
                            child: Text(
                              '${model.discount}% OFF',
                              style: const TextStyle(
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.w900
                              ),
                            )
                        ),
                      if (model.quantity == 0)
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25)
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5.0
                          ),
                          child:Text(
                            'Not available',
                            style: TextStyle(
                                fontSize: 10.0,
                                color: Colors.red[800]
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            )

          ],
        ),

        Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 10.0,
            ),
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 5.0,
                    horizontal: 10.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${model.name}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14,
                          height: 1.3,
                        ),
                      ),
                      Row(
                        children:
                        [
                          Text(
                            '${model.currentPrice}',
                            style: const TextStyle(
                              fontSize: 13.0,
                              fontWeight: FontWeight.w900,
                              color: defaultColor,
                            ),
                          ),
                          const SizedBox(
                            width: 5.0,
                          ),
                          if (model.discount != 0)
                            Text(
                              '${model.oldPrice}',
                              style: const TextStyle(
                                fontSize: 10.0,
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                        ],
                      ),

                    ],
                  ),
                )
            )
        ),
      ],
    ),
  ),
);


Widget buildMealItem(MealsModel model,context,{
  required bool? value,
  required void Function(bool?)? onChanged,

}) => defaultContainer(
  context,
  //color: constantColor1,
  child:   InkWell(

    onTap: ()

    {

      showDialog(
        context: context,
        builder: (context) => MealItemScreen(mealsModel: model),
        barrierDismissible: true,
      );

    },

    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(

        children:

        [

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children:

              [
                if(lan=='en')
                  defaultBodyText(
                  context,
                  text: '${model.Food}',
                  maxLines: 1,
                ),
                if(lan=='ar')
                  defaultBodyText(
                  context,
                  text: '${model.foodAr}',
                  maxLines: 1,
                ),

                Row(

                  children:

                  [

                    if(lan=='en')
                      Text(

                        '${model.Measure},',

                      style: Theme.of(context).textTheme.caption,

                    ),
                    if(lan=='ar')
                      Text(

                      '${model.measureAr},',

                      style: Theme.of(context).textTheme.caption,

                    ),

                    SizedBox(
                      width: 2,
                    ),

                    Text(

                      '${model.Calories}Kcal',

                      style: Theme.of(context).textTheme.caption,

                    ),



                  ],

                ),



              ],

            ),
          ),

          Checkbox(
              value: value ,
              onChanged: onChanged
          ),

        ],

      ),
    ),

  ),
);
Widget buildSerachMealItem (list,listOfEmptySearch,context,
{
  required List<bool> isChecked,
  required void Function()? function,
  required  void Function(dynamic, dynamic) changeChekBox,
  //required bool? value,
  //required void Function(bool?)? onChanged,
  required String title,
  required  void Function(String)? onChangedSearch
}) =>  BlocConsumer<HomeCubit,HomeStates>(
  listener: (context,state)
  {

  },
  builder: (context,state)
  {

    //var list = HomeCubit.get(context).searchMeal;
    return  Scaffold(
      appBar: buildAppBar(
          title: title,
          icon: IconBroken.Arrow___Left_2,
          onPressed: () {
            Navigator.pop(context);
          },
          actions:[
            IconButton(
              icon: const Icon(Icons.camera),
              onPressed: ()
              {
                navigateTo(
                    context,
                    CameraScreen());
              },
            ),
            if(state is ChangeCheckBoxState)
              SizedBox(
                width: 5,
              ),
            if(state is ChangeCheckBoxState && isChecked.any((element) => element == true) )
              defaultTextButton(context,
                function: function,
                text:AppLocalizations.of(context).translate("Add"),
                // 'Add',
              ),

          ]

      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children:
          [
            defaultContainer(
              context,
              //color: constantColor5,
              child: defaultTextFormField(
                type: TextInputType.text,
                prefix: Icons.search,
                hintText: AppLocalizations.of(context).translate("  "),//'Search',
                border: InputBorder.none,
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
                onChanged: onChangedSearch,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: ConditionalBuilder(
                condition:  list.length > 0,
                builder: (context) => ListView.separated(
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context,index) => buildMealItem(
                      list[index],
                      context,
                      value: isChecked[index],
                      onChanged: (value)
                      {
                        
                        changeChekBox(value, index);
                      },

                    ),
                    separatorBuilder: (context,index) =>  SizedBox(height: 5,),
                    itemCount: list.length
                ),
                fallback: (context) => ListView.separated(
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context,index) => buildMealItem(
                      listOfEmptySearch[index],
                      context,
                      value: isChecked[index],
                      onChanged: (value)
                      {
                        changeChekBox(value, index);
                      },
                    ),
                    separatorBuilder: (context,index) =>  SizedBox(height: 5,),
                    itemCount: listOfEmptySearch.length
                ),
              ),
            ),

          ],
        ),
      ),
    );
  },
);

Widget defaultRawButton ({
  required Function()? onPressed,
  required IconData icon,
  double? iconSize = 16.0,
  Color color = defaultColor,
  double width = 30.0,
  double height = 30.0,

}) => RawMaterialButton(
  shape:const CircleBorder(),
  elevation: 1.0,
  fillColor: color,
  child: Icon(
    icon,
    color: Colors.white,
    size: iconSize,
  ),
  onPressed: onPressed,
  constraints: BoxConstraints.tightFor(
    width: width,
    height: height,
  ),
);

Widget  BuildUserItem (UserModel model,context)=> Padding(
  padding: const EdgeInsets.all(20.0),
  child: Dismissible(
    key: Key(model.uId!),
    onDismissed: (direction)
    {
      AdminCubit.get(context).deleteUser(model.uId);

    },
    background: Container(
      alignment: Alignment.centerLeft,
      child:Padding(
        padding: const EdgeInsets.all(8.0),
        child: defaultHeadLineText(context, text: 'Delete Abuser',color: Colors.white),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration:BoxDecoration(
        color: defaultColor,//HexColor('#4d4d4d')
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    child: Row(
      children:
      [
        CircleAvatar(
          radius: 40.0,
          backgroundImage: NetworkImage(
              '${model.profileImage}'
          ),
        ),
        SizedBox(
          width: 20,),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children:
            [
              Text(
                '${model.name}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                '${model.email}',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        IconButton(
            icon: Icon(
                Icons.delete_forever
            ),
            onPressed: () {
              AdminCubit.get(context).deleteUser(model.uId);
            }
        ),
      ],
    ),
  ),
);




indicator({
  required Color color,
  required String text,
  String? secondText,
  required bool isSquare,
  double? size = 16,
  Color? secondTextColor,
  Color? textColor = const Color(0xff505050),
}) => Row(
    children: [
      Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
          color: color,
        ),
      ),
      const SizedBox(
        width: 4,
      ),
      Expanded(
        child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: textColor,
            ),
          ),
      ),

      const Spacer(),

      Text(
        secondText!,
        style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: secondTextColor
        ),
      ),

    ],
);

buildPieChartItem (ProductModel model, context, radius, fontSize, index, totalAmount) =>
    PieChartSectionData(
      color: colors[index],
      value: model.quantity!/totalAmount*100*360,
      title: ((model.quantity!/totalAmount*100).round()).toString()+'%',
      radius: radius,
      titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Colors.white
      ),
    );


List<Color> colors = [
  Color(0xff0293ee),
  Color(0xfff8b250),
  Color(0xff845bef),
  Color(0xffef5bed),
  Color(0xff097eac),
  Color(0xe8a7a7ad),
  Color(0xff082ca7),
  Color(0xff27ce21),
  Color(0xffe8e224),
  Color(0xff8e09ac),

];

Widget drawerHeader(UserModel model) => DrawerHeader(
    decoration: BoxDecoration(
      color: defaultColor,

    ),
    child: Container(
      child: Column(
        children: [
          Expanded(
            child: Container(
              //borderRadius: BorderRadius.all(Radius.circular(50.0)),

              width: 87.0,
              //height: 87.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,

              ),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: CircleAvatar(
                  //radius: 25.0,
                  backgroundImage: NetworkImage('${model.profileImage}'),
                )
              ),
            ),
          ),
          Text(
            '${model.name}',
            style: TextStyle(
                color: Colors.white,
                fontSize: 15.0,
                fontWeight: FontWeight.bold),
          ),
          Text(
            '${model.email}',
            style: TextStyle(
                color: Colors.white70,
                fontSize: 12.0
            ),
          ),
        ],
      ),
    ),
  );

Widget buildMenuItem(context,{
  required String text,
  required IconData icon,
  required Function()? onClicked,
  //Color backgroundColor = Colors.white,
  Color color = Colors.black54
}) => InkWell(
  onTap:onClicked ,
  child:   Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: defaultContainer (
        context,
        //color: Colors.grey[50],
        child: ListTile(
          leading: Icon(
              icon,
              color: color),
          title: Text(
            text,
            style: TextStyle(
                fontSize: 14
            ),
          ),

        ),
      )
  ),
);

//build Order Screens for admin

Widget buildOrderScreens(list) => ConditionalBuilder(
    condition: list.isNotEmpty  ,
    builder: (context) => SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding:  const EdgeInsets.symmetric(
            horizontal: 16
        ),
        child: ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) => BuildOrderItem(list[index],context,index),
          separatorBuilder: (context, index) => myDivider(),
          itemCount: list.length,
        ),
      ),
    ),
    fallback: (context) => const Center(child: CircularProgressIndicator())
);





Widget  BuildOrderItem (NewOrderModel model,context,index)=> Padding(
  padding: const EdgeInsetsDirectional.only(
      top: 10,
      bottom: 10
  ),
  child: InkWell(
    onTap: ()
    {
      if(model.cardItemList != null && model.orderId != null )
      {
        navigateTo(context, ProductsForOrder(products: model.cardItemList!, orderNumber: model.orderNumber!,));
      }
      else
      {
        showToast(text: 'this customer buy one product ', state: ToastStates.WARNING);
      }
    },
    child: Dismissible(
      key:Key(model.dateTime!),
      onDismissed: (direction)
      {
        if(direction == DismissDirection.endToStart)
        {
          AdminCubit.get(context).updateStatusOfOrdres(
            model.orderId!,
            status: 'canceled',
            userName:model.userName ,
            userEmail: model.userEmail,
            totalPrice: model.totalPrice,
            total:model.total ,
            shipping:model.shipping ,
            phone: model.phone,
            orderId: model.orderId,
            cardItemList: model.cardItemList,
            address: model.address,
            dateTime:model.dateTime,
            productName: model.productName,
            quantity: model.quantity,
            orderNumber: model.orderNumber
          );
         /* if(model.status == 'new')
          {
            AdminCubit.get(context).updateStatusOfOrdres(
              AdminCubit.get(context).ordersNewId[index],
              status: 'canceled',
              userName:model.userName ,
              userEmail: model.userEmail,
              totalPrice: model.totalPrice,
              total:model.total ,
              shipping:model.shipping ,
              phone: model.phone,
              orderId: model.orderId,
              cardItemList: emptyCart,
              address: model.address,
              dateTime:model.dateTime,
              productName: model.productName,
              quantity: model.quantity,
            );
          }
          else if(model.status == 'confirmed')
          {
            AdminCubit.get(context).updateStatusOfOrdres(
              AdminCubit.get(context).ordersConfirmedId[index],
              status: 'canceled',
              userName:model.userName ,
              userEmail: model.userEmail,

              totalPrice: model.totalPrice,
              total:model.total ,
              shipping:model.shipping ,
              phone: model.phone,
              orderId: model.orderId,
              cardItemList: emptyCart,
              address: model.address,
              dateTime:model.dateTime,
              productName: model.productName,
              quantity: model.quantity,
            );
          }
          else if(model.status == 'canceled')
          {
            AdminCubit.get(context).updateStatusOfOrdres(
              AdminCubit.get(context).ordersCanceledId[index],
              status: 'canceled',
              userName:model.userName ,
              userEmail: model.userEmail,
              totalPrice: model.totalPrice,
              total:model.total ,
              shipping:model.shipping ,
              phone: model.phone,
              orderId: model.orderId,
              cardItemList: emptyCart,
              address: model.address,
              dateTime:model.dateTime,
              productName: model.productName,
              quantity: model.quantity,
            );
          }*/
        }
        if(direction == DismissDirection.startToEnd)
        {
          AdminCubit.get(context).updateStatusOfOrdres(
            model.orderId!,
            status: 'confirmed',
            userName:model.userName ,
            userEmail: model.userEmail,
            totalPrice: model.totalPrice,
            total:model.total ,
            shipping:model.shipping ,
            phone: model.phone,
            orderId: model.orderId,
            cardItemList: model.cardItemList,
            address: model.address,
            dateTime:model.dateTime,
            productName: model.productName,
            quantity: model.quantity,
              orderNumber: model.orderNumber

          );
         /* if(model.status == 'new')
          {
            AdminCubit.get(context).updateStatusOfOrdres(
              AdminCubit.get(context).ordersNewId[index],
              status: 'confirmed',
              userName:model.userName ,
              userEmail: model.userEmail,
              totalPrice: model.totalPrice,
              total:model.total ,
              shipping:model.shipping ,
              phone: model.phone,
              orderId: model.orderId,
              cardItemList: emptyCart,
              address: model.address,
              dateTime:model.dateTime,
              productName: model.productName,
              quantity: model.quantity,
            );
          }
          else if(model.status == 'confirmed')
          {
            AdminCubit.get(context).updateStatusOfOrdres(
              AdminCubit.get(context).ordersConfirmedId[index],
              status: 'confirmed',
              userName:model.userName ,
              userEmail: model.userEmail,
              totalPrice: model.totalPrice,
              total:model.total ,
              shipping:model.shipping ,
              phone: model.phone,
              orderId: model.orderId,
              cardItemList: emptyCart,
              address: model.address,
              dateTime:model.dateTime,
              productName: model.productName,
              quantity: model.quantity,
            );
          }
          else if(model.status == 'canceled')
          {
            AdminCubit.get(context).updateStatusOfOrdres(
              AdminCubit.get(context).ordersCanceledId[index],
              status: 'confirmed',
              userName:model.userName ,
              userEmail: model.userEmail,
              totalPrice: model.totalPrice,
              total:model.total ,
              shipping:model.shipping ,
              phone: model.phone,
              orderId: model.orderId,
              cardItemList: emptyCart,
              address: model.address,
              dateTime:model.dateTime,
              productName: model.productName,
              quantity: model.quantity,
            );
          }*/
        }
      },
      background: Container(
        alignment: Alignment.centerLeft,
        child:Padding(
          padding: const EdgeInsets.all(8.0),
          child: defaultHeadLineText(context, text: 'Confirmed Order',color: Colors.white),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration:BoxDecoration(
          color: defaultColor,//HexColor('#4d4d4d')
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      secondaryBackground: Container(
        alignment: Alignment.centerRight,
        child:Padding(
          padding: const EdgeInsets.all(8.0),
          child: defaultHeadLineText(context, text: 'Canceled Order',color: Colors.white),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration:BoxDecoration(
          color: Colors.red,//HexColor('#4d4d4d')
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Column(
        children:
        [
          defaultContainer(
            context,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children:
                [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                      [
                        defaultBodyText(context, text: 'User name is ${model.userName}'),
                        SizedBox(
                          height: 5,
                        ),
                        defaultBodyText(context, text: 'User name is ${model.userEmail}'),
                        SizedBox(
                          height: 5,
                        ),
                        defaultBodyText(context, text: 'Address is ${model.address}'),
                        SizedBox(
                          height: 5,
                        ),
                        defaultBodyText(context, text: 'Phone is ${model.phone}'),
                        SizedBox(
                          height: 5,
                        ),
                        defaultBodyText(context, text: 'Order is ${model.orderNumber}'),
                        SizedBox(
                          height: 5,
                        ),
                        defaultBodyText(context, text: 'Data is ${convertToDataTime(model.dateTime!)} '),
                        if(model.productName != null)
                          SizedBox(
                            height: 5,
                          ),
                        if(model.productName != null)
                          defaultBodyText(context, text: 'productName : ${model.productName}'),

                        if(model.quantity != null)
                          defaultBodyText(context, text: 'quantity is ${model.quantity}'),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      defaultTextButton(
                          context,
                          function: ()
                          {
                            AdminCubit.get(context).updateStatusOfOrdres(
                              model.orderId!,
                              status: 'confirmed',
                              userName:model.userName ,
                              userEmail: model.userEmail,
                              totalPrice: model.totalPrice,
                              total:model.total ,
                              shipping:model.shipping ,
                              phone: model.phone,
                              orderId: model.orderId,
                              cardItemList: model.cardItemList,
                              address: model.address,
                              dateTime:model.dateTime,
                              productName: model.productName,
                              quantity: model.quantity,
                                orderNumber: model.orderNumber

                            );
                           /* if(model.status == 'new')
                            {
                              AdminCubit.get(context).updateStatusOfOrdres(
                                AdminCubit.get(context).ordersNewId[index],
                                status: 'confirmed',
                                userName:model.userName ,
                                userEmail: model.userEmail,
                                totalPrice: model.totalPrice,
                                total:model.total ,
                                shipping:model.shipping ,
                                phone: model.phone,
                                orderId: model.orderId,
                                cardItemList:emptyCart,
                                address: model.address,
                                dateTime:model.dateTime,
                                productName: model.productName,
                                quantity: model.quantity,
                              );
                            }
                            else if(model.status == 'confirmed')
                            {
                              AdminCubit.get(context).updateStatusOfOrdres(
                                AdminCubit.get(context).ordersConfirmedId[index],
                                status: 'confirmed',
                                userName:model.userName ,
                                userEmail: model.userEmail,
                                totalPrice: model.totalPrice,
                                total:model.total ,
                                shipping:model.shipping ,
                                phone: model.phone,
                                orderId: model.orderId,
                                cardItemList: emptyCart,
                                address: model.address,
                                dateTime:model.dateTime,
                                productName: model.productName,
                                quantity: model.quantity,
                              );
                            }
                            else if(model.status == 'canceled')
                            {
                              AdminCubit.get(context).updateStatusOfOrdres(
                                AdminCubit.get(context).ordersCanceledId[index],
                                status: 'confirmed',
                                userName:model.userName ,
                                userEmail: model.userEmail,
                                totalPrice: model.totalPrice,
                                total:model.total ,
                                shipping:model.shipping ,
                                phone: model.phone,
                                orderId: model.orderId,
                                cardItemList: emptyCart,
                                address: model.address,
                                dateTime:model.dateTime,
                                productName: model.productName,
                                quantity: model.quantity,
                              );
                            }*/

                            //print(index);
                            /* if(model.cardItemList != null) {
                             AdminCubit.get(context).updateStatusOfOrdres(
                                AdminCubit.get(context).ordersId[index],
                                status: 'confirmed',
                                userName:model.userName ,
                                totalPrice: model.totalPrice,
                                total:model.total ,
                                shipping:model.shipping ,
                                phone: model.phone,
                                orderId: model.orderId,
                                cardItemList: HomeCubit.get(context).cart ,
                                address: model.address,
                                dateTime:model.dateTime,
                                productName: model.productName,
                                quantity: model.quantity,
                              );
                            }

                            }
                            else
                              {
                                AdminCubit.get(context).updateStatusOfOrdres(
                                  AdminCubit.get(context).ordersId[index],
                                  status: 'confirmed',
                                  userName:model.userName ,
                                  totalPrice: model.totalPrice,
                                  total:model.total ,
                                  shipping:model.shipping ,
                                  phone: model.phone,
                                  orderId: model.orderId,
                                  cardItemList: emptyCart ,
                                  address: model.address,
                                  dateTime:model.dateTime,
                                  productName: model.productName,
                                  quantity: model.quantity,
                                );
                              }*/

                          },
                          text: 'Confirmed',
                      ),
                      defaultTextButton(
                        context,
                        function: () {

                          AdminCubit.get(context).updateStatusOfOrdres(
                            model.orderId!,
                            status: 'canceled',
                            userName:model.userName ,
                            userEmail: model.userEmail,
                            totalPrice: model.totalPrice,
                            total:model.total ,
                            shipping:model.shipping ,
                            phone: model.phone,
                            orderId: model.orderId,
                            cardItemList: model.cardItemList,
                            address: model.address,
                            dateTime:model.dateTime,
                            productName: model.productName,
                            quantity: model.quantity,
                              orderNumber: model.orderNumber

                          );
                      /*    print(index);
                          if(model.status == 'new')
                          {
                            AdminCubit.get(context).updateStatusOfOrdres(
                              AdminCubit.get(context).ordersNewId[index],
                              status: 'canceled',
                              userName:model.userName ,
                              userEmail: model.userEmail,
                              totalPrice: model.totalPrice,
                              total:model.total ,
                              shipping:model.shipping ,
                              phone: model.phone,
                              orderId: model.orderId,
                              cardItemList: emptyCart,
                              address: model.address,
                              dateTime:model.dateTime,
                              productName: model.productName,
                              quantity: model.quantity,
                            );
                          }
                          else if(model.status == 'confirmed')
                          {
                            AdminCubit.get(context).updateStatusOfOrdres(
                              AdminCubit.get(context).ordersConfirmedId[index],
                              status: 'canceled',
                              userName:model.userName ,
                              userEmail: model.userEmail,
                              totalPrice: model.totalPrice,
                              total:model.total ,
                              shipping:model.shipping ,
                              phone: model.phone,
                              orderId: model.orderId,
                              cardItemList: emptyCart,
                              address: model.address,
                              dateTime:model.dateTime,
                              productName: model.productName,
                              quantity: model.quantity,
                            );
                          }
                          else if(model.status == 'canceled')
                          {
                            AdminCubit.get(context).updateStatusOfOrdres(
                              AdminCubit.get(context).ordersCanceledId[index],
                              status: 'canceled',
                              userName:model.userName ,
                              userEmail: model.userEmail,
                              totalPrice: model.totalPrice,
                              total:model.total ,
                              shipping:model.shipping ,
                              phone: model.phone,
                              orderId: model.orderId,
                              cardItemList: emptyCart,
                              address: model.address,
                              dateTime:model.dateTime,
                              productName: model.productName,
                              quantity: model.quantity,
                            );
                          }*/





                         /*if(model.cardItemList != null)
                          {
                            AdminCubit.get(context).updateStatusOfOrdres(
                              AdminCubit.get(context).ordersId[index],
                              status: 'canceled',
                              userName:model.userName ,
                              totalPrice: model.totalPrice,
                              total:model.total ,
                              shipping:model.shipping ,
                              phone: model.phone,
                              orderId: model.orderId,
                              cardItemList:HomeCubit.get(context).cart ,
                              address: model.address,
                              dateTime:model.dateTime,
                              productName: model.productName,
                              quantity: model.quantity,
                            );
                          }
                          else
                          {
                            AdminCubit.get(context).updateStatusOfOrdres(
                              AdminCubit.get(context).ordersId[index],
                              status: 'canceled',
                              userName:model.userName ,
                              totalPrice: model.totalPrice,
                              total:model.total ,
                              shipping:model.shipping ,
                              phone: model.phone,
                              orderId: model.orderId,
                              cardItemList: emptyCart ,
                              address: model.address,
                              dateTime:model.dateTime,
                              productName: model.productName,
                              quantity: model.quantity,
                            );
                          }*/
                        },
                        text: 'Canceled',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          /* ListView.separated(
              shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context,index) =>Card(
                  child: Column(
                    children: [
                      Image(
                        image: NetworkImage('${model.cardItemList![0]['image']}'),
                        width: double.infinity,
                        height: 200.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            defaultBodyText(context, text: '${model.cardItemList![0]['name']}'),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                defaultBodyText(context, text: ' currentPrice:${model.cardItemList![0]['currentPrice']}'),
                                Spacer(),
                                defaultBodyText(context, text: 'quantity:${model.cardItemList![0]['quantity']}'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                separatorBuilder: (context,index) =>  SizedBox(width: 5,),
                itemCount:model.cardItemList!.length,
            ),*/
        ],
      ),
    ),
  ),
);

//build Order Screens for user
DateTime current = DateTime.now();

Stream timer = Stream.periodic( Duration(seconds: 1), (i){
  current = current.add(Duration(seconds: 1));
  return current;
});
Widget buildOrderScreensUser(list) => ConditionalBuilder(
    condition: list.isNotEmpty  ,
    builder: (context) => SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding:  const EdgeInsets.symmetric(
            horizontal: 16
        ),
        child: ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) => buildOrderItemUser(list[index],context,index),
          separatorBuilder: (context, index) => myDivider(),
          itemCount: list.length,
        ),
      ),
    ),
    fallback: (context) => const Center(child: CircularProgressIndicator())
);
Widget  buildOrderItemUser (NewOrderModel model,context,index)=> Padding(
  padding: const EdgeInsetsDirectional.only(
      top: 10,
      bottom: 10
  ),
  child: InkWell(
    onTap: ()
    {
      if(model.cardItemList != null && model.orderId != null )
      {
        navigateTo(context, ProductsForOrderUser(products: model.cardItemList!, orderNumber: model.orderNumber!,));
      }
      else
      {
        showToast(text:  AppLocalizations.of(context).translate("You buy one Product"), state: ToastStates.WARNING);
      }
    },
    child: Column(
      children:
      [
        defaultContainer(
          context,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children:
              [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:
                    [
                      defaultBodyText(context, text: '${AppLocalizations.of(context).translate("User name is")} ${model.userName}'),
                      SizedBox(
                        height: 5,
                      ),
                      defaultBodyText(context, text: '${AppLocalizations.of(context).translate("address")}:${model.address}'),
                      SizedBox(
                        height: 5,
                      ),
                      defaultBodyText(context, text: '${AppLocalizations.of(context).translate("phone")}:${model.phone}'),
                      SizedBox(
                        height: 5,
                      ),
                      defaultBodyText(context, text: '${AppLocalizations.of(context).translate("Order Number")}: ${model.orderNumber}'),
                      SizedBox(
                        height: 5,
                      ),
                      if(model.status == 'new')
                        defaultBodyText(context, text: AppLocalizations.of(context).translate("Be patient Your order is under review")),
                      if(model.status == 'new')
                        SizedBox(
                        height: 5,
                      ),
                      if(model.status == 'confirmed')
                        defaultBodyText(context, text: AppLocalizations.of(context).translate("Your order will arrive soon in two or three days")),
                      if(model.status == 'confirmed')
                        SizedBox(
                        height: 5,
                      ),
                      if(model.status == 'canceled')
                        defaultBodyText(context, text: AppLocalizations.of(context).translate("We are sorry your order canceled")),
                      if(model.status == 'confirmed')
                        SizedBox(
                          height: 5,
                        ),
                      defaultBodyText(context, text: '${AppLocalizations.of(context).translate("date")}:${convertToDataTime(model.dateTime!)} '),
                      if(model.productName != null)
                        SizedBox(
                          height: 5,
                        ),
                      if(model.productName != null && lan=='en')
                          defaultBodyText(context, text: '${AppLocalizations.of(context).translate("productName")}:${model.productName}'),
                      if(model.productName != null && lan=='ar')
                          defaultBodyText(context, text: '${AppLocalizations.of(context).translate("productName")}:${model.productNameAr}'),
                      if(model.quantity != null)
                        defaultBodyText(context, text: '${AppLocalizations.of(context).translate("quantity")}: ${model.quantity}'),

                    ],
                  ),
                ),

                if(model.status == 'new')
                  defaultTextButton(
                  context,
                  function: ()
                  {

                    HomeCubit.get(context).cancelOrder(model.orderId);
                  /*  timer.listen((data){
                      //2022-05-08 16:59:16.910646
                     if(data=='2022-05-08 17:02:00')
                     {
                       print('delete');

                     }
                     else{
                       print(data);
                     }
                      //if it reached the given time do something on your button
                    });*/
                  },
                  text: AppLocalizations.of(context).translate("Canceled"),
                ),
              ],
            ),
          ),
        ),

        /* ListView.separated(
            shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context,index) =>Card(
                child: Column(
                  children: [
                    Image(
                      image: NetworkImage('${model.cardItemList![0]['image']}'),
                      width: double.infinity,
                      height: 200.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          defaultBodyText(context, text: '${model.cardItemList![0]['name']}'),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              defaultBodyText(context, text: ' currentPrice:${model.cardItemList![0]['currentPrice']}'),
                              Spacer(),
                              defaultBodyText(context, text: 'quantity:${model.cardItemList![0]['quantity']}'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              separatorBuilder: (context,index) =>  SizedBox(width: 5,),
              itemCount:model.cardItemList!.length,
          ),*/
      ],
    ),
  ),
);


String convertToDataTime(String date) => DateFormat('dd-MM-yyyy HH:mm').format(DateTime.parse(date));



