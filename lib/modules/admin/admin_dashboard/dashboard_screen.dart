import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/layout/admin_layout/cubit/cubit.dart';
import 'package:gp/layout/admin_layout/cubit/states.dart';
import 'package:gp/modules/admin/admin_dashboard/analysis_screen.dart';
import 'package:gp/shared/componants/componants.dart';
import 'package:gp/shared/styles/icon_broken.dart';
import 'package:iconsax/iconsax.dart';
import 'package:fl_chart/fl_chart.dart';

/*
class DashboardScreen extends StatefulWidget {
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}
*/

class DashboardScreen extends StatelessWidget {


  //int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {


    return BlocConsumer<AdminCubit, AdminStates>(
        builder: (context, state) {
          return ConditionalBuilder(
              condition: state is! GetStockProductsLoadingState ,
              builder: (context) => SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  //crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: defaultContainer(
                                  context,
                                  //color: constantColor1,
                                  height: 150,
                                  width: 140,
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [
                                        const Icon(Iconsax.shop),
                                        const SizedBox(
                                          height: 5.0,
                                        ),
                                        const Text(
                                          'Main Products in Stock',
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.black45
                                          ),
                                        ),
                                        defaultHeadLineText(
                                            context, text: '${AdminCubit.get(context).stockProducts.length}')
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 15.0,
                              ),
                              Expanded(
                                child: defaultContainer(
                                  context,

                                  //color: constantColor1,
                                  height: 150,
                                  width: 140,
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [
                                        const Icon(IconBroken.Close_Square),
                                        const SizedBox(
                                          height: 5.0,
                                        ),
                                        const Text(
                                          'Main Products Not in Stock',
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.black45,
                                          ),
                                        ),
                                        defaultHeadLineText(
                                            context,
                                            text: '${AdminCubit.get(context).products.length - AdminCubit.get(context).stockProducts.length}'
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 20.0,
                              left: 20,
                              right: 20
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: defaultContainer(
                                  context,
                                  //color: constantColor1,
                                  height: 150,
                                  width: 140,
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [
                                        const Icon(IconBroken.Tick_Square),
                                        const SizedBox(
                                          height: 5.0,
                                        ),
                                         const Text(
                                          'All Confirmed Orders ',
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.black45
                                          ),
                                        ),
                                        defaultHeadLineText(
                                            context, text: '${AdminCubit.get(context).confirmedOrders.length}')
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 15.0,
                              ),
                              Expanded(
                                child: defaultContainer(
                                  context,

                                  //color: constantColor1,
                                  height: 150,
                                  width: 140,
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Icon(IconBroken.User),
                                        const SizedBox(
                                          height: 3.0,
                                        ),
                                        const Text(
                                          'Users of Application',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black45,
                                          ),
                                        ),
                                        defaultHeadLineText(
                                            context,
                                            text: '${AdminCubit.get(context).users.length}'
                                        )
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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: defaultContainer(
                          context,
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: defaultHeadLineText(context, text: 'Average Ratings and reviews is ${AdminCubit.get(context).averageRate().toStringAsFixed(1)}',maxLines: 2),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Expanded(
                            child: defaultContainer(
                              context,
                              //color: constantColor1,
                              height: 170,
                             // width: 140,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment
                                      .start,
                                  children: [
                                    const SizedBox(
                                      height: 5.0,
                                    ),
                                     Expanded(
                                       child: Text(
                                        'Users That Achieve Their Goal is ${AdminCubit.get(context).yesAchievement()}',
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black45
                                        ),
                                    ),
                                     ),
                                    defaultHeadLineText(
                                        context,
                                        text: '${((AdminCubit.get(context).yesAchievement() / AdminCubit.get(context).feedback.length) * 100).toStringAsFixed(2)} %'
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: defaultContainer(
                              context,

                              //color: constantColor1,
                              height: 170,
                              //width: 140,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment
                                      .start,
                                  children: [

                                    const SizedBox(
                                      height: 5.0,
                                    ),
                                     Expanded(
                                       child: Text(
                                        'Users That Partially Achieve Their Goal is ${AdminCubit.get(context).partiallyAchievement()}',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black45,
                                        ),
                                    ),
                                     ),
                                    defaultHeadLineText(
                                        context,
                                        text: '${((AdminCubit.get(context).partiallyAchievement() / AdminCubit.get(context).feedback.length) * 100).toStringAsFixed(2)} %'

                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: defaultContainer(
                        context,

                        //color: constantColor1,
                        height: 100,
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment
                                .start,
                            children: [

                              const SizedBox(
                                height: 5.0,
                              ),
                              Expanded(
                                child: Text(
                                  'Users that No Achieve Their Goal is ${AdminCubit.get(context).noAchievement()}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black45,
                                  ),
                                ),
                              ),
                              defaultHeadLineText(
                                  context,
                                  text: '${((AdminCubit.get(context).noAchievement() / AdminCubit.get(context).feedback.length) * 100).toStringAsFixed(2)} %'
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15.0,
                          ),
                          child: InkWell(
                            onTap: () {
                              navigateTo(context, Analysis());
                            },
                            child: defaultContainer(
                              context,
                              height: 50,
                              child: Row(
                                children: [
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  defaultHeadLineText(
                                      context,
                                      text: 'Analysis Charts'
                                  ),
                                  const Spacer(),
                                  const Icon(IconBroken.Arrow___Right_2),
                                  const SizedBox(
                                    width: 5.0,
                                  )
                                ],
                              ),
                            ),
                          )
                        ),
                    const SizedBox(
                      height: 15.0,
                    )
                  ],
                ),
              ),
              fallback: (context) => const Center(child: CircularProgressIndicator())
          );
        },
        listener: (context, state) {}

    );
  }


}