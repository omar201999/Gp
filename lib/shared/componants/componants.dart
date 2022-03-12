import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gp/shared/styles/colors.dart';
import '../../modules/recipe/recipe_item_screen.dart';

AppBar buildAppBar({
  required String title,
  void Function()? onPressed,
  IconData? icon,
  Widget? leadingIcon = const Icon(Icons.menu),
}) =>  AppBar(
  leading: leadingIcon,
  title: Text(
    title,
  ),
  actions:
  [
    IconButton(
      onPressed: onPressed ,
      icon: Icon(icon),
    ),
  ],
);

Widget defaultTextFormField({

  TextEditingController? controller,
  required TextInputType type,
  void Function()? onTap,
  void Function(String)? onChanged,
  void Function(String)? onSupmitted,
  bool obScure = false,
  String? Function(String?)? validate,

  //////////////////////////////////////

  String? label ,
  IconData? prefix,
  IconData? suffix,
  void Function()? suffixPressed,
  String? hintText,
  InputBorder? border ,
}) => TextFormField(
  controller: controller,
  keyboardType: type,
  onTap: onTap,
  onChanged: onChanged,
  onFieldSubmitted: onSupmitted,
  obscureText: obScure,
  validator: validate,

  //decoration of textFormField

  decoration: InputDecoration(
    hintText: hintText,
    labelText : label,
    suffixIcon: IconButton(
      onPressed: suffixPressed,
      icon: Icon(suffix),
    ),
    prefixIcon: Icon(
      prefix,
    ),
    border: border,

  ),

);

Widget defaultButton(BuildContext context,{
  required void Function()? onPreesed,
  required String text ,
  double radius = 10 ,
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
      style: Theme.of(context).textTheme.headline1!.copyWith(
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
  double? width ,
  double? height,
  double radius = 10,
  Clip clip = Clip.antiAliasWithSaveLayer,
  Color? color = Colors.white,
  required Widget child ,
}) => Container(
  width: width,
  height: height,
  clipBehavior: clip,
  decoration: BoxDecoration(
    color: color,
    borderRadius: BorderRadius.circular(radius),
  ),
  child: child,
);

Widget defaultGesterDetecter({
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
  Color? color,

}) => Text(
  text,
  style: Theme.of(context).textTheme.bodyText1?.copyWith(
    fontWeight: fontWeight,
    color: color,
  ),
);

Widget buildRecipeItem(context) => defaultGesterDetecter(
  onTap: ()
  {
    navigateTo(context, RecipeItemScreen());
  },
  child: defaultContainer(
    height: 250,
    width: 150,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
      [
        Expanded(
          flex: 4,
          child: Image(
            image: AssetImage('images/Recipe1.jpg'),
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
                'Chargrilled Broccolini with Blanco Queso',
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
                  '220',
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

}) => defaultGesterDetecter(
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
          image: AssetImage('images/Recipe1.jpg'),
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
  required String? percentage,
  required String? numberOfGrams,
  required String? nameOfType,
  Color? color,
}) => Expanded(
  child: Column(
    children:
    [
      defaultBodyText(context, text: percentage! ,color: color),
      defaultBodyText(context, text: numberOfGrams! ),
      defaultBodyText(context, text: nameOfType! ),
    ],
  ),
);

Widget defaultTextButton({
  required void Function()? function,
  required String text,
}) =>
    TextButton(
      onPressed:function,
      child: Text(
        text.toUpperCase(),
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
enum ToastStates { SUCCESS, ERROR, WARNING }

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
  }

  return color;
}