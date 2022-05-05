import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glass/glass.dart';
import 'package:gp/layout/home-layout/cubit/cubit.dart';
import 'package:gp/layout/home-layout/cubit/states.dart';
import 'package:gp/models/recipes_model.dart';
import 'package:gp/shared/componants/componants.dart';
import 'package:gp/shared/styles/colors.dart';
import 'package:gp/shared/styles/icon_broken.dart';
class RecipeItemScreen extends StatelessWidget {

  RecipeModel recipeModel;
  RecipeItemScreen({
   required this.recipeModel,
});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
    listener: (context,state){},
      builder: (context,state)
      {
        return Scaffold(
          //backgroundColor: Colors.grey[50],
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children:
              [
                Stack(
                  children:
                  [
                    Container(
                      width: double.infinity,
                      height: 350,
                      decoration:  BoxDecoration(
                        image: DecorationImage(
                          image:NetworkImage('${recipeModel.image}'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(
                          top: 30,
                         start: 5,
                      ),
                      child: Container(
                        height: 40,
                        width: 40,
                        child: IconButton(
                          color: defaultColor,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon( IconBroken.Arrow___Left_2, ),
                        ),
                      ).asGlass(
                        tintColor: Colors.transparent,
                        clipBorderRadius: BorderRadius.circular(50.0),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:
                    [
                      defaultContainer(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              defaultHeadLineText(
                                  context,
                                  text: '${recipeModel.title}',
                                  maxLines: 2
                              ),
                            ],
                          ),
                        ),
                        width: double.infinity,
                        height: 100,
                      ),
                      const SizedBox(height: 15,),

                      defaultContainer(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              defaultHeadLineText(
                                  context, text: 'Nutrition Per Serving'),
                              const SizedBox(height: 5,),
                              Row(
                                children: [
                                  Expanded(
                                    child: CircleAvatar(
                                      backgroundColor: defaultColor,
                                      radius: 40,
                                      child: CircleAvatar(
                                        radius: 35,
                                        backgroundColor: Colors.white,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment
                                              .center,
                                          children:
                                          [
                                            defaultBodyText(context, text: '${recipeModel.calories}',
                                                fontWeight: FontWeight.bold),
                                            defaultBodyText(context, text: 'Cal',
                                                color: Colors.grey),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  afterTitleOfRecipeItem(context, //percentage: '17%',
                                      numberOfGrams: '${recipeModel.carbs}',
                                      nameOfType: 'Carbs',
                                      color: Colors.grey),
                                  afterTitleOfRecipeItem(context, //percentage: '5%',
                                      numberOfGrams: '${recipeModel.protein}',
                                      nameOfType: 'Proteins',
                                      color: Colors.red),
                                  afterTitleOfRecipeItem(context, //percentage: '2%',
                                      numberOfGrams: '${recipeModel.fats}',
                                      nameOfType: 'Fats',
                                      color: defaultColor),

                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),


                      defaultContainer(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                defaultHeadLineText(context, text: 'Ingredients'),
                                const SizedBox(height: 5,),
                                ListView.separated(
                                    padding: const EdgeInsetsDirectional.only(
                                        top: 5,
                                        start: 5
                                    ),
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) =>
                                        defaultBodyText(context,
                                            text: '${recipeModel.ingredients}'
                                        ),
                                    separatorBuilder: (context, index) =>
                                    const SizedBox(height: 5,),
                                    itemCount: 1
                                ),
                              ],
                            ),
                          )
                      ),

                      const SizedBox(
                        height: 15,
                      ),

                      defaultContainer(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                defaultHeadLineText(context, text: 'Directions'),
                                const SizedBox(height: 5,),
                                ListView.separated(
                                    padding: const EdgeInsetsDirectional.only(
                                        top: 5,
                                        start: 5
                                    ),
                                    physics: const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) =>
                                        defaultBodyText(context,
                                          text: '${recipeModel.directions}',
                                        ),
                                    separatorBuilder: (context, index) =>
                                    const SizedBox(height: 5,),
                                    itemCount: 1
                                ),
                              ],
                            ),
                          )
                      ),

                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton.extended(
              foregroundColor: Colors.white,
              onPressed: ()
              {
              if(HomeCubit.get(context).calculateTotalFoodCalories()! >= (HomeCubit.get(context).userModel!.totalCalorie)!.round() )
              {
              showToast(text: 'Please reduce Your Meal your goal is ${HomeCubit.get(context).userModel!.totalCalorie} and your total food is ${HomeCubit.get(context).totalFood} ', state: ToastStates.SUCCESS);
              }
              else
              {
                HomeCubit.get(context).addRecipeToMeals(
                  title: recipeModel.title,
                    calories: (recipeModel.calories)!.round(),
                    carbs: (recipeModel.carbs)!.round(),
                    fat: (recipeModel.fats)!.round(),
                    protein: (recipeModel.protein)!.round(),
                  );
              }
              },
              label: Text('Add to yours Meal'),

            ),


        );
      },
    );
  }
}
