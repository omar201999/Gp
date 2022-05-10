
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/layout/admin_layout/cubit/cubit.dart';
import 'package:gp/layout/admin_layout/cubit/states.dart';
import 'package:gp/shared/componants/componants.dart';
import 'package:gp/shared/styles/icon_broken.dart';

class NewProductSrceen extends StatelessWidget {

  var nameController = TextEditingController();
  var nameArController = TextEditingController();
  var descriptionController = TextEditingController();
  var descriptionArController = TextEditingController();
  //var currentPriceController = TextEditingController();
  var oldPriceController = TextEditingController();
  var discountController = TextEditingController();
  var quantityController = TextEditingController();
  //var uIdController = TextEditingController();


  //var timeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit, AdminStates>(
      listener: (context, state) {
        if (state is CreateProductSuccessState) {
          showToast(
              text: 'Product has added successfully!',
              state: ToastStates.SUCCESS
          );
        }
      },
      builder: (context, state) {
        var productImage = AdminCubit.get(context).productImage;

        return Scaffold(
            appBar: buildAppBar(
              title: 'Create Product',
              icon: IconBroken.Arrow___Left_2,
              onPressed: () {
                Navigator.pop(context);
                AdminCubit.get(context).removeProductImage();
              },
              titleSpacing: 5.0,
              actions: [
                defaultTextButton(
                  context,
                  function: () {

                   AdminCubit.get(context).uploadProductImage(
                      name: nameController.text,
                      currentPrice: double.parse(oldPriceController.text) - (double.parse(oldPriceController.text)*double.parse(discountController.text)/100),
                      oldPrice: double.parse(oldPriceController.text),
                      discount: double.parse(discountController.text),
                      quantity: int.parse(quantityController.text),
                      description: descriptionController.text,
                      status: 'inStock',
                     descriptionAr: descriptionArController.text,
                     nameAr: nameArController.text,
                      //uId: uIdController.text,
                      //totalTime: totalTime
                    );
                   AdminCubit.get(context).removeProductImage();

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
                    /*defaultContainer(
                      context,
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
                      context,
                      height: 65,
                      child: defaultTextFormField(
                        type: TextInputType.text,
                        controller: nameController,
                        hintText: 'Name in English',
                        //prefixIcon: Icon(IconBroken.Paper),
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    defaultContainer(
                      context,
                      height: 65,
                      child: defaultTextFormField(
                        type: TextInputType.text,
                        controller: nameArController,
                        hintText: 'Name in Arabic',
                        //prefixIcon: Icon(IconBroken.Paper),
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
                        controller: descriptionController,
                        type: TextInputType.multiline,
                        maxLines: 30,
                        hintText: 'Enter Description in English ... ',

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
                        controller: descriptionArController,
                        type: TextInputType.multiline,
                        maxLines: 30,
                        hintText: 'Enter Description in Arabic... ',

                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),

                    /*defaultContainer(
                      context,
                      height: 65,
                      //color: constantColor5,
                      child: defaultTextFormField(
                        type: TextInputType.number,
                        controller: currentPriceController,
                        hintText: 'Current Price',
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),*/
                    defaultContainer(
                      context,

                      height: 65,
                      //color: constantColor5,
                      child: defaultTextFormField(
                        type: TextInputType.number,
                        controller: oldPriceController,
                        hintText: 'Price',
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
                        controller: discountController,
                        hintText: 'Discount',

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
                        controller: quantityController,
                        hintText: 'Quantity',
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),

                    if(AdminCubit.get(context).productImage != null)
                      Stack(
                        alignment: AlignmentDirectional.topEnd,
                        children: [
                          defaultContainer(
                            context,
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