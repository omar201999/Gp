import 'dart:io';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glass/glass.dart';
import 'package:gp/layout/home-layout/cubit/cubit.dart';
import 'package:gp/layout/home-layout/cubit/states.dart';
import 'package:gp/shared/componants/componants.dart';
import 'package:gp/shared/componants/constant.dart';
import 'package:gp/shared/localization/app_localization%20.dart';
import 'package:gp/shared/styles/icon_broken.dart';

class PhotoDetails extends StatelessWidget
{
   final File image;
   PhotoDetails({
     required this.image,
   });


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
      listener: (context,state){},
      builder: (context,state)
      {
        print(HomeCubit.get(context).searchPredictedMeal);
        var list=HomeCubit.get(context).searchPredictedMeal;
        return ConditionalBuilder(
          condition: HomeCubit.get(context).searchPredictedMeal.isNotEmpty,
         builder: (context) => Scaffold(
           appBar: AppBar(
             leading: Padding(
                 padding: EdgeInsetsDirectional.only(
                   start: 8.0,
                   top: 4.0
                 ),
               child: Container(
                 child:IconButton(
                   color: Colors.white,
                   onPressed: () {
                     Navigator.pop(context);
                   },
                   icon: const Icon( IconBroken.Arrow___Left_2 ),
                 ),
               ).asGlass(
                 tintColor: Colors.transparent,
                 clipBorderRadius: BorderRadius.circular(25.0),
               ),
             ),

             backgroundColor: Colors.transparent,
             elevation: 0.0,
           ),
           extendBodyBehindAppBar: true,
           body: Container(
             width: MediaQuery.of(context).size.width,
             height:  MediaQuery.of(context).size.height,
             decoration: BoxDecoration(
               image: DecorationImage(
                 image: FileImage(image),
                 fit: BoxFit.cover,
               ),
             ),
             child: SafeArea(
               child:  DraggableScrollableSheet(
                   minChildSize: 0.1,
                   maxChildSize: 0.5,
                   builder: (context, scrollController) => SingleChildScrollView(
                     controller: scrollController,
                     child: defaultContainer(
                         context,
                         height: 420,
                         decoration: const BoxDecoration(
                             color: Colors.white70,
                             borderRadius: BorderRadius.only(
                               topRight: Radius.circular(20.0),
                               topLeft: Radius.circular(20.0),
                             )
                         ),
                         child: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Padding(
                               padding: const EdgeInsetsDirectional.only(top: 16),
                               child: Row(
                                 mainAxisAlignment: MainAxisAlignment.center,
                                 children: [
                                   if(lan=='en')
                                     Padding(
                                       padding: const EdgeInsets.all(10.0),
                                       child: defaultHeadLineText(
                                           context,
                                           text: '${HomeCubit.get(context).searchPredictedMeal[0].Food}',
                                           fontSize: 30
                                       ),
                                     ),
                                   if(lan=='ar')
                                     Padding(
                                       padding: const EdgeInsets.all(10.0),
                                       child: defaultHeadLineText(
                                           context,
                                           text: '${HomeCubit.get(context).searchPredictedMeal[0].foodAr}',
                                           fontSize: 30
                                       ),
                                     ),
                                 ],
                               ),
                             ),
                             Row(
                               children:
                               [
                                 //'${widget.recipeModel.carbs}g' AppLocalizations.of(context).translate("Carbs")
                                 buildNutritionItemForRecipeItemScreen(
                                   context,
                                   imagePath:  'assets/images/cereal-grain-svgrepo-com.svg',
                                   numOFNutrition: '${HomeCubit.get(context).searchPredictedMeal[0].Carbs}${AppLocalizations.of(context).translate("g")}',
                                   typeOFNutrition: AppLocalizations.of(context).translate("Carbs2"),
                                 ),
                                 buildNutritionItemForRecipeItemScreen(
                                   context,
                                   imagePath:  'assets/images/avocado-svgrepo-com (1).svg',
                                   numOFNutrition: '${HomeCubit.get(context).searchPredictedMeal[0].Protein}${AppLocalizations.of(context).translate("g")}',
                                   typeOFNutrition: AppLocalizations.of(context).translate("Protein1"),
                                 ),
                                 buildNutritionItemForRecipeItemScreen(
                                   context,
                                   imagePath:  'assets/images/fire-svgrepo-com.svg',
                                   numOFNutrition: '${HomeCubit.get(context).searchPredictedMeal[0].Calories}${AppLocalizations.of(context).translate("g")}',
                                   typeOFNutrition: AppLocalizations.of(context).translate("cal1"),
                                 ),
                                 buildNutritionItemForRecipeItemScreen(
                                   context,
                                   imagePath: 'assets/images/pizza.svg',
                                   numOFNutrition: '${HomeCubit.get(context).searchPredictedMeal[0].Fat}${AppLocalizations.of(context).translate("g")}',
                                   typeOFNutrition: AppLocalizations.of(context).translate("Fats1"),
                                 ),
                               ],
                             ),
                             /*Padding(
                               padding: const EdgeInsets.symmetric(horizontal: 15),
                               child: Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                   defaultHeadLineText(
                                       context,
                                       text:'${AppLocalizations.of(context).translate("Protein1")} : ${HomeCubit.get(context).searchPredictedMeal[0].Protein}',
                                       fontWeight: FontWeight.bold
                                   ),
                                   SizedBox(
                                     height: 10,
                                   ),
                                   defaultHeadLineText(
                                       context,
                                       text:' ${AppLocalizations.of(context).translate("cal1")} : ${HomeCubit.get(context).searchPredictedMeal[0].Calories}',
                                       fontWeight: FontWeight.bold
                                   ),
                                   SizedBox(
                                     height: 10,
                                   ),
                                   defaultHeadLineText(
                                       context,
                                       text:' ${AppLocalizations.of(context).translate("Carbs2")} : ${HomeCubit.get(context).searchPredictedMeal[0].Carbs}',
                                       fontWeight: FontWeight.bold
                                   ),
                                   SizedBox(
                                     height: 10,
                                   ),
                                   defaultHeadLineText(
                                       context,
                                       text:' ${AppLocalizations.of(context).translate("Fats1")} : ${HomeCubit.get(context).searchPredictedMeal[0].Fat}',
                                       fontWeight: FontWeight.bold
                                   ),
                                 ],
                               ),
                             ),*/
                           ],
                         )
                     ),
                   )
               ),
             ),
           ),
           floatingActionButton: FloatingActionButton.extended(
             foregroundColor: Colors.white,
             onPressed: ()
             {
               if(HomeCubit.get(context).calculateTotalFoodCalories()! >= (HomeCubit.get(context).userModel!.totalCalorie)!.round() )
               {
                 //AppLocalizations.of(context).translate("  "),//
                 showToast(text: '${AppLocalizations.of(context).translate("validate_Food")} ${HomeCubit.get(context).userModel!.totalCalorie} ${AppLocalizations.of(context).translate("and your total food is")} ${HomeCubit.get(context).totalFood} ', state: ToastStates.WARNING);
               }
               else
               {
                 HomeCubit.get(context).addRecipeToMeals(
                   list[0].id.toString(),
                   title: list[0].Food,
                   calories: list[0].Calories!,
                   carbs: list[0].Carbs!,
                   fat: list[0].Fat!,
                   protein: list[0].Protein!,
                   foodAr:list[0].foodAr,
                   Grams: list[0].Grams,
                   measure: list[0].Measure,
                   measureAr: list[0].measureAr
                 );
                 showToast(text: '${AppLocalizations.of(context).translate("Add_successfully")} ', state: ToastStates.SUCCESS);
               }
             },
             label: Text(AppLocalizations.of(context).translate("Add to yours Meal")),//'Add to yours Meal'),

           ),

           /*Stack(
               fit: StackFit.expand,
               children: [
                 Image(
                   image: FileImage(image),
                   //width: double.infinity,
                   fit: BoxFit.cover,
                 ),
                 /*Padding(
                         padding: const EdgeInsetsDirectional.only(
                             top: 30,
                             end: 480
                         ),
                         child: Container(
                           height: 15,
                           width: 15,
                           child: IconButton(
                             color: Colors.white,
                             onPressed: () {
                               Navigator.pop(context);
                             },
                             icon: const Icon( IconBroken.Arrow___Left_2 ),
                           ),
                         ).asGlass(
                           tintColor: Colors.transparent,
                           clipBorderRadius: BorderRadius.circular(25.0),
                         )
                     ),*/
                 DraggableScrollableSheet(
                         minChildSize: 0.1,
                         maxChildSize: 0.6,
                         builder: (context, scrollController) => SingleChildScrollView(
                           controller: scrollController,
                           child: defaultContainer(
                               context,
                               height: 468,
                               decoration: const BoxDecoration(
                                   color: Colors.white70,
                                   borderRadius: BorderRadius.only(
                                     topRight: Radius.circular(20.0),
                                     topLeft: Radius.circular(20.0),
                                   )
                               ),
                               child: Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                   Padding(
                                     padding: const EdgeInsets.all(16.0),
                                     child: Row(
                                       mainAxisAlignment: MainAxisAlignment.center,
                                       children: [
                                         if(lan=='en')
                                           Padding(
                                             padding: const EdgeInsets.all(10.0),
                                             child: defaultHeadLineText(
                                                 context,
                                                 text: '${HomeCubit.get(context).searchPredictedMeal[0].Food}',
                                                 fontSize: 30
                                             ),
                                           ),
                                         if(lan=='ar')
                                           Padding(
                                             padding: const EdgeInsets.all(10.0),
                                             child: defaultHeadLineText(
                                                 context,
                                                 text: '${HomeCubit.get(context).searchPredictedMeal[0].foodAr}',
                                                 fontSize: 30
                                             ),
                                           ),
                                       ],
                                     ),
                                   ),
                                   Padding(
                                     padding: const EdgeInsets.symmetric(horizontal: 16),
                                     child: Row(
                                       children: [
                                         Column(
                                           crossAxisAlignment: CrossAxisAlignment.start,
                                           children: [
                                             defaultHeadLineText(
                                                 context,
                                                 text:'${AppLocalizations.of(context).translate("Protein")} : ${HomeCubit.get(context).searchPredictedMeal[0].Protein}',
                                                 fontWeight: FontWeight.bold
                                             ),
                                             SizedBox(
                                               height: 10,
                                             ),
                                             defaultHeadLineText(
                                                 context,
                                                 text:'${AppLocalizations.of(context).translate("cal")} : ${HomeCubit.get(context).searchPredictedMeal[0].Calories}',
                                                 fontWeight: FontWeight.bold
                                             ),
                                             SizedBox(
                                               height: 10,
                                             ),
                                             defaultHeadLineText(
                                                 context,
                                                 text:'${AppLocalizations.of(context).translate("Carbs")} : ${HomeCubit.get(context).searchPredictedMeal[0].Carbs}',
                                                 fontWeight: FontWeight.bold
                                             ),
                                             SizedBox(
                                               height: 10,
                                             ),
                                             defaultHeadLineText(
                                                 context,
                                                 text:'${AppLocalizations.of(context).translate("Fats")} : ${HomeCubit.get(context).searchPredictedMeal[0].Fat}',
                                                 fontWeight: FontWeight.bold
                                             ),
                                           ],
                                         )
                                       ],
                                     ),
                                   ),
                                 ],
                               )
                           ),
                         )
                     )
               ],
             ),*/
           ),
            fallback: (context) => Center(child: CircularProgressIndicator())
        );
      },
    );
  }
}
