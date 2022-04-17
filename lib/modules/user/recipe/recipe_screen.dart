import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/layout/admin_layout/cubit/cubit.dart';
import 'package:gp/layout/admin_layout/cubit/states.dart';
import 'package:gp/modules/user/search_recipe_screen/search_screen.dart';
import 'package:gp/shared/componants/componants.dart';
import 'package:gp/shared/styles/icon_broken.dart';

class RecipeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<AdminCubit,AdminStates>(
      listener: (context,state)
      {

      },
    builder: (context,state)
    {
     return Scaffold(
       appBar: buildAppBar(
           title: 'Recipe ',
           actions:
           [
             IconButton(
               onPressed:()
               {
                 navigateTo(context,SearchRecipeScreen());
               },
               icon: Icon(
                 IconBroken.Search,
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

                 /*
                  SizedBox(
                    height: 65,
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                          hintText: 'Search',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(15.0),
                              ),
                              borderSide: BorderSide.none
                          ),
                          prefixIcon: Icon(IconBroken.Search),
                          filled: true,
                          fillColor: constantColor5
                      ),
                    ),
                  ),
*/
                 const SizedBox(
                   height: 20.0,
                 ),
                 Column(
                   children: [
                     Row(
                       children: [
                         //headOfRecipeItem(context,head: 'Snacks'),
                         defaultHeadLineText(
                           context,
                           text: 'Breakfast',
                         ),

                       ],
                     ),
                     const SizedBox(
                       height: 10.0,
                     ),
                     Container(
                       height: 280,
                       child: ConditionalBuilder(
                         condition: AdminCubit.get(context).breakfastRecipe.isNotEmpty && state is !GetAllBreakFastRecipeLoadingState,
                         builder: (context) => ListView.separated(
                           scrollDirection: Axis.horizontal,
                           itemBuilder:(context,index) => buildRecipeItem(AdminCubit.get(context).breakfastRecipe[index],context),
                           separatorBuilder: (context,index) =>  SizedBox(width: 10,),
                           itemCount: AdminCubit.get(context).breakfastRecipe.length ,
                         ),
                         fallback: (context) => Center(child: CircularProgressIndicator()),
                       ),
                     ),
                   ],
                 ),
                 const SizedBox(
                   height: 10.0,
                 ),
                 Column(
                   children: [
                     Row(
                       children: [
                         //headOfRecipeItem(context,head: 'Snacks'),
                         defaultHeadLineText(
                           context,
                           text: 'Lunch',
                         ),

                       ],
                     ),
                     Container(
                       height: 280,
                       child: ConditionalBuilder(
                         condition:AdminCubit.get(context).lunchRecipe.length > 0 && state is !GetAllLunchRecipeLoadingState,
                         builder: (context) => ListView.separated(
                             scrollDirection: Axis.horizontal,
                             itemBuilder:(context,index) => buildRecipeItem(AdminCubit.get(context).lunchRecipe[index],context),
                             separatorBuilder: (context,index) =>  SizedBox(width: 10,),
                             itemCount: AdminCubit.get(context).lunchRecipe.length  ),
                         fallback: (context) => Center(child: CircularProgressIndicator()),
                       ),
                     ),
                   ],
                 ),
                 const SizedBox(
                   height: 10.0,
                 ),
                 Column(
                   children: [
                     Row(
                       children: [
                         //headOfRecipeItem(context,head: 'Snacks'),
                         defaultHeadLineText(
                           context,
                           text: 'Dinner',
                         ),

                       ],
                     ),
                     Container(
                       height: 280,
                       child: ConditionalBuilder(
                         condition: AdminCubit.get(context).dinnerRecipe.isNotEmpty && state is !GetAllDinnerRecipeLoadingState,
                         builder: (context) => ListView.separated(
                           scrollDirection: Axis.horizontal,
                           itemBuilder:(context,index) => buildRecipeItem(AdminCubit.get(context).dinnerRecipe[index],context),
                           separatorBuilder: (context,index) =>  SizedBox(width: 10,),
                           itemCount: AdminCubit.get(context).dinnerRecipe.length,
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
    },
    );
  }

}