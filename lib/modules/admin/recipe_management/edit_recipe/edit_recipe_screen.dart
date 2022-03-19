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

   RecipeModel recipeModel;
  EditRecipeScreen({
    required this.recipeModel,
  });

  @override
  Widget build(BuildContext context) {

    var titleController = TextEditingController();
    var ingredientsController = TextEditingController();
    var directionsController = TextEditingController();
    //var categoryController = TextEditingController();
    var carbsController = TextEditingController();
    var fatsController = TextEditingController();
    var proteinController = TextEditingController();
    var calsController = TextEditingController();
    var weightController = TextEditingController();

   // var recipeModel = AdminCubit.get(context).recipeModel;
    var recipeImage = AdminCubit.get(context).image;

    titleController.text = recipeModel.title!;
    ingredientsController.text = recipeModel.ingredients!;
    directionsController.text = recipeModel.directions!;
    carbsController.text = '${recipeModel.carbs}';
    fatsController.text = '${recipeModel.fats}';
    proteinController.text = '${recipeModel.protein}';
    calsController.text = '${recipeModel.calories}';
    weightController.text = '${recipeModel.weight}';


    return BlocConsumer<AdminCubit, AdminStates>(
        builder: (context, state) {




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
                              color: Colors.white,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon:const Icon( IconBroken.Arrow___Left_2),
                            ),
                            const Spacer(),
                            defaultTextButton(
                              context,
                              color: Colors.white,
                              function: () {

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
                               AdminCubit.get(context).getImage();
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
                            hintText: 'Title',
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
                                hintText: 'Enter Ingredients ... ',
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
                                hintText: 'Enter Directions ... ',
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
                            hintText: 'Carbs',
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
                            hintText: 'Protein',
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
                            hintText: 'Fats',
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
                            hintText: 'Calories',
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
                            hintText: 'Weight',
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        defaultButton(
                          context,
                          onPreesed: () {
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
                                category: recipeModel.category
                            );
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
        listener: (context, state) {

    }
    );
  }
}