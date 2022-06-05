import 'package:flutter/material.dart';
import 'package:gp/models/meals_model.dart';
import 'package:gp/shared/componants/componants.dart';
import 'package:gp/shared/componants/constant.dart';
import 'package:gp/shared/localization/app_localization%20.dart';
import 'package:gp/shared/styles/colors.dart';

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
                         children: [
                           Expanded(
                             child: CircleAvatar(
                               backgroundColor: defaultColor,
                               radius: 40,
                               child: CircleAvatar(
                                 radius: 35,
                                 backgroundColor: Colors.white,
                                 child: Column(
                                   mainAxisAlignment: MainAxisAlignment
                                       .center,
                                   children:
                                   [
                                     defaultBodyText(context, text: '${mealsModel.Calories}',
                                         fontWeight: FontWeight.bold,color: defaultColor),
                                     defaultBodyText(context, text: AppLocalizations.of(context).translate("cal"),//'Cal',
                                         color: Colors.grey),
                                   ],
                                 ),
                               ),
                             ),
                           ),
                           afterTitleOfRecipeItem(context,
                               numberOfGrams: '${mealsModel.Carbs}',
                               nameOfType: '${AppLocalizations.of(context).translate("Carbs1")} ${AppLocalizations.of(context).translate("g")}',//'Carbs',
                               color: Colors.grey),
                           afterTitleOfRecipeItem(context,
                               numberOfGrams: '${mealsModel.Protein}',
                               nameOfType:'${AppLocalizations.of(context).translate("Protein")} ${AppLocalizations.of(context).translate("g")}',// 'Proteins',
                               color: Colors.red),
                           afterTitleOfRecipeItem(context,
                               numberOfGrams: '${mealsModel.Fat}',
                               nameOfType: '${AppLocalizations.of(context).translate("Fats")} ${AppLocalizations.of(context).translate("g")}',//'Fats',
                               color: defaultColor),
                         ],
                       )
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
