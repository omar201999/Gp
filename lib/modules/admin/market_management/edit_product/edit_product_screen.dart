
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/layout/admin_layout/cubit/cubit.dart';
import 'package:gp/layout/admin_layout/cubit/states.dart';
import 'package:gp/models/product_model.dart';
import 'package:gp/shared/componants/componants.dart';
import 'package:gp/shared/componants/constant.dart';
import 'package:gp/shared/styles/colors.dart';
import 'package:gp/shared/styles/icon_broken.dart';
class EditProductScreen extends StatelessWidget {

  ProductModel productModel;
  EditProductScreen({
    required this.productModel,
  });
  @override
  Widget build(BuildContext context) {
    var nameController = TextEditingController();
    var descriptionController = TextEditingController();
    var currentPriceController = TextEditingController();
    var oldPriceController = TextEditingController();
    var discountController = TextEditingController();
    var quantityController = TextEditingController();
    var uIdController = TextEditingController();


    var productImage = AdminCubit.get(context).productImage;

    nameController.text = productModel.name!;
    descriptionController.text = productModel.description!;
    currentPriceController.text = '${productModel.currentPrice}';
    oldPriceController.text = '${productModel.oldPrice}';
    discountController.text = '${productModel.discount}';
    quantityController.text = '${productModel.quantity}';
    uIdController.text = '${productModel.uId}';

    return BlocConsumer<AdminCubit, AdminStates>(
        builder: (context, state) {
          return Scaffold(

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
                              icon: const Icon(IconBroken.Arrow___Left_2),
                            ),
                            const Spacer(),
                            defaultTextButton(
                              context,
                              color: Colors.white,
                              function: () {
                                AdminCubit.get(context).deleteProduct(productModel.uId);
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
                          height: 10.0,
                        ),
                        defaultButton(
                          context,
                          onPreesed: () {

                            if(productImage == null)
                            {
                              AdminCubit.get(context).UpdateProduct(
                                name: nameController.text,
                                description: descriptionController.text,
                                currentPrice: double.parse(currentPriceController.text),
                                oldPrice: double.parse(oldPriceController.text),
                                discount: double.parse(discountController.text),
                                quantity : int.parse(quantityController.text),
                                uId: productModel.uId,
                                newProductImage:productModel.image,
                              );

                            } else
                            {
                              AdminCubit.get(context).uploadNewProductImage(
                                  name: nameController.text,
                                  description: descriptionController.text,
                                  currentPrice: double.parse(currentPriceController.text),
                                  oldPrice: double.parse(oldPriceController.text),
                                  discount: double.parse(discountController.text),
                                  quantity : int.parse(quantityController.text),
                                  uId: productModel.uId,
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
        listener: (context, state) {

        }
    );
  }
}