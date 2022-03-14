import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/layout/admin_layout/cubit/cubit.dart';
import 'package:gp/layout/admin_layout/cubit/states.dart';
import 'package:gp/shared/componants/componants.dart';
import 'package:gp/shared/styles/colors.dart';
import 'package:gp/shared/styles/icon_broken.dart';

class NewRecipeScreen extends StatelessWidget {

 var titleController = TextEditingController();
 var ingredientsController = TextEditingController();
 var directionsController = TextEditingController();
 var categoryController = TextEditingController();
 var carbsController = TextEditingController();
 var fatsController = TextEditingController();
 var proteinController = TextEditingController();
 var calsController = TextEditingController();
 var weightController = TextEditingController();
 //var timeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit, AdminStates>(
        listener: (context, state) {

        },
        builder: (context, state)
        {

          var recipeImage = AdminCubit.get(context).recipeImage;

          return Scaffold(
              appBar: defaultAppBar(
                  title: 'Create Recipe',
                  actions: [
                    defaultTextButton1(
                        onPressed: () {
                         AdminCubit.get(context).uploadRecipeImage(
                             title: titleController.text,
                             carbs: double.parse(carbsController.text),
                             protein: double.parse(proteinController.text),
                             fats: double.parse(fatsController.text),
                             calories: double.parse(calsController.text),
                             weight: double.parse(weightController.text),
                             ingredients: ingredientsController.text,
                             directions: directionsController.text,
                             category: categoryController.text,
                             //uId: '',
                             //totalTime: totalTime
                         );
                        },
                        text: 'Add',
                        context: context
                    )
                  ],
                  context :context
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
                      SizedBox(
                        height: 65,
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          controller: titleController,
                          decoration: const InputDecoration(
                              hintText: 'title',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15.0),
                                  ),
                                  borderSide: BorderSide.none
                              ),
                              //prefixIcon: Icon(IconBroken.Search),
                              filled: true,
                              fillColor: constantColor5
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      defaultContainer(
                          height: 150,
                          child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: TextFormField(
                                controller: ingredientsController,
                                keyboardType: TextInputType.multiline,
                                maxLines: 50,
                                decoration: const InputDecoration(
                                  hintText: 'Enter Ingredients ... ',
                                  border: InputBorder.none,
                                ),
                              ),
                          )
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      defaultContainer(
                          height: 150,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TextFormField(
                              controller: directionsController,
                              keyboardType: TextInputType.multiline,
                              maxLines: 50,
                              decoration: const InputDecoration(
                                hintText: 'Enter Directions ... ',
                                border: InputBorder.none,
                              ),
                            ),
                          )
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      SizedBox(
                        height: 65,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: carbsController,
                          decoration: const InputDecoration(
                              hintText: 'Carbs',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15.0),
                                  ),
                                  borderSide: BorderSide.none
                              ),
                             // prefixIcon: Icon(IconBroken.Paper),
                              filled: true,
                              fillColor: constantColor5
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      SizedBox(
                        height: 65,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: proteinController,
                          decoration: const InputDecoration(
                              hintText: 'Protein',
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
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      SizedBox(
                        height: 65,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: fatsController,
                          decoration: const InputDecoration(
                              hintText: 'Fats',
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
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      SizedBox(
                        height: 65,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: calsController,
                          decoration: const InputDecoration(
                              hintText: 'Calories',
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
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      SizedBox(
                        height: 65,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: weightController,
                          decoration: const InputDecoration(
                              hintText: 'Weight',
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
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      SizedBox(
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
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      if(AdminCubit.get(context).recipeImage != null)
                        Stack(
                          alignment: AlignmentDirectional.topEnd,
                          children: [
                            Container(
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
                            children:  [
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