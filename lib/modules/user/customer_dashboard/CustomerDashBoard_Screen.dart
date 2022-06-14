import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/layout/home-layout/cubit/cubit.dart';
import 'package:gp/layout/home-layout/cubit/states.dart';
import 'package:gp/models/user_model.dart';
import 'package:gp/shared/componants/componants.dart';
import 'package:gp/shared/componants/constant.dart';
import 'package:gp/shared/cubit/cubit.dart';
import 'package:gp/shared/localization/app_localization%20.dart';
import 'package:gp/shared/styles/colors.dart';
import 'package:intl/intl.dart';
import 'package:simple_shadow/simple_shadow.dart';

import '../edit_goal/edit_goal_screen.dart';
import '../edit_profile/edit_profile_screen.dart';

class CustomerDashBoardScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => CustomerDashBoardScreenState();
}

class CustomerDashBoardScreenState extends  State<CustomerDashBoardScreen> {

  @override
  void initState()
  {
    super.initState();
    HomeCubit.get(context).getAllCompleteDiary();
  }

  @override
  Widget build(BuildContext context) {

    UserModel? userModel = HomeCubit.get(context).userModel;

    int touchedIndex = -1;
    List<int> days = [
      DateTime.now().subtract(const Duration(days:7)).day,
      DateTime.now().subtract(const Duration(days:6)).day,
      DateTime.now().subtract(const Duration(days:5)).day,
      DateTime.now().subtract(const Duration(days:4)).day,
      DateTime.now().subtract(const Duration(days:3)).day,
      DateTime.now().subtract(const Duration(days:2)).day,
      DateTime.now().subtract(const Duration(days:1)).day,
    ];

    List<String> daysName = [
      DateFormat('E',lan!).format(DateTime.now().subtract(const Duration(days:7))),
      DateFormat('E',lan!).format(DateTime.now().subtract(const Duration(days:6))),
      DateFormat('E',lan!).format(DateTime.now().subtract(const Duration(days:5))),
      DateFormat('E',lan!).format(DateTime.now().subtract(const Duration(days:4))),
      DateFormat('E',lan!).format(DateTime.now().subtract(const Duration(days:3))),
      DateFormat('E',lan!).format(DateTime.now().subtract(const Duration(days:2))),
      DateFormat('E',lan!).format(DateTime.now().subtract(const Duration(days:1))),
    ];

    List<BarChartGroupData> showingGroups() => List.generate(7, (i) {
      return makeGroupData(
        i,
        HomeCubit.get(context).calculateTotalCalOfCompleteDiaryOfDay(days[i]).toDouble(),
        userModel,
        isTouched: i == touchedIndex,
      );

    });



    Widget getTitles(double value, TitleMeta meta) {
      const style = TextStyle(
        color: Colors.grey,
        fontWeight: FontWeight.bold,
        fontSize: 14,
      );
      Widget text = Text(
        daysName[value.toInt()],
        style: style,

      );

      return SideTitleWidget(
        axisSide: meta.axisSide,
        space: 16,
        child: text,
      );
    }

    BarChartData mainBarData() {
      return BarChartData(
        groupsSpace: 20.0,
        alignment: BarChartAlignment.spaceBetween,
        barTouchData: BarTouchData(
          touchTooltipData: BarTouchTooltipData(
              tooltipBgColor: Colors.black38,
              //Colors.blueGrey,
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                String weekDay = daysName[group.x.toInt()];
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
                        color: defaultColor,
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


    return BlocConsumer<HomeCubit,HomeStates>(
      listener: (context,stat){},
      builder: (context,state){

        return Scaffold(
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Column(
                  children: [
                    Column(
                        children: [
                          Container(
                            height: 150,
                            width: double.infinity,
                            //color: AppCubit.get(context).scaffoldColor,
                            child: Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                /*Align(
                            alignment: Alignment.topCenter,
                            child:
                             Image(
                              fit: BoxFit.cover,
                              height: 180,
                              width: double.infinity,
                              image: NetworkImage('https://img.freepik.com/free-photo/vegetables-set-left-black-slate_1220-685.jpg?w=1380'),
                             )
                           ),
                              CircleAvatar(
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
                                ),
                              ],
                            ),

                          ),
                          SizedBox(
                            height: 10,
                          ),

                          defaultHeadLineText(context, text: '${userModel?.name}'),
                          //defaultBodyText(context, text: '${userModel?.email}', fontSize: 12, color: Colors.grey),

                          SizedBox(
                            height: 20,
                          ),

                        ],
                      ),

                          Padding(
                            padding: const EdgeInsetsDirectional.only(
                              top: 15,
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
                                        defaultHeadLineText(context, text:  AppLocalizations.of(context).translate("Goal"),color: defaultColor),//'Goal'
                                        Spacer(),
                                        defaultTextButton(context, function: (){
                                          navigateTo(context, EditGoalScreen());
                                        }, text: AppLocalizations.of(context).translate("edit_goal"))//'Edit Goal')
                                      ],
                                    ),
                                    SizedBox(height: 20,),
                                    secondPart(
                                        context,
                                        subHeadLine: AppLocalizations.of(context).translate("goal_weight"),//'Current Weight' ,
                                        subHeadLine2: '${userModel.goalWeight}',
                                        caption: '${AppLocalizations.of(context).translate("Gain")} ${userModel.weeklyGoal} ${AppLocalizations.of(context).translate("kg per week")}'//'Gain ${userModel.weeklyGoal} kg per week'
                                    ),
                                    SizedBox(height: 20,),
                                    secondPart(
                                        context,
                                        subHeadLine:'${userModel.totalCalorie}${AppLocalizations.of(context).translate("g")}',
                                        //AppLocalizations.of(context).translate("cal"),//'Daily Calories' ,
                                        subHeadLine2: AppLocalizations.of(context).translate("cal") ,
                                        caption: '${AppLocalizations.of(context).translate("Carbs1")} ${userModel.totalCarbs} ,${AppLocalizations.of(context).translate("Fats1")} ${userModel.totalFats},${AppLocalizations.of(context).translate("Protein1")} ${userModel.totalProtein}'
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Container(
                              height: 450,
                              width: double.infinity,
                              child: AspectRatio(
                                aspectRatio: 1,
                                child: Card(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                                  color: AppCubit.get(context).constantColor1,
                                  //Color(0xff81e5cd),
                                  child: Stack(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(16),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.stretch,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            Text(
                                              AppLocalizations.of(context).translate("weekly_goal_calories"),
                                              style: Theme.of(context).textTheme.headline1!.copyWith(fontSize: 20.0),
                                            ),
                                            const SizedBox(
                                              height: 4,
                                            ),
                                             Text(
                                               AppLocalizations.of(context).translate("updated_last_days"),
                                              style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 14),
                                              /*TextStyle(
                                                  color: Colors.white,
                                                  //Color(0xff379982),
                                                  fontSize: 16,
                                                  //fontWeight: FontWeight.bold
                                                 ),*/
                                            ),
                                            const SizedBox(
                                              height: 38,
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                child: BarChart(
                                                  mainBarData(),
                                                  //swapAnimationDuration: animDuration,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 12,
                                            ),
                                          ],
                                        ),
                                      ),
                                      /*Padding(
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
                                  )*/
                                    ],
                                  ),
                                ),
                              ) ,
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                  ],
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


  /*Future<dynamic> refreshState() async {
    setState(() {});
    await Future<dynamic>.delayed(
        animDuration + const Duration(milliseconds: 50));
    if (isPlaying) {
      await refreshState();
    }
  }*/


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
        SizedBox(width: 4,),
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