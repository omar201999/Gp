import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/layout/home-layout/cubit/cubit.dart';
import 'package:gp/layout/home-layout/cubit/states.dart';
import 'package:gp/models/user_model.dart';
import 'package:gp/shared/componants/componants.dart';
import 'package:gp/shared/cubit/cubit.dart';
import 'package:gp/shared/localization/app_localization%20.dart';
import 'package:gp/shared/styles/colors.dart';
import 'package:simple_shadow/simple_shadow.dart';

import '../edit_goal/edit_goal_screen.dart';
import '../edit_profile/edit_profile_screen.dart';

class CustomerDashBoardScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => CustomerDashBoardScreenState();
}

class CustomerDashBoardScreenState extends  State<CustomerDashBoardScreen> {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
      listener: (context,stat){},
      builder: (context,state){

        UserModel? userModel = HomeCubit.get(context).userModel;


        return Scaffold(
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Column(
                  children: [
                    Container(
                      height: 150,
                      width: double.infinity,
                      color: AppCubit.get(context).scaffoldColor,
                      child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            /*Align(
                            alignment: Alignment.topCenter,
                            child:
                            /*Image(
                              fit: BoxFit.cover,
                              height: 180,
                              width: double.infinity,
                              image: NetworkImage('https://img.freepik.com/free-photo/vegetables-set-left-black-slate_1220-685.jpg?w=1380'),
                            )*/
                          ),*/
                            /*CircleAvatar(
                              radius: 52,
                              backgroundColor: AppCubit,
                            ),*/
                            SimpleShadow(
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 2),
                                child: CircleAvatar(
                                backgroundImage: NetworkImage('${userModel?.profileImage}'),
                                radius: 50,
                                 ),
                              ),
                              opacity: 0.5,
                              color: AppCubit.get(context).shadowColor,
                              offset: Offset(1, 1),
                              sigma: 5,
                            )
                          ],
                        ),

                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: [
                        defaultHeadLineText(context, text: '${userModel?.name}'),

                      ],
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(
                        top: 5,
                        start: 20,
                        end: 20,
                        bottom: 10,
                      ),
                      child: defaultContainer(
                        context,
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              defaultHeadLineText(context, text:  AppLocalizations.of(context).translate("goal_weight"),color: defaultColor),
                              SizedBox(height: 10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: defaultColor,
                                        radius: 35,
                                      ),
                                      CircleAvatar(
                                        child: defaultHeadLineText(context, text: '${userModel!.goalWeight}',color: defaultColor),
                                        backgroundColor: Colors.white,
                                        radius: 30,
                                      ),

                                    ],
                                  ),
                                ],
                              ),
                              TextButton(
                                  onPressed: (){
                                  },
                                  child: defaultBodyText(
                                      context,
                                      text:  AppLocalizations.of(context).translate("add_weight"),//'add weight',
                                      color: defaultColor
                                  )
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: defaultContainer(
                        context,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  defaultHeadLineText(context, text:  AppLocalizations.of(context).translate("goal"),color: defaultColor),//'Goal'
                                  Spacer(),
                                  defaultTextButton(context, function: (){
                                    navigateTo(context, EditGoalScreen());
                                  }, text: AppLocalizations.of(context).translate("edit_goal"))//'Edit Goal')
                                ],
                              ),
                              SizedBox(height: 20,),
                              secondPart(
                                  context,
                                  subHeadLine: AppLocalizations.of(context).translate("current_weight"),//'Current Weight' ,
                                  subHeadLine2: '${userModel.weight}',
                                  caption: '${AppLocalizations.of(context).translate("Gain")}${userModel.weeklyGoal} ${AppLocalizations.of(context).translate("kg per week")}'//'Gain ${userModel.weeklyGoal} kg per week'
                              ),
                              SizedBox(height: 20,),
                              secondPart(
                                  context,
                                  subHeadLine: AppLocalizations.of(context).translate("daliy_calories"),//'Daily Calories' ,
                                  subHeadLine2: '${userModel.totalCalorie}g' ,
                                  caption: '${AppLocalizations.of(context).translate("Carbs")} ${userModel.totalCarbs} , ${AppLocalizations.of(context).translate("Fats")} ${userModel.totalFats},${AppLocalizations.of(context).translate("Protein")} ${userModel.totalProtein}'
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),

                    Container(
                      height: 450,
                      width: double.infinity,
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                          color: const Color(0xff81e5cd),
                          child: Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    const Text(
                                      'Your Weekly Goal Calories',
                                      style: TextStyle(
                                          color: Color(0xff0f4a3c),
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    const Text(
                                      'Last Week',
                                      style: TextStyle(
                                          color: Color(0xff379982),
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 38,
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                        child: BarChart(
                                          isPlaying ? randomData() : mainBarData(),
                                          swapAnimationDuration: animDuration,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: IconButton(
                                    icon: Icon(
                                      isPlaying ? Icons.pause : Icons.play_arrow,
                                      color: const Color(0xff0f4a3c),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        isPlaying = !isPlaying;
                                        if (isPlaying) {
                                          refreshState();
                                        }
                                      });
                                    },
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ) ,
                    )

                  ],
                ),
                SizedBox(
                  height: 30,
                ),


              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: (){
              navigateTo(context, EditProfileScreen());

            },
            child: Icon(Icons.edit),
          ),
        );
      },
    );
  }
  BarChartData mainBarData() {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.blueGrey,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              String weekDay;
              switch (group.x.toInt()) {
                case 0:
                  weekDay = 'Monday';
                  break;
                case 1:
                  weekDay = 'Tuesday';
                  break;
                case 2:
                  weekDay = 'Wednesday';
                  break;
                case 3:
                  weekDay = 'Thursday';
                  break;
                case 4:
                  weekDay = 'Friday';
                  break;
                case 5:
                  weekDay = 'Saturday';
                  break;
                case 6:
                  weekDay = 'Sunday';
                  break;
                default:
                  throw Error();
              }
              return BarTooltipItem(
                weekDay + '\n',
                const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: (rod.toY - 1).toString(),
                    style: const TextStyle(
                      color: Colors.yellow,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              );
            }),
        touchCallback: (FlTouchEvent event, barTouchResponse) {
          setState(() {
            if (!event.isInterestedForInteractions ||
                barTouchResponse == null ||
                barTouchResponse.spot == null) {
              touchedIndex = -1;
              return;
            }
            touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: getTitles,
            reservedSize: 38,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(),
      gridData: FlGridData(show: false),
    );
  }

  Future<dynamic> refreshState() async {
    setState(() {});
    await Future<dynamic>.delayed(
        animDuration + const Duration(milliseconds: 50));
    if (isPlaying) {
      await refreshState();
    }
  }


}


Widget secondPart(BuildContext context , {
  String? subHeadLine ,
  String? subHeadLine2 ,
  String? caption ,
}) => Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [

    Row(
      children: [
        defaultBodyText(context, text: '$subHeadLine'),
        Spacer(),
        defaultBodyText(context, text: '$subHeadLine2'),
      ],
    ),
    SizedBox(height: 5,),
    Text(
      '$caption',
      style: Theme.of(context).textTheme.caption,
    ),
  ],
);