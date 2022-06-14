import 'package:fl_chart/fl_chart.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/layout/home-layout/cubit/cubit.dart';
import 'package:gp/layout/home-layout/cubit/states.dart';
import 'package:gp/shared/componants/componants.dart';
import 'package:gp/shared/cubit/cubit.dart';
import 'package:gp/shared/localization/app_localization%20.dart';
import 'package:gp/shared/styles/icon_broken.dart';

class NutritionScreen extends StatelessWidget
{


  @override
  Widget build(BuildContext context) {

    int totalEaten = 0;

    List<int> allNutrition  = [
      (HomeCubit.get(context).calculateTotalCarbs()).toInt(),
      (HomeCubit.get(context).calculateTotalFats()).toInt(),
      (HomeCubit.get(context).calculateTotalProtein()).toInt(),
    ];

    List<String> gramsOfNut = [
      (HomeCubit.get(context).calculateTotalCarbs()).toString(),
      (HomeCubit.get(context).calculateTotalFats()).toString(),
      (HomeCubit.get(context).calculateTotalProtein()).toString(),
    ];

    List<String> nameOfNut = [
      AppLocalizations.of(context).translate("Carbohydrates"),
      AppLocalizations.of(context).translate("Fats1"),
      AppLocalizations.of(context).translate("Protein1"),
    ];

    List<String> goalOfNut = [
      '50%',
      '30%',
      '20%',
    ];

    int sumTotalEaten() {
      totalEaten = (HomeCubit.get(context).calculateTotalFats() + HomeCubit.get(context).calculateTotalProtein() + HomeCubit.get(context).calculateTotalCarbs()).toInt();
      return totalEaten;
    }

    List<PieChartSectionData> showingSections() {
      return List.generate(
          allNutrition.length, (index)
      {
        int totalAmount = sumTotalEaten();
        //final isTouched = index == touchedIndex;
        const fontSize = 16.0;
        const radius = 50.0;
        if(HomeCubit.get(context).calculateTotalCarbs()==0 && HomeCubit.get(context).calculateTotalFats()==0 && HomeCubit.get(context).calculateTotalProtein()==0)
            {
              return  PieChartSectionData(
                color: Colors.grey,
                value: 360,
                title: '0',
                radius: radius,
                titleStyle: TextStyle(
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                ),
              );
            }
        else
          {
        return buildPieChartItem2(
            allNutrition[index],
            context,
            radius,
            fontSize,
            index,
            totalAmount
        );
      }
          });
    }

    return BlocConsumer<HomeCubit,HomeStates>(
     listener: (context, state)
     {

     },
      builder:(context,state)
      {

        //var userModel = HomeCubit.get(context).userModel;
        return  ConditionalBuilder(
          condition: HomeCubit.get(context).userModel != null  && state is! GetUserDataLoadingState  ,

          builder: (context) => Scaffold(
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
                    buildNutritionItem(context),
                    SizedBox(
                      height: 15,
                    ),
                    //if(HomeCubit.get(context).calculateTotalFats().toInt() != 0 || HomeCubit.get(context).calculateTotalCarbs().toInt() != 0 || HomeCubit.get(context).calculateTotalProtein().toInt() != 0)
                      Column (
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              AppLocalizations.of(context).translate("Macros"),
                              style: Theme.of(context).textTheme.headline1,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15,
                            ),
                            child: AspectRatio(
                              aspectRatio: 1.3,
                              child: Card(
                                color: AppCubit.get(context).scaffoldColor,
                                child: Row(
                                  children: [
                                    const SizedBox(
                                      height: 18,
                                    ),
                                    Expanded(
                                      child: AspectRatio(
                                        aspectRatio: 1,
                                        child: PieChart(
                                          PieChartData(
                                            /*pieTouchData: PieTouchData(
                                        touchCallback: (FlTouchEvent event, pieTouchResponse) {
                                             setState(() {
                                               if (!event.isInterestedForInteractions ||
                                                    pieTouchResponse == null ||
                                                    pieTouchResponse.touchedSection == null) {
                                                    touchedIndex = -1;
                                                        return;
                                               }
                                             touchedIndex = pieTouchResponse.touchedSection!.touchedSectionIndex;
                                         });
                                    }),*/
                                            // centerSpaceRadius: double.infinity,
                                              borderData: FlBorderData(
                                                show: false,
                                              ),
                                              sectionsSpace: 0,
                                              centerSpaceRadius: 40,
                                              sections: showingSections()
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),

                                  ],
                                ),

                              ),
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children:  [
                                  Text(
                                    AppLocalizations.of(context).translate("total"),
                                    style: Theme.of(context).textTheme.bodyText1,

                                  ),
                                  SizedBox(
                                    width: 20.0,
                                  ),
                                  Text(
                                      AppLocalizations.of(context).translate("Goal"),
                                    style: Theme.of(context).textTheme.bodyText1,

                                  )
                                ],
                              )
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 15
                            ),
                            child: defaultContainer(
                              context,
                              color: AppCubit.get(context).scaffoldColor,
                              height: 140,
                              child: ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: allNutrition.length,
                                  itemBuilder: (context, index)
                                  {
                                    if(HomeCubit.get(context).calculateTotalCarbs()==0 && HomeCubit.get(context).calculateTotalFats()==0 && HomeCubit.get(context).calculateTotalProtein()==0)
                                    {
                                      return indicator(
                                        context,
                                          color: colors[index],
                                          text: nameOfNut[index],
                                          isSquare: true,
                                          secondText: '0',
                                          secondTextColor: colors[index],
                                          detailsText: gramsOfNut[index],
                                          thirdText: goalOfNut[index]
                                      );
                                    }
                                    else
                                      {
                                        return indicator(
                                          context,
                                            color: colors[index],
                                            text: nameOfNut[index],
                                            isSquare: true,
                                            secondText: ((allNutrition[index]/totalEaten*100).round()).toString()+'%',
                                            secondTextColor: colors[index],
                                            detailsText: gramsOfNut[index],
                                            thirdText: goalOfNut[index]
                                        );
                                      }

                                  }


                              ),
                            ),
                          )
                        ],
                      )
                  ],
                ),
              ),
            ),
          ),

          fallback: (context) => const Scaffold(
              backgroundColor: Colors.white,
              body: Center(
                  child: Image(
                      image: AssetImage('assets/images/logo.png')
                  )
              )
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
