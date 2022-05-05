import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/layout/admin_layout/cubit/cubit.dart';
import 'package:gp/layout/admin_layout/cubit/states.dart';
import 'package:gp/models/recipes_model.dart';
import 'package:gp/shared/componants/componants.dart';
import 'package:gp/shared/styles/colors.dart';
import 'package:gp/shared/styles/icon_broken.dart';
class EditRecipeScreen extends StatelessWidget {
  var titleController = TextEditingController();
  var ingredientsController = TextEditingController();
  var directionsController = TextEditingController();

  //var categoryController = TextEditingController();
  var carbsController = TextEditingController();
  var fatsController = TextEditingController();
  var proteinController = TextEditingController();
  var calsController = TextEditingController();
  var weightController = TextEditingController();

  RecipeModel recipeModel;
  int index;
  EditRecipeScreen({
    required this.recipeModel,
    required this.index
  });


  @override
  Widget build(BuildContext context) {



   // var recipeModel = AdminCubit.get(context).recipeModel;


    return BlocConsumer<AdminCubit, AdminStates>(
      listener: (context, state) {
        if(state is UpdateRecipeSuccessState || state is UploadNewRecipeImageSuccessState) {
          showToast(
              text: 'Recipe has updated successfully',
              state: ToastStates.SUCCESS
          );
        }
      },
        builder: (context, state) {
          var recipeImage = AdminCubit.get(context).newRecipeImage;
          titleController.text = recipeModel.title!;
          ingredientsController.text = recipeModel.ingredients!;
          directionsController.text = recipeModel.directions!;
          carbsController.text = '${recipeModel.carbs}';
          fatsController.text = '${recipeModel.fats}';
          proteinController.text = '${recipeModel.protein}';
          calsController.text = '${recipeModel.calories}';
          weightController.text = '${recipeModel.weight}';

          return Scaffold(
            //backgroundColor: Colors.grey[200],
            body: SingleChildScrollView(
              child: Column(
                children:
                [
                  Stack(
                    //alignment: AlignmentDirectional.bottomEnd,
                    children:
                    [
                      defaultContainer(
                        context,

                        width: double.infinity,
                        height: 350,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: //AssetImage('assets/images/Recipe1.jpg'),
                            recipeImage == null ? NetworkImage('${recipeModel.image}') : FileImage(recipeImage) as ImageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.only(
                            top: 30
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              color: defaultColor,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon:const Icon( IconBroken.Arrow___Left_2),
                            ),
                            const Spacer(),
                            defaultTextButton(
                              context,
                              //color: Colors.white,
                              function: () {
                                 AdminCubit.get(context).deleteRecipe(AdminCubit.get(context).recipesIds[index]);
                                 Navigator.pop(context);
                              },
                              text : 'Delete',
                            ),
                            const SizedBox(
                              width: 10.0,
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.only(
                            top: 300,
                            start: 340
                        ),
                        child: IconButton(
                            onPressed: () {
                               AdminCubit.get(context).getNewRecipeImage();
                            },
                            icon: const CircleAvatar(
                              radius: 30,
                              child: Icon(
                                IconBroken.Camera,
                                size: 18,
                              ),

                            )
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        defaultContainer(
                          context,

                          height: 65,
                          //color: constantColor5,
                          child: defaultTextFormField(
                            type: TextInputType.text,
                            controller: titleController,
                            prefix: IconBroken.Paper,
                            border: InputBorder.none,
                            label: 'Title',
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),

                        defaultContainer(
                          context,

                          height: 150,
                            //color: constantColor5,
                            child: defaultTextFormField(
                                controller: ingredientsController,
                                type: TextInputType.multiline,
                                maxLines: 30,
                                border: InputBorder.none,
                                label: 'Ingredients',

                              ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        defaultContainer(
                          context,

                          height: 150,
                            //color: constantColor5,
                            child: defaultTextFormField(
                                controller: directionsController,
                                type: TextInputType.multiline,
                                maxLines: 30,
                                border: InputBorder.none,
                                label: 'Directions',
                              ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        defaultContainer(
                          context,

                          height: 65,
                          //color: constantColor5,
                          child: defaultTextFormField(
                            type: TextInputType.number,
                            controller: carbsController,
                            border: InputBorder.none,
                            label: 'Carbs',
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        defaultContainer(
                          context,

                          height: 65,
                          //color: constantColor5,
                          child: defaultTextFormField(
                            type: TextInputType.number,
                            controller: proteinController,
                            border: InputBorder.none,
                            label: 'Protein',
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        defaultContainer(
                          context,

                          height: 65,
                          //color: constantColor5,
                          child: defaultTextFormField(
                            type: TextInputType.number,
                            controller: fatsController,
                            border: InputBorder.none,
                            label: 'Fats',
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        defaultContainer(
                          context,

                          height: 65,
                          //color: constantColor5,
                          child: defaultTextFormField(
                            type: TextInputType.number,
                            controller: calsController,
                            border: InputBorder.none,
                            label: 'Calories',
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        defaultContainer(
                          context,

                          height: 65,
                          //color: constantColor5,
                          child: defaultTextFormField(
                            type: TextInputType.number,
                            controller: weightController,
                            border: InputBorder.none,
                            label: 'Weight',
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        defaultButton(
                          context,
                          onPreesed: () {
                            print(recipeImage);
                            //print(recipeModel.uId);

                            if(recipeImage == null)
                            {
                              if(recipeModel.category == 'breakfast') {
                                AdminCubit.get(context).updateRecipe(
                                  AdminCubit.get(context).breakfastRecID[index],
                                  title: titleController.text,
                                  ingredients: ingredientsController.text,
                                  directions: directionsController.text,
                                  carbs: double.parse(carbsController.text),
                                  protein: double.parse(proteinController.text),
                                  fats: double.parse(fatsController.text),
                                  calories: double.parse(calsController.text),
                                  weight: double.parse(weightController.text),
                                  //uId: recipeModel.uId,
                                  category: recipeModel.category,
                                  newRecipeImage:recipeModel.image,
                                    numOfRates: recipeModel.numOfRates!,
                                    averageRating: recipeModel.averageRating!,
                                    totalRating: recipeModel.totalRating!
                                );
                              } else if(recipeModel.category == 'lunch') {
                                AdminCubit.get(context).updateRecipe(
                                  AdminCubit.get(context).lunchRecID[index],
                                  title: titleController.text,
                                  ingredients: ingredientsController.text,
                                  directions: directionsController.text,
                                  carbs: double.parse(carbsController.text),
                                  protein: double.parse(proteinController.text),
                                  fats: double.parse(fatsController.text),
                                  calories: double.parse(calsController.text),
                                  weight: double.parse(weightController.text),
                                  //uId: recipeModel.uId,
                                  category: recipeModel.category,
                                  newRecipeImage:recipeModel.image,
                                    numOfRates: recipeModel.numOfRates!,
                                    averageRating: recipeModel.averageRating!,
                                    totalRating: recipeModel.totalRating!
                                );
                              } else {
                                  AdminCubit.get(context).updateRecipe(
                                    AdminCubit.get(context).dinnerRecID[index],
                                    title: titleController.text,
                                    ingredients: ingredientsController.text,
                                    directions: directionsController.text,
                                    carbs: double.parse(carbsController.text),
                                    protein: double.parse(proteinController.text),
                                    fats: double.parse(fatsController.text),
                                    calories: double.parse(calsController.text),
                                    weight: double.parse(weightController.text),
                                    //uId: recipeModel.uId,
                                    category: recipeModel.category,
                                    newRecipeImage:recipeModel.image,
                                      numOfRates: recipeModel.numOfRates!,
                                      averageRating: recipeModel.averageRating!,
                                      totalRating: recipeModel.totalRating!

                                  );
                                }

                            } else
                            {
                              if(recipeModel.category == 'breakfast') {
                                AdminCubit.get(context).uploadNewImage(
                                  AdminCubit.get(context).lunchRecID[index],
                                  title: titleController.text,
                                  ingredients: ingredientsController.text,
                                  directions: directionsController.text,
                                  carbs: double.parse(carbsController.text),
                                  protein: double.parse(proteinController.text),
                                  fats: double.parse(fatsController.text),
                                  calories: double.parse(calsController.text),
                                  weight: double.parse(weightController.text),
                                  //uId: recipeModel.uId,
                                  category: recipeModel.category,
                                    numOfRates: recipeModel.numOfRates!,
                                    averageRating: recipeModel.averageRating!,
                                    totalRating: recipeModel.totalRating!
                                );
                              } else if(recipeModel.category == 'lunch') {
                                AdminCubit.get(context).uploadNewImage(
                                  AdminCubit.get(context).dinnerRecID[index],
                                  title: titleController.text,
                                  ingredients: ingredientsController.text,
                                  directions: directionsController.text,
                                  carbs: double.parse(carbsController.text),
                                  protein: double.parse(proteinController.text),
                                  fats: double.parse(fatsController.text),
                                  calories: double.parse(calsController.text),
                                  weight: double.parse(weightController.text),
                                  //uId: recipeModel.uId,
                                  category: recipeModel.category,
                                    numOfRates: recipeModel.numOfRates!,
                                    averageRating: recipeModel.averageRating!,
                                    totalRating: recipeModel.totalRating!
                                );
                              } else {
                                AdminCubit.get(context).uploadNewImage(
                                  AdminCubit.get(context).recipesIds[index],
                                  title: titleController.text,
                                  ingredients: ingredientsController.text,
                                  directions: directionsController.text,
                                  carbs: double.parse(carbsController.text),
                                  protein: double.parse(proteinController.text),
                                  fats: double.parse(fatsController.text),
                                  calories: double.parse(calsController.text),
                                  weight: double.parse(weightController.text),
                                  //uId: recipeModel.uId,
                                  category: recipeModel.category,
                                    numOfRates: recipeModel.numOfRates!,
                                    averageRating: recipeModel.averageRating!,
                                    totalRating: recipeModel.totalRating!
                                );
                              }
                            }

                          },
                          text: 'UPDATE',
                          textStyle: Theme.of(context).textTheme.headline1!.copyWith(
                              color: Colors.white
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),

          );
        },

    );
  }
}
