import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/layout/admin_layout/cubit/cubit.dart';
import 'package:gp/layout/admin_layout/cubit/states.dart';
import 'package:gp/models/recipes_model.dart';
import 'package:gp/modules/admin/recipe_management/edit_recipe/edit_recipe_screen.dart';
import 'package:gp/modules/admin/recipe_management/new_recipe/new_recipe_screen.dart';
import 'package:gp/shared/componants/componants.dart';
import 'package:gp/shared/styles/icon_broken.dart';

class RecipesManagementScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<AdminCubit,AdminStates>(
      listener: (context,state) {},
      builder: (context,state)
      {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                [
                  /*defaultContainer(

                    height: 50,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: defaultTextFormField(
                        type: TextInputType.text,
                        prefix: IconBroken.Search,
                        hintText: 'Search',
                        border: InputBorder.none,
                      ),
                    ),
                  ),*/

                  /* defaultContainer(
                      height: 65,
                      child: defaultTextFormField(
                        type: TextInputType.text,
                        hintText: 'Search',
                        prefix: IconBroken.Search,
                      ),
                    ),*/
                  const SizedBox(
                    height: 20.0,
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          defaultHeadLineText(
                            context,
                            text: 'Breakfast',
                          ),
                          const Spacer(),
                          IconButton(
                              onPressed: () {
                                navigateTo(context, NewRecipeScreen(
                                  category: 'breakfast',
                                ));
                              },
                              icon:  const Icon(IconBroken.Paper_Upload)
                          )
                        ],
                      ),
                      Container(
                        height: 230,
                        //color: Colors.grey[50],
                        child: ConditionalBuilder(
                          condition: AdminCubit.get(context).breakfastRecipe.isNotEmpty && state is !GetAllBreakFastRecipeLoadingState,
                          builder: (context) => ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemBuilder:(context,index) => buildRecipe(AdminCubit.get(context).breakfastRecipe[index],context, index),
                            separatorBuilder: (context,index) =>  const SizedBox(width: 10,),
                            itemCount: AdminCubit.get(context).breakfastRecipe.length ,
                          ),
                          fallback: (context) => const Center(child: CircularProgressIndicator()),
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
                          defaultHeadLineText(
                            context,
                            text: 'Lunch',
                          ),
                          const Spacer(),
                          IconButton(
                              onPressed: () {
                                navigateTo(context, NewRecipeScreen(
                                  category: 'lunch',

                                ));
                              },
                              icon: const Icon(
                                IconBroken.Paper_Upload,
                                //size: 15,
                              )
                          )
                        ],
                      ),
                      Container(

                        height: 230,
                        //color: Colors.grey[50],
                        child: ConditionalBuilder(
                          condition: AdminCubit.get(context).lunchRecipe.length > 0 && state is !GetAllLunchRecipeLoadingState,
                          builder: (context) => ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemBuilder:(context,index) => buildRecipe(AdminCubit.get(context).lunchRecipe[index],context, index),
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
                          defaultHeadLineText(
                            context,
                            text: 'Dinner',
                          ),
                          const Spacer(),
                          IconButton(
                              onPressed: () {
                                navigateTo(context, NewRecipeScreen(
                                  category: 'dinner',
                                ));
                              },
                              icon: const Icon(IconBroken.Paper_Upload)
                          )
                        ],
                      ),
                      Container(
                        height: 230,
                        //color: Colors.grey[50],
                        child: ConditionalBuilder(
                          condition: AdminCubit.get(context).dinnerRecipe.isNotEmpty && state is !GetAllDinnerRecipeLoadingState ,
                          builder: (context) => ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemBuilder:(context,index) => buildRecipe(AdminCubit.get(context).dinnerRecipe[index],context, index),
                            separatorBuilder: (context,index) =>  const SizedBox(width: 10,),
                            itemCount: AdminCubit.get(context).dinnerRecipe.length,
                          ),
                          fallback: (context) => const Center(child: CircularProgressIndicator()),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),

                ],
              ),
            ),
          ),
        );
      },
    );
  }

}

Widget buildRecipe(RecipeModel model,context, index) => defaultGestureDetector(
  onTap: ()
  {
    navigateTo(context, EditRecipeScreen(recipeModel: model, index: index,));
  },
  child: defaultContainer(
    context,
    height: 170,
    width: 170,
    //color: constantColor5,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
      [
         Expanded(
          flex: 4,
          child: Image(
            image: NetworkImage('${model.image}'),
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
         const SizedBox(
          height: 4,
        ),
         Expanded(
          child: Padding(
            padding: /*EdgeInsetsDirectional.only(
                start: 10,
            ),*/
            const EdgeInsets.symmetric(
              vertical: 2.0,
              horizontal: 6.0,
            ),
            child: Text(
              '${model.title!.toUpperCase()}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontSize: 16
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsetsDirectional.only(
              start: 10,
            ),
            child: Row(
              children:
               [
                Text(
                  '${model.calories!.round()}',
                  style: TextStyle(
                    //letterSpacing: 1,
                    fontSize: 12
                  ),
                ),
                SizedBox(
                  width: 4,
                ),
                Text('cal'),
              ],
            ),
          ),
        ),
      ],
    ),
  ),
);