import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/layout/home-layout/cubit/cubit.dart';
import 'package:gp/layout/home-layout/cubit/states.dart';
import 'package:gp/models/user_model.dart';
import 'package:gp/shared/componants/componants.dart';
import 'package:gp/shared/styles/colors.dart';

import '../edit_profile/edit_profile_screen.dart';

class CustomerDashBoardScreen extends StatelessWidget {


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
                Container(
                  color: Colors.grey[200],
                  child: Column(
                    children: [
                      Container(
                        height: 220,
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            Align(
                              alignment: Alignment.topCenter,
                              child: Image(
                                fit: BoxFit.cover,
                                height: 180,
                                width: double.infinity,
                                image: NetworkImage('https://img.freepik.com/free-photo/vegetables-set-left-black-slate_1220-685.jpg?w=1380'),
                              ),
                            ),
                            CircleAvatar(
                              radius: 52,
                              backgroundColor: Colors.white,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 2),
                              child: CircleAvatar(
                                backgroundImage: NetworkImage('${userModel?.profileImage}'),
                                radius: 50,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Column(
                        children: [
                          defaultHeadLineText(context, text: '${userModel?.name}'),
                          SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: defaultContainer(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                defaultHeadLineText(context, text: 'Goal Weight',color: defaultColor),
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
                                        text: 'add weight',
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
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                defaultHeadLineText(context, text: 'Goal',color: defaultColor),
                                SizedBox(height: 20,),
                                secondPart(
                                    context,
                                    subHeadLine: 'Current Weight' ,
                                    subHeadLine2: '${userModel.weight}',
                                    caption: 'Gain ${userModel.weeklyGoal} kg per week'
                                ),
                                SizedBox(height: 20,),
                                secondPart(
                                    context,
                                    subHeadLine: 'Daily Calories' ,
                                    subHeadLine2: '${userModel.totalCalorie}g' ,
                                    caption: 'Carbs ${userModel.totalCarbs}g , fat ${userModel.totalFats}g , protein ${userModel.totalProtein}g'
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),

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