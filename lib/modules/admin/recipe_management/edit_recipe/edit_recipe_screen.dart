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
  var titleArController = TextEditingController();
  var ingredientsArController = TextEditingController();
  var directionsArController = TextEditingController();

  //var categoryController = TextEditingController();
  var carbsController = TextEditingController();
  var fatsController = TextEditingController();
  var proteinController = TextEditingController();
  var calsController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  //var weightController = TextEditingController();

  RecipeModel recipeModel;
  EditRecipeScreen({
    required this.recipeModel,
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
          //weightController.text = '${recipeModel.weight}';
          titleArController.text = recipeModel.titleAr!;
          ingredientsArController.text = recipeModel.ingredientsAr!;
          directionsArController.text = recipeModel.directionsAr!;


          return Scaffold(
            //backgroundColor: Colors.grey[200],
            body: SingleChildScrollView(
              child: Form(
                  key: formKey,
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
                                    AdminCubit.get(context).deleteRecipe(recipeModel.uId);
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
                            defaultTextFormField(
                                type: TextInputType.text,
                                controller: titleController,
                                validate: (value) {
                                  if(value!.isEmpty) {
                                    return 'Please enter title of recipe';
                                  }
                                },
                                prefix: IconBroken.Paper,
                                border: InputBorder.none,
                                label: 'Title in English',
                              ),

                            const SizedBox(
                              height: 20.0,
                            ),
                            defaultTextFormField(
                                type: TextInputType.text,
                                controller: titleArController,
                                validate: (value) {
                                  if(value!.isEmpty) {
                                    return 'Please enter title of recipe';
                                  }
                                },
                                prefix: IconBroken.Paper,
                                border: InputBorder.none,
                                label: 'Title in Arabic',
                              ),
                            const SizedBox(
                              height: 20.0,
                            ),

                           Container(

                             height: 150,
                              //color: constantColor5,
                              child: defaultTextFormField(
                                controller: ingredientsController,
                                validate: (value) {
                                  if(value!.isEmpty) {
                                    return 'Please enter ingredients of recipe';
                                  }
                                },
                                type: TextInputType.multiline,
                                maxLines: 30,
                                border: InputBorder.none,
                                label: 'Ingredients in English',

                              ),),
                            const SizedBox(
                              height: 20.0,
                            ),

                            Container(
                               height: 150,
                              //color: constantColor5,
                              child: defaultTextFormField(
                                controller: ingredientsArController,
                                validate: (value) {
                                  if(value!.isEmpty) {
                                    return 'Please enter ingredients of recipe';
                                  }
                                },
                                type: TextInputType.multiline,
                                maxLines: 30,
                                border: InputBorder.none,
                                label: 'Ingredients in Arabic',

                              ),),

                            const SizedBox(
                              height: 20.0,
                            ),
                            Container(
                              height: 150,
                              //color: constantColor5,
                              child: defaultTextFormField(
                                controller: directionsController,
                                validate: (value) {
                                  if(value!.isEmpty) {
                                    return 'Please enter directions of recipe';
                                  }
                                },
                                type: TextInputType.multiline,
                                maxLines: 30,
                                border: InputBorder.none,
                                label: 'Directions in English',
                              ),),
                            const SizedBox(
                              height: 20.0,
                            ),
                            Container(
                              height: 150,
                              //color: constantColor5,
                              child: defaultTextFormField(
                                controller: directionsArController,
                                validate: (value) {
                                  if(value!.isEmpty) {
                                    return 'Please enter directions of recipe';
                                  }
                                },
                                type: TextInputType.multiline,
                                maxLines: 30,
                                border: InputBorder.none,
                                label: 'Directions in Arabic',
                              ),),
                            const SizedBox(
                              height: 20.0,
                            ),
                            defaultTextFormField(
                                type: TextInputType.number,
                                controller: carbsController,
                                validate: (value) {
                                  if(value!.isEmpty) {
                                    return 'Please enter carbs of recipe';
                                  }
                                },
                                border: InputBorder.none,
                                label: 'Carbs',
                              ),

                            const SizedBox(
                              height: 20.0,
                            ),
                            defaultTextFormField(
                                type: TextInputType.number,
                                controller: proteinController,
                                validate: (value) {
                                  if(value!.isEmpty) {
                                    return 'Please enter protein of recipe';
                                  }
                                },
                                border: InputBorder.none,
                                label: 'Protein',
                              ),

                            const SizedBox(
                              height: 20.0,
                            ),
                            defaultTextFormField(
                                type: TextInputType.number,
                                controller: fatsController,
                                validate: (value) {
                                  if(value!.isEmpty) {
                                    return 'Please enter fats of recipe';
                                  }
                                },
                                border: InputBorder.none,
                                label: 'Fats',
                              ),

                            const SizedBox(
                              height: 20.0,
                            ),
                            defaultTextFormField(
                                type: TextInputType.number,
                                controller: calsController,
                                validate: (value) {
                                  if(value!.isEmpty) {
                                    return 'Please enter calories of recipe';
                                  }
                                },
                                border: InputBorder.none,
                                label: 'Calories',
                              ),

                            const SizedBox(
                              height: 20.0,
                            ),
                            defaultButton(
                              context,
                              onPreesed: () {
                                //print(recipeModel.numOfRates);
                                //print(recipeModel.averageRating);
                                //print(recipeModel.totalRating);
                                //print(recipeModel.uId);
                          if(formKey.currentState!.validate()) {
                            if (recipeImage == null) {
                              AdminCubit.get(context).updateRecipe(
                                recipeModel.uId,
                                title: titleController.text,
                                ingredients: ingredientsController.text,
                                directions: directionsController.text,
                                carbs: double.parse(carbsController.text),
                                protein: double.parse(proteinController.text),
                                fats: double.parse(fatsController.text),
                                calories: double.parse(calsController.text),
                                //weight: double.parse(weightController.text),
                                category: recipeModel.category,
                                newRecipeImage: recipeModel.image,
                                numOfRates: recipeModel.numOfRates!,
                                averageRating: recipeModel.averageRating!,
                                totalRating: recipeModel.totalRating!,
                                uId: recipeModel.uId,
                                directionsAr: directionsArController.text,
                                titleAr: titleArController.text,
                                ingredientsAr: ingredientsArController.text,
                              );
                            } else {
                              AdminCubit.get(context).uploadNewImage(
                                recipeModel.uId,
                                title: titleController.text,
                                ingredients: ingredientsController.text,
                                directions: directionsController.text,
                                carbs: double.parse(carbsController.text),
                                protein: double.parse(proteinController.text),
                                fats: double.parse(fatsController.text),
                                calories: double.parse(calsController.text),
                                //weight: double.parse(weightController.text),
                                category: recipeModel.category,
                                numOfRates: recipeModel.numOfRates!,
                                averageRating: recipeModel.averageRating!,
                                totalRating: recipeModel.totalRating!,
                                ingredientsAr: ingredientsArController.text,
                                directionsAr: directionsArController.text,
                                uId: recipeModel.uId,
                                titleAr: titleArController.text,
                                //isFavorite: recipeModel.isFavorite
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
              )
            ),

          );
        },

    );
  }
}
