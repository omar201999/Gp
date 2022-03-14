import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:gp/layout/home-layout/cubit/cubit.dart';
import 'package:gp/shared/componants/componants.dart';
import 'package:gp/shared/styles/icon_broken.dart';

class RecipeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
              [
                defaultContainer(
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: defaultTextFormField(
                      type: TextInputType.text,
                      prefix: IconBroken.Search,
                      border: InputBorder.none,
                      hintText: 'Search'
                    ),
                  ),
                ),
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
                        condition: HomeCubit.get(context).breakfastRecipe.length > 0,
                        builder: (context) => ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder:(context,index) => buildRecipeItem(HomeCubit.get(context).breakfastRecipe[index],context),
                          separatorBuilder: (context,index) =>  SizedBox(width: 10,),
                          itemCount: HomeCubit.get(context).breakfastRecipe.length ,
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
                        condition: HomeCubit.get(context).lunchRecipe.length > 0,
                        builder: (context) => ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemBuilder:(context,index) => buildRecipeItem(HomeCubit.get(context).lunchRecipe[index],context),
                            separatorBuilder: (context,index) =>  SizedBox(width: 10,),
                            itemCount: HomeCubit.get(context).lunchRecipe.length  ),
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
                        condition: HomeCubit.get(context).dinnerRecipe.length > 0,
                        builder: (context) => ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder:(context,index) => buildRecipeItem(HomeCubit.get(context).dinnerRecipe[index],context),
                          separatorBuilder: (context,index) =>  SizedBox(width: 10,),
                          itemCount: HomeCubit.get(context).dinnerRecipe.length,
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