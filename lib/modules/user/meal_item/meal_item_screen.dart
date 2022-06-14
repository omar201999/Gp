import 'package:flutter/material.dart';
import 'package:gp/models/meals_model.dart';
import 'package:gp/shared/componants/componants.dart';
import 'package:gp/shared/componants/constant.dart';
import 'package:gp/shared/localization/app_localization%20.dart';

class MealItemScreen extends StatelessWidget {
  MealsModel mealsModel;
  MealItemScreen({
    required this.mealsModel,
});
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(12.0),
        child: Center(
          child: defaultContainer(
            context,
            /*clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,//HexColor('#4d4d4d')
              borderRadius: BorderRadius.circular(10),
            ),*/
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:
                    [
                      if(lan=='en')
                      defaultHeadLineText(
                          context,
                        //AppLocalizations.of(context).translate("  "),//
                          text: '${AppLocalizations.of(context).translate("Measure is")} ${mealsModel.Measure} ',
                      ),
                      if(lan=='ar')
                        defaultHeadLineText(
                          context,
                          text: '${AppLocalizations.of(context).translate("Measure is")} ${mealsModel.measureAr} ',
                        ),

                      if (mealsModel.Grams == null)
                        defaultHeadLineText(
                        context,
                        text: AppLocalizations.of(context).translate("Grams is Follow the Recipe"),//'Grams is Follow the Recipe',
                        ),
                      if(mealsModel.Grams != null)
                        defaultHeadLineText(
                        context,
                         // AppLocalizations.of(context).translate("  "),//
                        text: '${AppLocalizations.of(context).translate("Grams is")}${mealsModel.Grams}',
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 5,
                  ),
                   Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       defaultHeadLineText(
                           context, text: AppLocalizations.of(context).translate("Nutrition Per Serving"),//'Nutrition Per Serving',
                       ),
                       const SizedBox(height: 5,),
                       Row(
                         children:
                         [
                           //'${widget.recipeModel.carbs}g' AppLocalizations.of(context).translate("Carbs")
                           buildNutritionItemForRecipeItemScreen(
                             context,
                             imagePath:  'assets/images/cereal-grain-svgrepo-com.svg',
                             numOFNutrition: '${mealsModel.Carbs}${AppLocalizations.of(context).translate("g")}',
                             typeOFNutrition: AppLocalizations.of(context).translate("Carbs2"),
                           ),
                           buildNutritionItemForRecipeItemScreen(
                             context,
                             imagePath:  'assets/images/avocado-svgrepo-com (1).svg',
                             numOFNutrition: '${mealsModel.Protein}${AppLocalizations.of(context).translate("g")}',
                             typeOFNutrition: AppLocalizations.of(context).translate("Protein1"),
                           ),
                           buildNutritionItemForRecipeItemScreen(
                             context,
                             imagePath:  'assets/images/fire-svgrepo-com.svg',
                             numOFNutrition: '${mealsModel.Calories}${AppLocalizations.of(context).translate("g")}',
                             typeOFNutrition: AppLocalizations.of(context).translate("cal1"),
                           ),
                           buildNutritionItemForRecipeItemScreen(
                             context,
                             imagePath: 'assets/images/pizza.svg',
                             numOFNutrition: '${mealsModel.Fat}${AppLocalizations.of(context).translate("g")}',
                             typeOFNutrition: AppLocalizations.of(context).translate("Fats1"),
                           ),
                         ],
                       ),
                     ],
                   ),

                ],
              ),
            ),
          ),
        ),
      );
  }
}
