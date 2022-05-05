import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/layout/admin_layout/cubit/cubit.dart';
import 'package:gp/layout/admin_layout/cubit/states.dart';
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

    int totalAmount = 0;
    int sumTotalAmountProducts(){
      totalAmount = 0;
      for( int index = 0; index < AdminCubit.get(context).products.length; index++ ){
        totalAmount = totalAmount + (AdminCubit.get(context).products[index].quantity!).toInt();
      }
      return totalAmount;
    }

    List<PieChartSectionData> showingSections() {
      return List.generate(
          AdminCubit.get(context).products.length,
              (index) {
            int totalAmount = sumTotalAmountProducts();
            //final isTouched = index == touchedIndex;
            const fontSize = 16.0;
            const radius = 50.0;
            return buildPieChartItem(
                AdminCubit.get(context).products[index],
                context,
                radius,
                fontSize,
                index,
                totalAmount
            );
          });
    }



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
                            width: 5,
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
                          const SizedBox(
                            width: 5,
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

                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8.0,
                          ),
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 10,
                              ),
                              defaultHeadLineText(
                                  context,
                                  text: 'Analytics'
                              ),
                              const Spacer(),
                              defaultTextButton(
                                context,
                                text: 'See All',
                                isUpper: false,
                                function: () {},
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                          ),
                          child: AspectRatio(
                            aspectRatio: 1.3,
                            child: Card(
                              color: Colors.grey[50],
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
                              vertical: 10,
                              horizontal: 15
                          ),
                          child: Container(
                            color: Colors.grey[50],
                            height: 200,
                            child: ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: AdminCubit.get(context).products.length,
                                itemBuilder: (context, index) => indicator(
                                    color: colors[index],
                                    text: '${AdminCubit.get(context).products[index].name}',
                                    isSquare: true,
                                    secondText: ((AdminCubit.get(context).products[index].quantity!/totalAmount*100).ceil()).toString()+'%',
                                    secondTextColor: colors[index]
                                )
                            ),
                          ),
                        )
                      ],

                    ),
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