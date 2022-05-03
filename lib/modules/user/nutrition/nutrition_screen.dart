import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/layout/home-layout/cubit/cubit.dart';
import 'package:gp/layout/home-layout/cubit/states.dart';
import 'package:gp/shared/componants/componants.dart';
import 'package:gp/shared/localization/app_localization%20.dart';
import 'package:gp/shared/styles/icon_broken.dart';

class NutritionScreen extends StatelessWidget
{


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
     listener: (context, state)
     {

     },
      builder:(context,state)
      {

        var userModel = HomeCubit.get(context).userModel;
        return  Scaffold(
          appBar: buildAppBar(
            icon: IconBroken.Arrow___Left_2,
            onPressed: () {
              Navigator.pop(context);
            },
            title: AppLocalizations.of(context).translate("nutrition"),//'Nutrition',

          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children:
                [
                  buildNutritionItem(
                    context,
                    title: AppLocalizations.of(context).translate("protein_remaining"),//'Protein Remaining',
                    calorieText: '${userModel!.totalProtein}',
                    foodText: '${HomeCubit.get(context).calculateTotalProtein()}',
                    remainingText: '${userModel.totalProtein! - HomeCubit.get(context).calculateTotalProtein()}',
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  buildNutritionItem(
                    context,
                    title: AppLocalizations.of(context).translate("fats_remaining"),//'Fats Remaining',
                    calorieText: '${userModel.totalFats}',
                    foodText: '${HomeCubit.get(context).calculateTotalFats()}',
                    remainingText: '${userModel.totalFats! - HomeCubit.get(context).calculateTotalFats()}',
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  buildNutritionItem(
                    context,
                    title: AppLocalizations.of(context).translate("carb_remaining"),//'Carbohydrates Remaining',
                    calorieText: '${userModel.totalCarbs}',
                    foodText: '${HomeCubit.get(context).calculateTotalCarbs()}',
                    remainingText: '${userModel.totalCarbs! - HomeCubit.get(context).calculateTotalCarbs()}',
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
