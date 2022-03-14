import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gp/shared/componants/componants.dart';
import 'package:gp/shared/componants/constant.dart';
import 'package:gp/shared/styles/colors.dart';
import 'package:iconsax/iconsax.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
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
                        color: constantColor1,
                        height: 128,
                        width: 140,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(Iconsax.presention_chart),
                              const SizedBox(
                                height: 5.0,
                              ),
                              const Text(
                                'Sales Last Week',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black45
                                ),
                              ),
                              defaultHeadLineText(context, text: '\$8200.99')
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
                        color: constantColor1,
                        height: 128,
                        width: 160,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(Iconsax.chart),
                              const SizedBox(
                                height: 5.0,
                              ),
                              const Text(
                                'Revenue Last Week',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black45
                                ),
                              ),
                              defaultHeadLineText(context, text: '\$8200.99')
                            ],
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: defaultContainer(
                    height: 180,
                    color: constantColor1,
                    child: Column(
                      mainAxisAlignment:  MainAxisAlignment.center,
                      children: [
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 96.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(
                                child: Container(
                                  height: 25,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.0),
                                    color: defaultColor,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 15.0,
                              ),
                              Expanded(
                                child: Container(
                                  height: 35,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.0),
                                    color: defaultColor,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 15.0,
                              ),
                              Expanded(
                                child: Container(
                                  height: 45,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.0),
                                    color: defaultColor,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 15.0,
                              ),
                              Expanded(
                                child: Container(
                                  height: 35,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.0),
                                    color: defaultColor,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 15.0,
                              ),
                              Expanded(
                                child: Container(
                                  height: 25,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.0),
                                    color: defaultColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 95.0),
                            child: Row(
                              children: const [
                                Expanded(
                                    child: Text(
                                      '20',
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: defaultColor
                                      ),
                                    ),
                                ),
                                SizedBox(
                                  width: 15.0,
                                ),
                                Expanded(
                                  child: Text(
                                    '40',
                                    style: TextStyle(
                                        fontSize: 10,
                                        color: defaultColor
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 15.0,
                                ),
                                Expanded(
                                  child: Text(
                                    '60',
                                    style: TextStyle(
                                        fontSize: 10,
                                        color: defaultColor
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 15.0,
                                ),
                                Expanded(
                                  child: Text(
                                    '40',
                                    style: TextStyle(
                                        fontSize: 10,
                                        color: defaultColor
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 15.0,
                                ),
                                Expanded(
                                  child: Text(
                                    '20',
                                    style: TextStyle(
                                        fontSize: 10,
                                        color: defaultColor
                                    ),
                                  ),
                                ),

                              ],
                            ),
                        ),
                        defaultHeadLineText(context, text: 'Activity'),
                        const Text(
                          'of Current Week',
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.black45
                          ),
                        ),

                      ],
                    ),
                  ),
              ),
            ],
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
                    defaultHeadLineText(
                        context,
                        text: 'Analytics'
                    ),
                    const Spacer(),
                    defaultTextButton(
                      text: 'See All',
                      function: () {  },
                    ),
                  ],
                ),
              ),
              Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                elevation: 8.0,
                margin: const EdgeInsets.all(8.0),
                child: Container(
                  width: double.infinity,
                  color: const Color(0xFFF6F7FB),
                  child:  const Image(
                    image: AssetImage('assets/images/10.jpeg'),
                    fit: BoxFit.cover,
                    height: 200,
                  ),
                  padding: const EdgeInsets.all(8.0),
                ),
              ),
              SizedBox(
                height:10,
              ),
              defaultButton(
                context,
                onPreesed: ()
                {
                  signOut(context);
                },
                text: 'Sing Out',
                textStyle: Theme.of(context).textTheme.headline1!.copyWith(
                    color: Colors.white
                ),
              ),
            ],
          ),
        ],

      ),
    );

  }

}