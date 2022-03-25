import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/layout/home-layout/cubit/cubit.dart';
import 'package:gp/layout/home-layout/cubit/states.dart';
import 'package:gp/shared/componants/componants.dart';
import 'package:gp/shared/styles/icon_broken.dart';

class WaterTrackerScreen extends StatefulWidget {
  @override
  State<WaterTrackerScreen> createState() => _WaterTrackerScreenState();
}


class _WaterTrackerScreenState extends State<WaterTrackerScreen> {

  @override
  Widget build(BuildContext context) {

    double countLiter = HomeCubit.get(context).countLiter;
    int counter = HomeCubit.get(context).counter;

    return BlocConsumer<HomeCubit, HomeStates>(
            builder: (context, state) {
              return Scaffold(
                appBar: buildAppBar(
                  title: 'Water Tracker',
                  onPressed: () {
                    Navigator.pop(context);
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
                      Text(
                        '$countLiter''L',
                        style: TextStyle(
                          fontSize: 22,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          /*RawMaterialButton(
                            shape:const CircleBorder(),
                            elevation: 1.0,
                            //fillColor: Colors.grey[300],
                            fillColor: defaultColor,
                            child: const Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 16.0,
                            ),
                            onPressed: (){
                              setState(() {
                                HomeCubit.get(context).addWaterGlass();
                                HomeCubit.get(context).addCountLiter();
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
