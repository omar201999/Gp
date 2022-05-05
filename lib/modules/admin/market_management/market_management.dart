import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/layout/admin_layout/cubit/cubit.dart';
import 'package:gp/layout/admin_layout/cubit/states.dart';
import 'package:gp/models/product_model.dart';
import 'package:gp/modules/admin/market_management/edit_product/edit_product_screen.dart';
import 'package:gp/modules/admin/market_management/new_product/new_product_screen.dart';
import 'package:gp/shared/componants/componants.dart';
import 'package:gp/shared/styles/colors.dart';

class MarketManagementScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<AdminCubit, AdminStates>(
        builder: (context, state) {
          return ConditionalBuilder(
            condition: AdminCubit.get(context).products.isNotEmpty && state is !GetProductsLoadingState,
            builder: (context) => Scaffold(
              body: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child:Column(
                      children:
                      [
                        /*defaultContainer(
                          height: 60,
                          color: constantColor5,
                          child: defaultTextFormField(
                            type: TextInputType.text,
                            prefix: Icons.search,
                            hintText: 'Search',
                            border: InputBorder.none,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                        ),*/
                        GridView.count(
                          crossAxisCount: 2,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 5,
                          childAspectRatio: 1 / 1.43,
                          children: List.generate(
                            AdminCubit.get(context).products.length,
                                (index) => buildProductItem(AdminCubit.get(context).products[index], context, index),
                          ),
                        ),
                      ],
                    ),

                ),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  navigateTo(context, NewProductSrceen());
                },
                child: const Icon(Icons.add),
              ),
            ),
            fallback: (context) => NewProductSrceen(),
          );
        },
        listener: (context, state) {

        }
    );

  }

}

Widget buildProductItem(ProductModel model,context, index) => defaultGestureDetector(
  onTap: ()
  {
    navigateTo(context, EditProductScreen(productModel: model, index: index,));
  },
  child: defaultContainer(
    context,
    //color: constantColor5,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
      [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image: NetworkImage('${model.image}'),
              width: double.infinity,
              //height: 180.0,
              fit: BoxFit.cover,
            ),

            if (model.discount != 0)
              Container(
              color: Colors.red,
              padding: EdgeInsets.symmetric(
                horizontal: 5.0
              ),
              child: Text(
                'DISCOUNT',
                style: TextStyle(
                  fontSize: 8.0,
                  color: Colors.white,
                ),
              )
            ),
          ],
        ),
        Padding(
            padding: /*EdgeInsetsDirectional.only(
                start: 10,
            ),*/
              const EdgeInsets.symmetric(
                vertical: 5.0,
                horizontal: 6.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${model.name}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      height: 1.3,
                    ),
                  ),
                  Row(
                    children:
                    [
                      Text(
                        '${model.currentPrice}',
                        style: const TextStyle(
                          fontSize: 13.0,
                          color: defaultColor,
                        ),
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      if (model.discount != 0)
                        Text(
                          '${model.oldPrice}',
                          style: const TextStyle(
                            fontSize: 10.0,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      const Spacer(),
                      if (model.quantity == 0)
                        const Text(
                          'Not available now',
                          style: TextStyle(
                              fontSize: 12.0,
                              color: Colors.red
                            ),
                          )
                  ],
                ),

              ],
            ),
          ),
      ],
    ),
  ),
);