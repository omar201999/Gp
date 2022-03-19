import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:gp/layout/home-layout/cubit/cubit.dart';
import 'package:gp/shared/componants/componants.dart';

class MarketingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: buildAppBar(
          title: 'Marketing ',
          actions:
          [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search,
              ),
            ),
          ]
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
              [


                const SizedBox(
                  height: 5.0,
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        defaultHeadLineText(
                          context,
                          text: 'Category 1',
                        ),

                      ],
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      height: 280,
                      child: ConditionalBuilder(
                        condition: HomeCubit.get(context).products.length > 0,
                        builder: (context) => ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder:(context,index) => buildmarket_item(HomeCubit.get(context).products[index],context),
                          separatorBuilder: (context,index) =>  SizedBox(width: 10,),
                          itemCount: HomeCubit.get(context).products.length ,
                        ),
                        fallback: (context) => Center(child: CircularProgressIndicator()),
                      ),
                    ),
                  ],
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

}