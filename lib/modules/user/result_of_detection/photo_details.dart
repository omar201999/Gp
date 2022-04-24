import 'dart:io';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/layout/home-layout/cubit/cubit.dart';
import 'package:gp/layout/home-layout/cubit/states.dart';

class PhotoDetails extends StatelessWidget
{
   final File image;
   PhotoDetails({
     required this.image,
   });


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
      listener: (context,state){},
      builder: (context,state)
      {
        print(HomeCubit.get(context).searchPredictedMeal);
        return ConditionalBuilder(
          condition: HomeCubit.get(context).searchPredictedMeal.length > 0,
         builder: (context) => Scaffold(
           body: SingleChildScrollView(
             child: Container(
               child: Column(
                 children: [
                   Image(
                     image: FileImage(image) as ImageProvider,
                     width: double.infinity,
                   ),
                   Padding(
                     padding: const EdgeInsets.all(20.0),
                     child: Container(
                       child: Row(
                         children: [
                           Padding(
                             padding: const EdgeInsets.all(10.0),
                             child: Text(
                               '${HomeCubit.get(context).searchPredictedMeal[0].Food}',
                               style: TextStyle(
                                   color: Colors.teal,
                                   fontSize: 30
                               ),
                             ),
                           ),
                         ],
                       ),
                       decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(10),
                         color: Colors.white,
                       ),
                     ),
                   ),
                   Padding(
                     padding: const EdgeInsets.symmetric(horizontal: 20),
                     child: Container(
                       child: Padding(
                         padding: const EdgeInsets.all(10.0),
                         child: Expanded(
                           child: Row(
                             children: [
                               Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                   Text(
                                     'Protein is ${HomeCubit.get(context).searchPredictedMeal[0].Protein}',
                                     style: TextStyle(
                                         fontSize: 20
                                     ),
                                   ),
                                   SizedBox(
                                     height: 10,
                                   ),
                                   Text(
                                     'Calories is ${HomeCubit.get(context).searchPredictedMeal[0].Calories}',
                                     style: TextStyle(
                                         fontSize: 20
                                     ),
                                   ),
                                   SizedBox(
                                     height: 10,
                                   ),
                                   Text(
                                     'Carbs is ${HomeCubit.get(context).searchPredictedMeal[0].Carbs}',
                                     style: TextStyle(
                                         fontSize: 20
                                     ),
                                   ),
                                   SizedBox(
                                     height: 10,
                                   ),
                                   Text(
                                     'Fat is ${HomeCubit.get(context).searchPredictedMeal[0].Fat}',
                                     style: TextStyle(
                                         fontSize: 20
                                     ),
                                   ),
                                 ],
                               )
                             ],
                           ),
                         ),
                       ),
                       decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(10),
                         color: Colors.white,
                       ),
                     ),
                   ),
                 ],
               ),
             ),
           ),
         ),
            fallback: (context) => Center(child: CircularProgressIndicator())
        );
      },
    );
  }
}
