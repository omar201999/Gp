import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/layout/home-layout/cubit/cubit.dart';
import 'package:gp/layout/home-layout/cubit/states.dart';
import 'package:gp/shared/componants/componants.dart';
import 'package:gp/shared/styles/icon_broken.dart';

class NutritionScreen extends StatelessWidget
{
  List<int> totalFoodProtein = [];
  int totalProtein = 0 ;
  List<int> totalFoodCarbs = [];
  int totalCarbs = 0 ;
  List<int> totalFoodFats = [];
  int totalFats = 0 ;
  List<int> totalFoodCal = [];
  int totalCal = 0 ;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
     listener: (context, state)
     {

     },
      builder:(context,state)
      {
        HomeCubit.get(context).completeDiary.forEach((element)
        {
          totalFoodCal.add(element.Calories!);
        });
        for(int i=0 ; i<= totalFoodCal.length-1 ;i++)
        {
          totalCal = totalCal + totalFoodCal[i] ;
        }
        HomeCubit.get(context).completeDiary.forEach((element)
        {
          totalFoodProtein.add(element.Protein!);
          totalFoodCarbs.add(element.Carbs!);
          totalFoodFats.add(element.Fat!);

        });
        for(int i=0 ; i<= totalFoodProtein.length-1 ;i++)
        {
          totalProtein = totalProtein + totalFoodProtein[i];
          totalCarbs = totalCarbs + totalFoodCarbs[i];
          totalFats = totalFats + totalFoodFats[i];
        }
        var userModel = HomeCubit.get(context).userModel;
        return  Scaffold(
          appBar: buildAppBar(
            icon: IconBroken.Arrow___Left_2,
            onPressed: () {
              Navigator.pop(context);
            },
            title: 'Nutrition',

          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children:
                [
                  buildNutritionItem(
                    context,
                    title: 'Protein Remaining',
                    calorieText: '${userModel!.totalProtein}',
                    foodText: '$totalProtein',
                    remainingText: '${userModel.totalProtein! - totalProtein}',
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  buildNutritionItem(
                    context,
                    title: 'Fats Remaining',
                    calorieText: '${userModel.totalFats}',
                    foodText: '$totalFats',
                    remainingText: '${userModel.totalFats! - totalFats}',
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  buildNutritionItem(
                    context,
                    title: 'Carbohydrates Remaining',
                    calorieText: '${userModel.totalCarbs}',
                    foodText: '$totalCarbs',
                    remainingText: '${userModel.totalCarbs! - totalCarbs}',
                  ),

                ],
              ),
            ),
          ),
        );
      }
    );
  }
}






  /*Widget buildNutrtion() => Container(
    decoration: BoxDecoration(
      color: Colors.white,

    ),
    child: Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children:
        [
          Row(
            children:
            [
              Expanded(
                  flex: 3,
                  child: Text('Protein')),
              Expanded(
                  flex: 1,
                  child: Text('0')),
              Expanded(
                  flex: 1,
                  child: Text('139')),
              Expanded(
                  flex: 1,
                  child: Text('139')),
            ],
          ),
          Slider(
              activeColor: Colors.teal[400],
              min: 10,
              max: 100,
              inactiveColor : Colors.grey,
              value: 50,
              onChanged: (double value) {  }),
        ],
      ),
    ),
  );
}*/
/*
            Table(
              children:
              [
                TableRow(
                  children:
                  [
                    Text('Protin'),
                    Text('0'),
                    Text('139'),
                    Text('139'),

                  ],
                ),
                TableRow(
                  children:
                  [
                    Text('Protin'),
                    Text('0'),
                    Text('139'),
                    Text('139'),

                  ],
                ),
                TableRow(
                  children:
                  [
                    Text('Protin'),
                    Text('0'),
                    Text('139'),
                    Text('139'),

                  ],
                ),
                TableRow(
                  children:
                  [
                    Text('Protin'),
                    Text('0'),
                    Text('139'),
                    Text('139'),

                  ],
                ),
                TableRow(
                  children:
                  [
                    Text('Protin'),
                    Text('0'),
                    Text('139'),
                    Text('139'),

                  ],
                ),
              ],
            ),
*/
