import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/layout/admin_layout/cubit/cubit.dart';
import 'package:gp/layout/admin_layout/cubit/states.dart';
import 'package:gp/shared/componants/componants.dart';
import 'package:gp/shared/styles/colors.dart';
import 'package:gp/shared/styles/icon_broken.dart';
class EditRecipeScreen extends StatelessWidget {
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
                      Container(
                        width: double.infinity,
                        height: 350,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/Recipe1.jpg'),
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
                            defaultTextButton1(
                              color: Colors.white,
                              onPressed: () {

                              },
                              text : 'Delete',
                              context: context,
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
                        SizedBox(
                          height: 65,
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            controller: titleController,
                            decoration: const InputDecoration(
                                hintText: 'Title',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15.0),
                                    ),
                                    borderSide: BorderSide.none
                                ),
                                prefixIcon: Icon(IconBroken.Paper),
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
                        defaultButton(
                          context,
                          onPreesed: () {

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
