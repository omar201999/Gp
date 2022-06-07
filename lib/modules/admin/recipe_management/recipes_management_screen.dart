import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glass/glass.dart';
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
                  /*const SizedBox(
                    height: 20.0,
                  ),*/
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
                        height: 270,
                        //color: Colors.grey[50],
                        child: ConditionalBuilder(
                          condition: AdminCubit.get(context).breakfastRecipe.isNotEmpty && state is !GetAllBreakFastRecipeLoadingState,
                          builder: (context) => ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemBuilder:(context,index) => buildRecipe(AdminCubit.get(context).breakfastRecipe[index],context ),
                            separatorBuilder: (context,index) =>  const SizedBox(width: 10,),
                            itemCount: 4
                            //AdminCubit.get(context).breakfastRecipe.length ,
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

                        height: 270,
                        //color: Colors.grey[50],
                        child: ConditionalBuilder(
                          condition: AdminCubit.get(context).lunchRecipe.length > 0 && state is !GetAllLunchRecipeLoadingState,
                          builder: (context) => ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemBuilder:(context,index) => buildRecipe(AdminCubit.get(context).lunchRecipe[index],context),
                              separatorBuilder: (context,index) =>  SizedBox(width: 10,),
                              itemCount: 4
                          ),
                              // AdminCubit.get(context).lunchRecipe.length  ),
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
                        height: 270,
                        //color: Colors.grey[50],
                        child: ConditionalBuilder(
                          condition: AdminCubit.get(context).dinnerRecipe.isNotEmpty && state is !GetAllDinnerRecipeLoadingState ,
                          builder: (context) => ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemBuilder:(context,index) => buildRecipe(AdminCubit.get(context).dinnerRecipe[index],context),
                            separatorBuilder: (context,index) =>  const SizedBox(width: 10,),
                            itemCount: 4
                            //AdminCubit.get(context).dinnerRecipe.length,
                          ),
                          fallback: (context) => const Center(child: CircularProgressIndicator()),
                        ),
                      ),
                    ],
                  ),
                  /*const SizedBox(
                    height: 10.0,
                  ),*/

                ],
              ),
            ),

        );
      },
    );
  }

}

Widget buildRecipe(RecipeModel model,context ) => defaultGestureDetector(
  onTap: ()
  {
    navigateTo(context, EditRecipeScreen(recipeModel: model,));
  },
    child: Container(
      //constraints: const BoxConstraints.expand(),
      decoration: BoxDecoration (
        borderRadius: BorderRadius.circular(15.0),
        image: DecorationImage (
            image: NetworkImage('${model.image}'),
            fit: BoxFit.cover
        ),
      ),
      height: 200,
      width: 230,
      child: Padding(
        padding: const EdgeInsetsDirectional.only(
          top: 140,
          start: 10,
          end: 10,
          bottom: 15,
        ),
        child: Container(
          color: Colors.black38.withOpacity(0.30),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      '${model.title}',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0,
                          color: Colors.white
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: [
                      Text(
                        '${model.calories} Calories',
                        style: const TextStyle(
                          //fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 12.0,
                        ),
                      ),
                      Spacer(),
                      Icon(
                        IconBroken.Star,
                        size: 20,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        '${(model.averageRating)!.ceilToDouble()}',
                        style: const TextStyle(
                          //fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 12.0,
                        ),
                      ),
                    ],
                  )
                ]
            ),
          ),
        ).asGlass(
          tintColor: Colors.transparent,
          clipBorderRadius: BorderRadius.circular(20.0),
        ),
      ),
    )
);