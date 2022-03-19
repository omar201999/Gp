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

  EditRecipeScreen({
    required this.recipeModel,
  });


  @override
  Widget build(BuildContext context) {
    // var recipeModel = AdminCubit.get(context).recipeModel;


    return BlocConsumer<AdminCubit, AdminStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var recipeImage = AdminCubit
            .get(context)
            .newRecipeImage;
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
                      width: double.infinity,
                      height: 350,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: //AssetImage('assets/images/Recipe1.jpg'),
                          recipeImage == null ? NetworkImage(
                              '${recipeModel.image}') : FileImage(
                              recipeImage) as ImageProvider,
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
                            color: Colors.white,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(IconBroken.Arrow___Left_2),
                          ),
                          const Spacer(),
                          defaultTextButton(
                            context,
                            color: Colors.white,
                            function: () {
                              AdminCubit.get(context).deleteRecipe(
                                  recipeModel.uId);
                              Navigator.pop(context);
                            },
                            text: 'Delete',
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
                            AdminCubit.get(context).getnewRecipeImage();
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
                        height: 65,
                        color: constantColor5,
                        child: defaultTextFormField(
                          type: TextInputType.text,
                          controller: titleController,
                          prefix: IconBroken.Paper,
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),

                      defaultContainer(
                        height: 150,
                        color: constantColor5,
                        child: defaultTextFormField(
                            controller: ingredientsController,
                            type: TextInputType.multiline,
                            maxLines: 30
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      defaultContainer(
                        height: 150,
                        color: constantColor5,
                        child: defaultTextFormField(
                            controller: directionsController,
                            type: TextInputType.multiline,
                            maxLines: 30
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      defaultContainer(
                        height: 65,
                        color: constantColor5,
                        child: defaultTextFormField(
                          type: TextInputType.number,
                          controller: carbsController,
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      defaultContainer(
                        height: 65,
                        color: constantColor5,
                        child: defaultTextFormField(
                          type: TextInputType.number,
                          controller: proteinController,
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      defaultContainer(
                        height: 65,
                        color: constantColor5,
                        child: defaultTextFormField(
                          type: TextInputType.number,
                          controller: fatsController,
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      defaultContainer(
                        height: 65,
                        color: constantColor5,
                        child: defaultTextFormField(
                          type: TextInputType.number,
                          controller: calsController,
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      defaultContainer(
                        height: 65,
                        color: constantColor5,
                        child: defaultTextFormField(
                          type: TextInputType.number,
                          controller: weightController,
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      defaultButton(
                        context,
                        onPreesed: () {
                          print(recipeImage);
                          print(recipeModel.uId);

                          if (recipeImage == null) {
                            AdminCubit.get(context).UpdateRecipe(
                              title: titleController.text,
                              ingredients: ingredientsController.text,
                              directions: directionsController.text,
                              carbs: double.parse(carbsController.text),
                              protein: double.parse(proteinController.text),
                              fats: double.parse(fatsController.text),
                              calories: double.parse(calsController.text),
                              weight: double.parse(weightController.text),
                              uId: recipeModel.uId,
                              category: recipeModel.category,
                              newRecipeImage: recipeModel.image,
                            );
                          } else {
                            AdminCubit.get(context).uploadNewImage(
                              title: titleController.text,
                              ingredients: ingredientsController.text,
                              directions: directionsController.text,
                              carbs: double.parse(carbsController.text),
                              protein: double.parse(proteinController.text),
                              fats: double.parse(fatsController.text),
                              calories: double.parse(calsController.text),
                              weight: double.parse(weightController.text),
                              uId: recipeModel.uId,
                              category: recipeModel.category,
                            );
                          }
                        },
                        text: 'UPDATE',
                        textStyle: Theme
                            .of(context)
                            .textTheme
                            .headline1!
                            .copyWith(
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
