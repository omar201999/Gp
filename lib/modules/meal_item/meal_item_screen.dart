import 'package:flutter/material.dart';
import 'package:gp/models/meals_model.dart';
import 'package:gp/shared/componants/componants.dart';
import 'package:gp/shared/styles/colors.dart';

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
      ),
      body:  Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:
          [
            defaultContainer(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children:
                  [
                    defaultHeadLineText(
                        context,
                        text: 'Measure is ${mealsModel.Measure}',
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    defaultHeadLineText(
                      context,
                      text: 'Grams is ${mealsModel.Grams}',
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            defaultContainer(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    defaultHeadLineText(
                        context, text: 'Nutrition Per Serving'),
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
                                  defaultBodyText(context, text: 'Cal',
                                      color: Colors.grey),
                                ],
                              ),
                            ),
                          ),
                        ),
                        afterTitleOfRecipeItem(context,
                            numberOfGrams: '${mealsModel.Carbs}',
                            nameOfType: 'Carbs',
                            color: Colors.grey),
                        afterTitleOfRecipeItem(context,
                            numberOfGrams: '${mealsModel.Protein}',
                            nameOfType: 'Proteins',
                            color: Colors.red),
                        afterTitleOfRecipeItem(context,
                            numberOfGrams: '${mealsModel.Fat}',
                            nameOfType: 'Fats',
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
