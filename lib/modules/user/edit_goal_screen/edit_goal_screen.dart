import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/layout/home-layout/cubit/cubit.dart';
import 'package:gp/layout/home-layout/cubit/states.dart';
import 'package:gp/shared/componants/componants.dart';

class EditGoalScreen extends StatefulWidget {
  @override
  _State createState() => _State();

}
enum goalList {gain,maintain,loss}
enum activeList {not,lightly,active,very,hulk}

class _State extends State<EditGoalScreen> {


  goalList? goalGroup ;
  activeList? activeGroup ;
  String? goal;
  double? active;

  double chooseActiveValue(activeList state) {
    double? active;

    switch (state) {
      case activeList.not:
        active = 1.2;
        break;
      case activeList.lightly:
        active = 1.3;
        break;
      case activeList.active:
        active = 1.5;
        break;
      case activeList.very:
        active = 1.7;
        break;
      case activeList.hulk:
        active = 1.9;
        break;
    }
    return active;

  }
  String chooseGoalValue(goalList state) {
    String? goal;

    switch (state) {
      case goalList.gain:
        goal = 'gain';
        break;
      case goalList.maintain:
        goal = 'maintain';
        break;
      case goalList.loss:
        goal = 'loss';
        break;
    }
    return goal;
  }


  int? totalCalorie;
  int? totalProtein;
  int? totalFats;
  int? totalCarbs;

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
      listener: (context,state){},
      builder: (context,state){
        var model = HomeCubit.get(context).userModel;
        totalCalorie = model!.gender == 'Male' ? ((10 * (model.weight)!.round()  + 6.25 * (model.height)!.round() - 5 * (model.age)!.round() + 5) * active!).round() :  ((10 * (model.weight)!.round() + 6.25 * (model.height)!.round() - 5 * (model.age)!.round() - 161) * active!).round() ;
        if(goal == 'maintain')
        {
          totalCalorie = totalCalorie;
          totalProtein = (1.5 * (model.weight)!.round()).round();
          totalFats = ((20/100) * totalCalorie!).round();
          totalCarbs = ((totalCalorie! - (4 * totalProtein! + totalFats! )) / 4) .round();
        }else if(goal == 'gain')
        {
          totalCalorie = totalCalorie! +  400;
          totalProtein = (2 * (model.weight)!.round()).round();
          totalFats = ((30/100) * totalCalorie!).round();
          totalCarbs = ((totalCalorie! - (4 * totalProtein! + totalFats! )) / 4) .round();
        }else
        {
          totalCalorie = totalCalorie! - 400;
          totalProtein = (1.5 * (model.weight)!.round()).round();
          totalFats = ((20/100) * totalCalorie!).round();
          totalCarbs = ((totalCalorie! - (4 * totalProtein! + totalFats! )) / 4) .round();
        }

        return Scaffold(
            appBar: buildAppBar(title:'Edit Goal'),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  defaultContainer(
                    radius: 15,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children:
                        [
                          RadioListTile<goalList>(
                            contentPadding: EdgeInsets.zero,
                            title:  Text('Gain'),
                            value: goalList.gain,
                            groupValue: goalGroup,
                            onChanged: (goalList? value) {
                              setState(() {
                                goalGroup = value!;
                                goal = chooseGoalValue(goalList.gain);
                                print(goal.toString());
                              });
                            },

                          ),
                          RadioListTile<goalList>(
                            contentPadding: EdgeInsets.zero,

                            title:  Text('Maintain'),
                            value: goalList.maintain,
                            groupValue: goalGroup,
                            onChanged: (goalList? value) {
                              setState(() {
                                goalGroup = value!;
                                goal = chooseGoalValue(goalList.maintain);
                                print(goal.toString());
                              });
                            },
                          ),
                          RadioListTile<goalList>(
                            contentPadding: EdgeInsets.zero,

                            title:  Text('Lose'),
                            value: goalList.loss,
                            groupValue: goalGroup,
                            onChanged: (goalList? value) {
                              setState(() {
                                goalGroup = value!;
                                goal = chooseGoalValue(goalList.loss);
                                print(goal.toString());
                              });
                            },

                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  defaultContainer(
                    radius: 15,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children:
                        [
                          RadioListTile<activeList>(
                            contentPadding: EdgeInsets.zero,
                            title:  Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:
                              [
                                defaultBodyText(
                                  context,
                                  text: 'Not Active',
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  'Spend most of the day sitting (e.g., desk jop)',
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              ],
                            ),
                            value: activeList.not,
                            groupValue: activeGroup,
                            onChanged: (activeList? value) {
                              setState(() {
                                activeGroup = value!;
                                active = chooseActiveValue(activeList.not);
                                print(active.toString());
                              });
                            },
                          ),
                          RadioListTile<activeList>(
                            contentPadding: EdgeInsets.zero,
                            title:  Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:
                              [
                                defaultBodyText(
                                  context,
                                  text: 'Lightly Active',
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  'Spend a good part of the day on your feet and train from 1 to 3 days (e.g., teacher, salesperson)',
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              ],
                            ),
                            value: activeList.lightly,
                            groupValue: activeGroup,
                            onChanged: (activeList? value) {
                              setState(() {
                                activeGroup = value!;
                                active = chooseActiveValue(activeList.lightly);
                                print(active.toString());
                              });
                            },
                          ),
                          RadioListTile<activeList>(
                            contentPadding: EdgeInsets.zero,
                            title:  Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:
                              [
                                defaultBodyText(
                                  context,
                                  text: 'Active',
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  'Spend a good part of the day doing some physical activity and train from 3 to 5 days (e.g., food server, postal carrier).',
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              ],
                            ),
                            value: activeList.active,
                            groupValue: activeGroup,
                            onChanged: (activeList? value) {
                              setState(() {
                                activeGroup = value!;
                                active = chooseActiveValue(activeList.active);
                                print(active.toString());
                              });
                            },
                          ),
                          RadioListTile<activeList>(
                            contentPadding: EdgeInsets.zero,
                            title:  Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:
                              [
                                defaultBodyText(
                                  context,
                                  text: 'Very Active',
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  'Spend a good part of the day doing heavy physical activity train from 5 to 7 days (e.g., bike messenger, carpenter).',
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              ],
                            ),
                            value: activeList.very,
                            groupValue: activeGroup,
                            onChanged: (activeList? value) {
                              setState(() {
                                activeGroup = value!;
                                active = chooseActiveValue(activeList.very);
                                print(active.toString());
                              });
                            },
                          ),
                          RadioListTile<activeList>(
                            contentPadding: EdgeInsets.zero,
                            title:  Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:
                              [
                                defaultBodyText(
                                  context,
                                  text: 'Hulk',
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  'Spend most of the day Hard training ',
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              ],
                            ),
                            value: activeList.hulk,
                            groupValue: activeGroup,
                            onChanged: (activeList? value) {
                              setState(() {
                                activeGroup = value!;
                                active = chooseActiveValue(activeList.hulk);
                                print(active.toString());
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  defaultButton(context, onPreesed: (){
                    HomeCubit.get(context).updateUser(
                      active: active,
                      goal: goal,
                      totalProtein: totalProtein,
                      totalFats: totalFats,
                      totalCarbs: totalCarbs,
                      totalCalorie: totalCalorie,
                    );
                  }, text: 'UPDATE')
                ],
              ),
            )
        );
      },
    );
  }
}
