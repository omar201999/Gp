import 'dart:io';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/layout/home-layout/cubit/cubit.dart';
import 'package:gp/layout/home-layout/cubit/states.dart';
import 'package:gp/shared/componants/componants.dart';
import 'package:gp/shared/componants/constant.dart';
import 'package:gp/shared/localization/app_localization%20.dart';
import 'package:gp/shared/styles/icon_broken.dart';

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
          condition: HomeCubit.get(context).searchPredictedMeal.isNotEmpty,
         builder: (context) => Scaffold(
           body: SingleChildScrollView(
             child: Container(
               child: Column(
                 children: [
                   Stack(
                     children: [
                       Image(
                         image: FileImage(image),
                         width: double.infinity,
                       ),
                       Padding(
                         padding: const EdgeInsetsDirectional.only(
                             top: 30
                         ),
                         child: IconButton(
                           color: Colors.white,
                           onPressed: () {
                             Navigator.pop(context);
                           },
                           icon: const Icon( IconBroken.Arrow___Left_2 ),
                         ),
                       ),
                     ],
                   ),
                   Padding(
                     padding: const EdgeInsets.all(16.0),
                     child: defaultContainer(
                       context,
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           if(lan=='en')
                             Padding(
                             padding: const EdgeInsets.all(10.0),
                             child: defaultHeadLineText(
                               context,
                               text: '${HomeCubit.get(context).searchPredictedMeal[0].Food}',
                               fontSize: 30
                             ),
                           ),
                           if(lan=='ar')
                             Padding(
                               padding: const EdgeInsets.all(10.0),
                               child: defaultHeadLineText(
                                   context,
                                   text: '${HomeCubit.get(context).searchPredictedMeal[0].foodAr}',
                                   fontSize: 30
                               ),
                             ),
                         ],
                       ),
                     ),
                   ),
                   Padding(
                     padding: const EdgeInsets.symmetric(horizontal: 16),
                     child: defaultContainer(
                       context,
                       child: Padding(
                         padding: const EdgeInsets.all(10.0),
                         child: Expanded(
                           child: Row(
                             children: [
                               Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                   defaultHeadLineText(
                                     context,
                                     text:'${AppLocalizations.of(context).translate("Protein")} : ${HomeCubit.get(context).searchPredictedMeal[0].Protein}',
                                     fontWeight: FontWeight.w900
                                   ),
                                   SizedBox(
                                     height: 10,
                                   ),
                                   defaultHeadLineText(
                                     context,
                                     text:'${AppLocalizations.of(context).translate("cal")} : ${HomeCubit.get(context).searchPredictedMeal[0].Calories}',
                                       fontWeight: FontWeight.w900
                                   ),
                                   SizedBox(
                                     height: 10,
                                   ),
                                   defaultHeadLineText(
                                     context,
                                     text:'${AppLocalizations.of(context).translate("Carbs")} : ${HomeCubit.get(context).searchPredictedMeal[0].Carbs}',
                                       fontWeight: FontWeight.w900
                                   ),
                                   SizedBox(
                                     height: 10,
                                   ),
                                   defaultHeadLineText(
                                     context,
                                     text:'${AppLocalizations.of(context).translate("Fats")} : ${HomeCubit.get(context).searchPredictedMeal[0].Fat}',
                                       fontWeight: FontWeight.w900
                                   ),
                                 ],
                               )
                             ],
                           ),
                         ),
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
