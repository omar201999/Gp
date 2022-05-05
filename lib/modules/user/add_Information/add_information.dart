import 'package:flutter/material.dart';
import 'package:gp/modules/user/onBoarding/onBoarding_screen.dart';
import 'package:gp/modules/user/register/register_screen.dart';
import 'package:gp/shared/componants/componants.dart';
import 'package:gp/shared/cubit/cubit.dart';
import 'package:gp/shared/localization/app_localization%20.dart';
import 'package:gp/shared/styles/icon_broken.dart';
class AddInformation extends StatefulWidget {

  @override
  State<AddInformation> createState() => _AddInformationState();

}
enum goalList {gain,maintain,loss}
enum activeList {not,lightly,active,very,hulk}

class _AddInformationState extends State<AddInformation>
{
  goalList? goalGroup ;
  activeList? activeGroup ;
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
  var weightController = TextEditingController();
  var heightController = TextEditingController();
  var goalWeightController = TextEditingController();
  var ageController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool isMale = true;
  String? goal;
  double? active;


@override
  Widget build(BuildContext context)
  {


  return Scaffold(
      appBar: buildAppBar(
          title: AppLocalizations.of(context).translate("Add_info"),
          icon: IconBroken.Arrow___Left_2,
          onPressed: () {
          //Navigator.pop(context);
            navigateToAndReplacement(context, OnBoardingScreen());
         },
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
              [
                Row(
                  children:
                  [
                    Expanded(
                      child: defaultGestureDetector(
                        onTap: ()
                        {
                          setState(() {
                            isMale = true;
                          });
                        },
                        child: Container(
                          color: isMale ? Colors.blue : AppCubit.get(context).constantColor1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:
                            [
                              Image(
                                image: AssetImage('assets/images/male-gender-icon-14.jpg'),
                                height: 90,
                                width: 90,
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              defaultHeadLineText(
                                  context,
                                  text: AppLocalizations.of(context).translate("male"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: defaultGestureDetector(
                        onTap: ()
                        {
                          setState(() {
                            isMale = false;
                          });
                        },
                        child: Container(
                          color: !isMale ? Colors.blue : AppCubit.get(context).constantColor1 ,

                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:
                            [
                              Image(
                                image: AssetImage('assets/images/female.png'),
                                height: 90,
                                width: 90,
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              defaultHeadLineText(
                                context,
                                text: AppLocalizations.of(context).translate("female"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                defaultHeadLineText(
                    context,
                    text: AppLocalizations.of(context).translate("your_goal"),
                ),
                SizedBox(
                  height: 5,
                ),
                defaultContainer(
                  context,
                  radius: 15,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children:
                      [
                        RadioListTile<goalList>(
                          contentPadding: EdgeInsets.zero,
                          title:  Text(AppLocalizations.of(context).translate("gain")),
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

                          title: Text(AppLocalizations.of(context).translate("maintain")),
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

                          title:  Text(AppLocalizations.of(context).translate("lose")),
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
                /*Row(
                  children:
                  [
                    Expanded(
                      child: InkWell(
                        onTap: ()
                        {
                          setState(() {
                            goalColor1 = Colors.blue;
                            goal = 'Loss';
                            print(goal.toString());

                          });

                        },
                        child: defaultContainer(
                          height: 40,
                          width: 50,
                          color: goalColor1,
                            child: Align(
                              alignment: Alignment.center,
                              child: defaultBodyText(
                                  context,
                                  text: 'Loss Weight',
                              ),
                            ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: ()
                        {
                          setState(() {
                            goalColor2 = Colors.blue;
                            goal = 'Maintain';
                            print(goal..toString());

                          });

                        },
                        child: defaultContainer(
                          height: 40,
                          width: 50,
                          color: goalColor2,
                          child: Align(
                            alignment: Alignment.center,
                            child: defaultBodyText(
                              context,
                              text: 'Maintain Weight',
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: ()
                        {
                          setState(() {
                            goalColor3 = Colors.blue;
                            goal = 'Gain';
                            print(goal..toString());

                          });

                        },
                        child: defaultContainer(
                          height: 40,
                          width: 50,
                          color: goalColor3,
                          child: Align(
                            alignment: Alignment.center,
                            child: defaultBodyText(
                              context,
                              text: 'Gain Weight',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),*/
                SizedBox(
                  height: 15,
                ),
                defaultHeadLineText(
                  context,
                  text: AppLocalizations.of(context).translate("active_level"),
                ),
                SizedBox(
                  height: 5,
                ),
                defaultContainer(
                  context,
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
                                text: AppLocalizations.of(context).translate("not_active"),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                AppLocalizations.of(context).translate("ex_not_active"),//'Spend most of the day sitting (e.g., desk jop)'
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
                                text: AppLocalizations.of(context).translate("lightly_active"),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                AppLocalizations.of(context).translate("ex_lightly_active"),//Spend a good part of the day on your feet and train from 1 to 3 days (e.g., teacher, salesperson)
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
                              text: AppLocalizations.of(context).translate("active"),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              AppLocalizations.of(context).translate("ex_active"),//'Spend a good part of the day doing some physical activity and train from 3 to 5 days (e.g., food server, postal carrier).'
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
                                text: AppLocalizations.of(context).translate("very_active"),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                AppLocalizations.of(context).translate("ex_very_active"),//'Spend a good part of the day doing heavy physical activity train from 5 to 7 days (e.g., bike messenger, carpenter).',
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
                                text:  AppLocalizations.of(context).translate("hulk"),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                AppLocalizations.of(context).translate("ex_hulk"),//'Spend most of the day Hard training ',
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
                /*InkWell(
                  onTap: ()
                  {
                    setState(() {
                      activeColor1 = Colors.blue;
                      active = 'not active';
                      print(active..toString());

                    });

                  },
                  child: defaultContainer(
                    width: double.infinity,
                    color: activeColor1,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:
                        [
                          defaultBodyText(
                              context,
                              text: 'Not Active',
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          defaultBodyText(
                            context,
                            text: 'Spend most of the day sitting (e.g., desk jop)',
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: ()
                  {
                    setState(() {
                      activeColor2 = Colors.blue;
                      active = 'lightly active';
                      print(active..toString());

                    });

                  },
                  child: defaultContainer(
                    width: double.infinity,
                    color: activeColor2,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children:
                        [
                          defaultBodyText(
                            context,
                            text: 'Lightly Active',
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          defaultBodyText(
                            context,
                            text: 'Spend a good part of the day on your feet and train from 1 to 3 days (e.g., teacher, salesperson)',
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                onTap: ()
                {
                  setState(() {
                    activeColor3 = Colors.blue;
                    active = 'active';
                    print(active..toString());

                  });

                },
                child: defaultContainer(
                  width: double.infinity,
                  color: activeColor3,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                      [
                        defaultBodyText(
                          context,
                          text: 'Active',
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        defaultBodyText(
                          context,
                          text: 'Spend a good part of the day doing some physical activity and train from 3 to 5 days (e.g., food server, postal carrier).',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: ()
                  {
                    setState(() {
                      activeColor4 = Colors.blue;
                      active = 'very active';
                      print(active.toString());

                    });

                  },
                  child: defaultContainer(
                    width: double.infinity,
                    color: activeColor4,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children:
                        [
                          defaultBodyText(
                            context,
                            text: 'Very Active',
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          defaultBodyText(
                            context,
                            text: 'Spend a good part of the day doing heavy physical activity train from 5 to 7 days (e.g., bike messenger, carpenter).',
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),*/

                SizedBox(
                  height: 10,
                ),

                   defaultTextFormField(
                      controller: weightController,
                      type: TextInputType.number,
                      validate: (String? value)
                      {
                        if(value!.isEmpty)
                        {
                          return  AppLocalizations.of(context).translate("validate_weight"); //'please enter your Weight';
                        }
                      },
                      label:  AppLocalizations.of(context).translate("weight"),//'Weight',
                      border: OutlineInputBorder(),
                      hintText: AppLocalizations.of(context).translate("convert_weight"),//'Weight into Kg',
                  ),

                SizedBox(
                  height: 10,
                ),
                 defaultTextFormField(
                    controller: heightController,
                    type: TextInputType.number,
                    validate: (String? value)
                    {
                      if(value!.isEmpty)
                      {
                        return AppLocalizations.of(context).translate("validate_height");//'please enter your Height';
                      }
                    },
                    label: AppLocalizations.of(context).translate("height"),//'Height',
                   border: OutlineInputBorder(),
                    hintText: AppLocalizations.of(context).translate("convert_height"),//'Height into cm',

                  ),

                SizedBox(
                  height: 10,
                ),
                defaultTextFormField(
                      controller: goalWeightController,
                      type: TextInputType.number,
                      validate: (String? value)
                      {
                        if(value!.isEmpty)
                        {
                          return AppLocalizations.of(context).translate("validate_goal_weight");//'please enter Goal Weight';
                        }
                      },
                      label: AppLocalizations.of(context).translate("goal_weight"),//'Goal Weight',
                     border:OutlineInputBorder(),
                      hintText: AppLocalizations.of(context).translate("convert_goal_weight"),//'Goal Weight into Kg',
                    ),
                SizedBox(
                  height: 10,
                ),
                 defaultTextFormField(
                   controller: ageController,
                   type: TextInputType.number,
                   validate: (String? value)
                   {
                     if(value!.isEmpty)
                     {
                       return AppLocalizations.of(context).translate("validate_age");//'please enter your Age';
                     }
                   },
                   label: AppLocalizations.of(context).translate("age"),//'Age',
                   border: OutlineInputBorder(),
                 ),



                SizedBox(
                  height: 10,
                ),
                defaultButton(
                  context,
                  text: AppLocalizations.of(context).translate("register"),//'Register Now ',
                  onPreesed: ()
                    {
                      if(formKey.currentState!.validate()) {
                        if (active == null || goal == null) {
                          showToast(
                              text: AppLocalizations.of(context).translate("validate_active_and_goal"),//'please enter your active and your goal',
                              state: ToastStates.ERROR);
                        }
                        else {
                          navigateTo(context, RegisterScreen(
                            weight: double.parse(weightController.text),
                            height: double.parse(heightController.text),
                            gender: isMale ? 'Male' : 'Female',
                            goalWeight: double.parse(goalWeightController.text),
                            goal: goal,
                            active: active,
                            isMale: isMale,
                            age: int.parse(ageController.text),
                          ));
                        }
                      }

                    },
                ),


              ],
            ),
          ),
        ),
      ),
    );
  }
}
