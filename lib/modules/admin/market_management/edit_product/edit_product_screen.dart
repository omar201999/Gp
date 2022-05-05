
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/layout/admin_layout/cubit/cubit.dart';
import 'package:gp/layout/admin_layout/cubit/states.dart';
import 'package:gp/models/product_model.dart';
import 'package:gp/shared/componants/componants.dart';
import 'package:gp/shared/styles/colors.dart';
import 'package:gp/shared/styles/icon_broken.dart';
class EditProductScreen extends StatelessWidget {

  ProductModel productModel;
  int index;
  EditProductScreen({
    required this.productModel,
    required this.index,
  });

  var nameController = TextEditingController();
  var descriptionController = TextEditingController();
  //var currentPriceController = TextEditingController();
  var oldPriceController = TextEditingController();
  var discountController = TextEditingController();
  var quantityController = TextEditingController();
  var uIdController = TextEditingController();
  @override
  Widget build(BuildContext context) {



    return BlocConsumer<AdminCubit, AdminStates>(
        builder: (context, state) {
          var newProductImage = AdminCubit.get(context).newProductImage;

          nameController.text = productModel.name!;
          descriptionController.text = productModel.description!;
          //currentPriceController.text = '${productModel.currentPrice}';
          oldPriceController.text = '${productModel.oldPrice}';
          discountController.text = '${productModel.discount}';
          quantityController.text = '${productModel.quantity}';
          //uIdController.text = '${productModel.uId}';
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
                            image: //AssetImage('assets/images/Recipe1.jpg'),
                            newProductImage == null ? NetworkImage(
                                '${productModel.image}') : FileImage(
                                newProductImage) as ImageProvider,
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
                              icon: const Icon(IconBroken.Arrow___Left_2),
                            ),
                            const Spacer(),
                            defaultTextButton(
                              context,
                              color: defaultColor,
                              function: () {
                                AdminCubit.get(context).deleteProduct(AdminCubit.get(context).productsIDs[index]);
                                Navigator.pop(context);
                                showToast(
                                    text: 'Product has deleted successfully!',
                                    state: ToastStates.SUCCESS
                                );
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
                              AdminCubit.get(context).getNewProductImage();
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
                        /*defaultContainer(
                          height: 65,
                          child: defaultTextFormField(
                            controller: uIdController,
                            type: TextInputType.number,
                            border: InputBorder.none,
                            label: 'Uid'
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),*/
                        defaultContainer(
                          height: 65,
                          child: defaultTextFormField(
                            type: TextInputType.text,
                            controller: nameController,
                            //prefixIcon: Icon(IconBroken.Paper),
                              border: InputBorder.none,
                              label: 'Name'
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
                              border: InputBorder.none,
                              label: 'Description'

                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),

                        /*defaultContainer(
                          height: 65,
                          color: constantColor5,
                          child: defaultTextFormField(
                            type: TextInputType.number,
                            controller: currentPriceController,
                              border: InputBorder.none,
                              label: 'Current Price'
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),*/
                        defaultContainer(
                          height: 65,
                          color: constantColor5,
                          child: defaultTextFormField(
                            type: TextInputType.number,
                            controller: oldPriceController,
                              border: InputBorder.none,
                              label: 'Old Price'
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
                              border: InputBorder.none,
                              label: 'Discount'

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
                              border: InputBorder.none,
                              label: 'Quantity'

                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        defaultButton(
                          context,
                          onPreesed: () {

                            if(newProductImage == null)
                            {
                              AdminCubit.get(context).updateProduct(
                                AdminCubit.get(context).productsIDs[index],
                                name: nameController.text,
                                description: descriptionController.text,
                                currentPrice: double.parse(oldPriceController.text) - (double.parse(oldPriceController.text)*double.parse(discountController.text)/100),
                                oldPrice: double.parse(oldPriceController.text),
                                discount: double.parse(discountController.text),
                                quantity : int.parse(quantityController.text),
                                status: productModel.status,

                                //uId: productModel.uId,
                                newProductImage:productModel.image,
                              );

                            } else
                            {
                              AdminCubit.get(context).uploadNewProductImage(
                                  AdminCubit.get(context).productsIDs[index],
                                  name: nameController.text,
                                  description: descriptionController.text,
                                  currentPrice: double.parse(oldPriceController.text) - (double.parse(oldPriceController.text)*double.parse(discountController.text)/100),
                                  oldPrice: double.parse(oldPriceController.text),
                                  discount: double.parse(discountController.text),
                                  quantity : int.parse(quantityController.text),
                                  status: productModel.status,
                                  //uId: productModel.uId,
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
          if (state is UpdateProductsSuccessState || state is UploadNewProductImageSuccessState) {
            showToast(
                text: 'Product has updated successfully!',
                state: ToastStates.SUCCESS
            );
          }
        }
    );
  }
}