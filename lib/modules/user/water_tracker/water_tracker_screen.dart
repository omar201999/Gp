import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/layout/home-layout/cubit/cubit.dart';
import 'package:gp/layout/home-layout/cubit/states.dart';
import 'package:gp/models/user_model.dart';
import 'package:gp/shared/componants/componants.dart';
import 'package:gp/shared/localization/app_localization%20.dart';
import 'package:gp/shared/styles/icon_broken.dart';

class WaterTrackerScreen extends StatefulWidget {
  @override
  State<WaterTrackerScreen> createState() => _WaterTrackerScreenState();
}


class _WaterTrackerScreenState extends State<WaterTrackerScreen> {

  @override
  Widget build(BuildContext context) {

    UserModel? userModel = HomeCubit.get(context).userModel;

    double countLiter = HomeCubit.get(context).countLiter;
    int counter = HomeCubit.get(context).counter;

    return BlocConsumer<HomeCubit, HomeStates>(
            builder: (context, state) {
              return Scaffold(
                appBar: buildAppBar(
                  title: AppLocalizations.of(context).translate("Water Tracker"),
                  onPressed: () {
                    Navigator.pop(context);
                    HomeCubit.get(context).updateUser(
                      name: userModel!.name,
                      age: userModel.age,
                      goalWeight: userModel.goalWeight,
                      weight: userModel.weight,
                      totalWater: counter,
                      totalProtein: userModel.totalProtein,
                      totalCalorie: userModel.totalCalorie,
                      totalCarbs: userModel.totalCarbs,
                      totalFats: userModel.totalFats,
                      active: userModel.active,

                    );
                  },
                  icon: IconBroken.Arrow___Left_2,
                  titleSpacing: 5.0,
                ),

                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage('assets/images/glass.png'),
                        width: 125,
                        height: 185,
                      ),
                      defaultBodyText(
                        context,
                        text:
                        '$countLiter''L',
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          defaultRawButton(
                              onPressed: () {
                                setState(() {
                                  HomeCubit.get(context).addWaterGlass();
                                  HomeCubit.get(context).addCountLiter();
                                });

                              },
                              icon: Icons.add
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            '$counter',
                            style: TextStyle(
                                fontSize: 20
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          /*RawMaterialButton(
                            shape:const CircleBorder(),
                            elevation: 1.0,
                            fillColor: defaultColor,
                            child: const Icon(
                              Icons.remove,
                              color: Colors.white,
                              size: 16.0,
                            ),
                            onPressed: (){
                              setState(() {
                                HomeCubit.get(context).minusWaterGlass();
                                HomeCubit.get(context).minusCountLiter();
                              });
                            },
                            constraints: const BoxConstraints.tightFor(
                              width: 30.0,
                              height: 30.0,
                            ),
                          ),*/
                          defaultRawButton(
                              onPressed: () {
                                setState(() {
                                  HomeCubit.get(context).minusWaterGlass();
                                  HomeCubit.get(context).minusCountLiter();
                                });

                              },
                              icon: Icons.remove
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 100,
                      )
                    ],
                  ),
                ),
              );
            },
            listener: (context, state) {}
        );
  }
}
