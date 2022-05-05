import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/layout/admin_layout/cubit/cubit.dart';
import 'package:gp/layout/admin_layout/cubit/states.dart';
import 'package:gp/shared/componants/componants.dart';
import 'package:gp/shared/styles/colors.dart';
import 'package:gp/shared/styles/icon_broken.dart';

class NewRecipeScreen extends StatelessWidget {
  final String category;
  NewRecipeScreen({
    required this.category,
});

 var titleController = TextEditingController();
 var ingredientsController = TextEditingController();
 var directionsController = TextEditingController();
 //var categoryController = TextEditingController();
 var carbsController = TextEditingController();
 var fatsController = TextEditingController();
 var proteinController = TextEditingController();
 var calsController = TextEditingController();
 var weightController = TextEditingController();
 var uIdController = TextEditingController();

 //var timeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit, AdminStates>(
        listener: (context, state) {
            if (state is CreateRecipeSuccessState) {
              showToast(
                  text: 'Recipe has added successfully',
                  state: ToastStates.SUCCESS
              );
            }
        },
        builder: (context, state)
        {

          var recipeImage = AdminCubit.get(context).recipeImage;

          return Scaffold(
              appBar: buildAppBar(
                  title: 'Create Recipe',
                  icon: IconBroken.Arrow___Left_2,
                  onPressed: () {
                    Navigator.pop(context);
                    AdminCubit.get(context).removeRecipeImage();
                  },
                  actions: [
                    defaultTextButton(
                     context,
                      function: () {
                         AdminCubit.get(context).uploadRecipeImage(
                             title: titleController.text,
                             carbs: double.parse(carbsController.text),
                             protein: double.parse(proteinController.text),
                             fats: double.parse(fatsController.text),
                             calories: double.parse(calsController.text),
                             weight: double.parse(weightController.text),
                             ingredients: ingredientsController.text,
                             directions: directionsController.text,
                             category: category,
                             //uId:uIdController.text,
                             //totalTime: totalTime
                         );
                         AdminCubit.get(context).removeRecipeImage();
                        },
                        text: 'Add',
                    )
                  ],
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      if(state is CreateRecipeLoadingState)
                        const LinearProgressIndicator(),
                      if(state is CreateRecipeLoadingState)
                        const SizedBox(
                          height: 10.0,
                        ),
                      /*defaultContainer(
                          height: 65,
                          child: defaultTextFormField(
                              controller: uIdController,
                              type: TextInputType.number,
                              hintText: 'Unique Id ',
                              //border: InputBorder.none,
                            ),
                              ),
                      const SizedBox(
                        height: 10.0,
                      ),*/
                      defaultContainer(
                        height: 65,
                        child: defaultTextFormField(
                          type: TextInputType.text,
                          controller: titleController,
                          hintText: 'Title',
                              //prefixIcon: Icon(IconBroken.Search),

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
                                maxLines: 30,
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
                        height: 20.0,
                      ),
                      /*SizedBox(
                        height: 65,
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          controller: categoryController,
                          decoration: const InputDecoration(
                              hintText: 'Category',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15.0),
                                  ),
                                  borderSide: BorderSide.none
                              ),
                              //prefixIcon: Icon(IconBroken.Paper),
                              filled: true,
                              fillColor: constantColor5
                          ),
                        ),
                      ),*/

                      if(AdminCubit.get(context).recipeImage != null)
                        Stack(
                          alignment: AlignmentDirectional.topEnd,
                          children: [
                            defaultContainer(
                              height: 140.0,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.0),
                                image: DecorationImage(
                                  image: FileImage(recipeImage!),
                                  fit: BoxFit.cover
                                )
                              ),
                            ),
                            /*IconButton(
                                onPressed: () {

                                },
                                icon: const CircleAvatar(
                                  radius: 20.0,
                                  child: Icon(
                                    Icons.close,
                                    size: 18.0,
                                  ),
                                )
                            )*/
                          ],
                        ),
                      TextButton(
                          onPressed: () {
                             AdminCubit.get(context).getRecipeImage();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:  const [
                              Icon(IconBroken.Image),
                              SizedBox(
                                width: 10.0,
                              ),
                              Text('Add photo')
                            ],
                          )
                      ),
                    ],
                  ),
                ),
              )
          );
        },

    );

  }

}