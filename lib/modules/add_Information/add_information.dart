import 'package:flutter/material.dart';
import 'package:gp/modules/register/register_screen.dart';
import 'package:gp/shared/componants/componants.dart';

class AddInformation extends StatefulWidget {
  @override
  State<AddInformation> createState() => _AddInformationState();
}
class _AddInformationState extends State<AddInformation>
{
  var weightController = TextEditingController();
  var heightController = TextEditingController();
  var goalWeightController = TextEditingController();


  var formKey = GlobalKey<FormState>();
  bool isMale = true;
  String? goal;
  String? active;
  Color? goalColor1 = Colors.white;
  Color? goalColor2 = Colors.white;
  Color? goalColor3 = Colors.white;

  Color? activeColor1 = Colors.white;
  Color? activeColor2 = Colors.white;
  Color? activeColor3 = Colors.white;
  Color? activeColor4 = Colors.white;

  @override
  Widget build(BuildContext context)
  {

    return Scaffold(
      appBar: buildAppBar(
          title: 'Add Information',
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
                      child: defaultGesterDetecter(
                        onTap: ()
                        {
                          setState(() {
                            isMale = true;
                          });
                        },
                        child: defaultContainer(
                          color: isMale ? Colors.blue : Colors.white ,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:
                            [
                              Image(
                                image: AssetImage('images/male-gender-icon-14.jpg'),
                                height: 90,
                                width: 90,
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              defaultHeadLineText(
                                  context,
                                  text: 'Male',
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
                      child: defaultGesterDetecter(
                        onTap: ()
                        {
                          setState(() {
                            isMale = false;
                          });
                        },
                        child: defaultContainer(
                          color: !isMale ? Colors.blue : Colors.white ,

                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:
                            [
                              Image(
                                image: AssetImage('images/220px-Venus_symbol.svg.png'),
                                height: 90,
                                width: 90,
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              defaultHeadLineText(
                                context,
                                text: 'Female',
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
                    text: 'Your Goal',
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children:
                  [
                    Expanded(
                      child: InkWell(
                        onTap: ()
                        {
                          setState(() {
                            goalColor1 = Colors.blue;
                            goal = 'Loss';
                            print(goal..toString());

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
                ),
                SizedBox(
                  height: 15,
                ),
                defaultHeadLineText(
                  context,
                  text: 'Active Level',
                ),
                SizedBox(
                  height: 5,
                ),
                InkWell(
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
                      print(active..toString());

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
                ),


                   Container(
                     color: Colors.white,
                     child: defaultTextFormField(
                      controller: weightController,
                      type: TextInputType.number,
                      validate: (String? value)
                      {
                        if(value!.isEmpty)
                        {
                          return 'please enter your Weight';
                        }
                      },
                      label: 'Weight',
                      border: OutlineInputBorder(),
                      hintText: 'Weight into Kg',

                  ),
                   ),

                SizedBox(
                  height: 20,
                ),
                 Container(
                   color: Colors.white,
                   child: defaultTextFormField(
                      controller: heightController,
                      type: TextInputType.number,
                      validate: (String? value)
                      {
                        if(value!.isEmpty)
                        {
                          return 'please enter your Height';
                        }
                      },
                      label: 'Height',
                     border: OutlineInputBorder(),
                      hintText: 'Height into cm',

                    ),
                 ),

                SizedBox(
                  height: 20,
                ),
                 Container(
                   color: Colors.white,
                   child: defaultTextFormField(
                      controller: goalWeightController,
                      type: TextInputType.number,
                      validate: (String? value)
                      {
                        if(value!.isEmpty)
                        {
                          return 'please enter Goal Weight';
                        }
                      },
                      label: 'Goal Weight',
                     border: OutlineInputBorder(),
                      hintText: 'Goal Weight into Kg',
                    ),
                 ),

                SizedBox(
                  height: 20,
                ),
                defaultButton(
                  context,
                  text: 'Register Now ',
                  onPreesed: ()
                    {
                      if(formKey.currentState!.validate())
                      {
                        navigateTo(context, RegisterScreen(
                          weight: double.parse(weightController.text),
                          height: double.parse(heightController.text),
                          gender: isMale ? 'Male' : 'Female',
                          goalWeight: double.parse(goalWeightController.text),
                          goal: goal,
                          active: active,
                        )

                        );

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
