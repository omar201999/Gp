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
import 'package:gp/models/product_model.dart';
import 'package:gp/models/recipes_model.dart';
import 'package:gp/models/user_model.dart';
import 'package:gp/modules/user/camera/Camera_Screen.dart';
import 'package:gp/modules/user/market/items/marketitem_screen.dart';
import 'package:gp/modules/user/meal_item/meal_item_screen.dart';
import 'package:gp/modules/user/recipe/recipe_item_screen.dart';
import 'package:gp/shared/styles/colors.dart';
import 'package:gp/shared/styles/icon_broken.dart';

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
    fillColor: constantColor5,
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

Widget defaultContainer({
  double? width,
  double? height,
  double radius = 10,
  Clip clip = Clip.antiAliasWithSaveLayer,
  Color? color = constantColor1,
  Widget? child,
  BoxDecoration? decoration ,
}) => Container(
  width: width,
  height: height,
  clipBehavior: clip,
  decoration: decoration??BoxDecoration(
    color: color,
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
}) => Text(
  text,
  style: Theme.of(context).textTheme.headline1?.copyWith(
    fontWeight: fontWeight,
    color: color,
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

}) => Text(
  text,
  style: Theme.of(context).textTheme.bodyText1?.copyWith(
    fontWeight: fontWeight,
    fontSize: fontSize,
    color: color,
  ),
  maxLines: maxLines,

);

Widget buildRecipeItem(RecipeModel model,context) => defaultGestureDetector(
  onTap: ()
  {
    navigateTo(context, RecipeItemScreen(
      recipeModel: model,
    ));
  },
  child: defaultContainer(
    height: 250,
    width: 180,
    color: constantColor5,
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
        Expanded(
          child: Padding(
            padding: const EdgeInsetsDirectional.only(
                start: 10
            ),
            child: Text(''
                '${model.title}',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
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
                Text(
                  '${model.calories}',
                  style: TextStyle(
                    letterSpacing: 1,
                  ),
                ),
                SizedBox(
                  width: 4,
                ),
                Text('cal'),
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

Widget buildSelectItem(BuildContext context, int index, {
  required bool? value,
  required void Function(bool?)? onChanged,


}) => defaultContainer(
  height: 250,
  child:   Column(

    children:
    [
      Expanded(
        flex: 2,
        child: Image(
          image: AssetImage('assets/images/Recipe1.jpg'),
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      ),
      Expanded(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: Row(
                  children:
                  [
                    defaultHeadLineText(context, text: 'Egg'),
                    Spacer(),
                    Checkbox(
                        value: value ,
                        onChanged: onChanged
                    ),

                  ],
                ),
              ),
              Expanded(
                child:  Row(
                  children:
                  [
                    defaultBodyText(context, text: '220 cal'),
                    Spacer(),
                    defaultBodyText(context, text: '220 cal'),
                  ],
                ),
              ),
              Expanded(
                child:  Row(
                  children:
                  [
                    defaultBodyText(context, text: '220 cal'),
                    Spacer(),
                    defaultBodyText(context, text: '220 cal'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

    ],
  ),
);

Widget afterTitleOfRecipeItem(BuildContext context, {
   String? percentage,
  required String? numberOfGrams,
  required String? nameOfType,
  Color? color,
}) => Expanded(
  child: Column(
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

Widget buildNutritionItem(BuildContext context,{
  required String title,
  required String calorieText,
  required String foodText,
  required String remainingText,

}) => defaultContainer(
  child: Padding(
    padding: const EdgeInsetsDirectional.all(10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
      [
        defaultHeadLineText(
          context,
          text: title,
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
                    calorieText,
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
                   foodText,
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
                    remainingText,
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
);

Widget buildmarket_item(ProductModel model,context) => defaultGestureDetector(
  onTap: ()
  {
    navigateTo(context, MarketitemScreen(
      productModel: model,
    ));
  },
  child: defaultContainer(
    color: constantColor5,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
      [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image: NetworkImage('${model.image}'),
              width: double.infinity,
              //height: 180.0,
              fit: BoxFit.cover,
            ),
            if (model.discount != 0)
              Container(
                  color: Colors.red,
                  padding: EdgeInsets.symmetric(
                      horizontal: 5.0
                  ),
                  child: Text(
                    'DISCOUNT',
                    style: TextStyle(
                      fontSize: 8.0,
                      color: Colors.white,
                    ),
                  )
              ),
          ],
        ),
        Padding(
          padding: /*EdgeInsetsDirectional.only(
                start: 10,
            ),*/
          const EdgeInsets.symmetric(
            vertical: 5.0,
            horizontal: 6.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${model.name}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 16,
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
                  const Spacer(),
                  if (model.quantity == 0)
                    const Text(
                      'Not available now',
                      style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.red
                      ),
                    )
                ],
              ),

            ],
          ),
        ),
      ],
    ),
  ),
);

Widget buildMealItem(MealsModel model,context,{
  required bool? value,
  required void Function(bool?)? onChanged,

}) => Container(
  color: constantColor1,
  child:   InkWell(

    onTap: ()

    {

      navigateTo(context, MealItemScreen(

        mealsModel: model,

      ));

    },

    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(

        children:

        [

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children:

            [

              defaultBodyText(
                context,
                text: '${model.Food}',
               /* maxLines: 1,
                overflow: TextOverflow.ellipsis,*/
              ),

              Row(

                children:

                [

                  Text(

                      '${model.Measure},',

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
          const Spacer(),
          Checkbox(
              value: value ,
              onChanged: onChanged
          ),

        ],

      ),
    ),

  ),
);
Widget buildSerachMealItem (list,context,
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
                    cameraScreen());
              },
            ),
            if(state is ChangeCheckBoxState)
              SizedBox(
                width: 5,
              ),
            if(state is ChangeCheckBoxState && isChecked.any((element) => element == true) )
              defaultTextButton(context,
                function: function,
                text: 'Add',
              ),

          ]

      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children:
          [
            defaultContainer(
              color: constantColor5,
              child: defaultTextFormField(
                type: TextInputType.text,
                prefix: Icons.search,
                hintText: 'Search',
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
                    itemCount: list.length),
                fallback: (context) => Center(child: Container()),
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
);


Widget  BuildOrderItem (UserModel userModel,ProductModel model,context,index)=> SingleChildScrollView(

  child: Padding(
    padding: const EdgeInsets.all(10.0),
    child: defaultContainer(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                    'UserName : '
                ),
                Text(
                    '${userModel.name}'
                ),
              ],
            ),

            SizedBox(
              height: 5.0,
            ),
            Row(
              children: [
                Text(
                    'ProductName : '
                ),
                Text(
                    '${model.name}'
                ),
              ],
            ),

            Row(
              children: [
                Text(
                    '${model.currentPrice! * HomeCubit.get(context).Counter[index]}'
                ),
                SizedBox(
                  width: 140,
                ),

              ],
            )


          ],
        ),
      ),
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
      defaultContainer(
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
      Text(
        text,
        style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: textColor
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
         defaultContainer(
            //borderRadius: BorderRadius.all(Radius.circular(50.0)),
            color: Colors.white,
            width: 87.0,
            height: 87.0,
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

Widget buildMenuItem({
  required String text,
  required IconData icon,
  required Function()? onClicked,
  //Color backgroundColor = Colors.white,
  Color color = Colors.black54
}) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
    child: defaultContainer (
      color: Colors.grey[50],
      child: ListTile(
        leading: Icon(
            icon,
            color: color),
        title: Text(
          text,
          style: TextStyle(
              color: color,
              fontSize: 14
          ),
        ),
        onTap: onClicked
      ),
    )
);

