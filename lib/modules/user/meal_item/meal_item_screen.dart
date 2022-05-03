import 'package:flutter/material.dart';
import 'package:gp/models/meals_model.dart';
import 'package:gp/shared/componants/componants.dart';
import 'package:gp/shared/localization/app_localization%20.dart';
import 'package:gp/shared/styles/colors.dart';
import 'package:gp/shared/styles/icon_broken.dart';

class MealItemScreen extends StatelessWidget {
  MealsModel mealsModel;
  MealItemScreen({
    required this.mealsModel,
});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
          title: '${mealsModel.Food}',
        icon: IconBroken.Arrow___Left_2,
        onPressed: ()
        {
          Navigator.pop(context);
        }
      ),
      body:  Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:
          [
            defaultContainer(
              context,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children:
                  [
                    defaultHeadLineText(
                        context,
                      //AppLocalizations.of(context).translate("  "),//
                        text: '${AppLocalizations.of(context).translate("Measure is")} ${mealsModel.Measure} ',
                    ),
                    SizedBox(
                      height: 5,
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
                      text: '${AppLocalizations.of(context).translate("Grams is")} ${mealsModel.Grams}',
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            defaultContainer(
              context,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
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
                                      fontWeight: FontWeight.bold),
                                  defaultBodyText(context, text: AppLocalizations.of(context).translate("cal"),//'Cal',
                                      color: Colors.grey),
                                ],
                              ),
                            ),
                          ),
                        ),
                        afterTitleOfRecipeItem(context,
                            numberOfGrams: '${mealsModel.Carbs}',
                            nameOfType: AppLocalizations.of(context).translate("Carbs"),//'Carbs',
                            color: Colors.grey),
                        afterTitleOfRecipeItem(context,
                            numberOfGrams: '${mealsModel.Protein}',
                            nameOfType:AppLocalizations.of(context).translate("Protein"),// 'Proteins',
                            color: Colors.red),
                        afterTitleOfRecipeItem(context,
                            numberOfGrams: '${mealsModel.Fat}',
                            nameOfType: AppLocalizations.of(context).translate("Fats"),//'Fats',
                            color: defaultColor),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
