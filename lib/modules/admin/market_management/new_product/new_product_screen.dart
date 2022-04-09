
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/layout/admin_layout/cubit/cubit.dart';
import 'package:gp/layout/admin_layout/cubit/states.dart';
import 'package:gp/shared/componants/componants.dart';
import 'package:gp/shared/styles/colors.dart';
import 'package:gp/shared/styles/icon_broken.dart';

class NewProductSrceen extends StatelessWidget {

  var nameController = TextEditingController();
  var descriptionController = TextEditingController();
  var currentPriceController = TextEditingController();
  var oldPriceController = TextEditingController();
  var discountController = TextEditingController();
  var quantityController = TextEditingController();
  var uIdController = TextEditingController();


  //var timeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit, AdminStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        var productImage = AdminCubit
            .get(context)
            .productImage;

        return Scaffold(
            appBar: buildAppBar(
              title: 'Create Product',
              icon: IconBroken.Arrow___Left_2,
              onPressed: () {
                Navigator.pop(context);
              },
              titleSpacing: 5.0,
              actions: [
                defaultTextButton(
                  context,
                  function: () {

                   AdminCubit.get(context).uploadProductImage(
                      name: nameController.text,
                      currentPrice: double.parse(currentPriceController.text),
                      oldPrice: double.parse(oldPriceController.text),
                      discount: double.parse(discountController.text),
                      quantity: int.parse(quantityController.text),
                      description: descriptionController.text,
                      status: 'inStock',
                      uId: uIdController.text,
                      //totalTime: totalTime
                    );

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
                    if(state is CreateProductLoadingState)
                      const LinearProgressIndicator(),
                    if(state is CreateProductLoadingState)
                      const SizedBox(
                        height: 10.0,
                      ),
                    defaultContainer(
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
                    ),
                    defaultContainer(
                      height: 65,
                      child: defaultTextFormField(
                        type: TextInputType.text,
                        controller: nameController,
                        hintText: 'Name',
                        //prefixIcon: Icon(IconBroken.Paper),
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    defaultContainer(
                      height: 150,
                      color: constantColor5,
                      child: defaultTextFormField(
                        controller: descriptionController,
                        type: TextInputType.multiline,
                        maxLines: 30,
                        hintText: 'Enter Description ... ',

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
                        controller: currentPriceController,
                        hintText: 'Current Price',
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
                        controller: oldPriceController,
                        hintText: 'Old Price',
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
                        controller: discountController,
                        hintText: 'Discount',

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
                        controller: quantityController,
                        hintText: 'Quantity',
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),

                    if(AdminCubit
                        .get(context)
                        .productImage != null)
                      Stack(
                        alignment: AlignmentDirectional.topEnd,
                        children: [
                          defaultContainer(
                            height: 140.0,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.0),
                                image: DecorationImage(
                                    image: FileImage(productImage!),
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
                          AdminCubit.get(context).getProductImage();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
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