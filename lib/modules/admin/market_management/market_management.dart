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
          return Scaffold(
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: defaultContainer(
                  color: Colors.grey[50],
                  child: Column(

                    children:
                    [
                      defaultContainer(
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
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GridView.count(
                        crossAxisCount: 2,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        mainAxisSpacing: 2.0,
                        crossAxisSpacing: 1.8,
                        childAspectRatio: 1 / 1.43,
                        children: List.generate(
                                AdminCubit.get(context).products.length,
                                (index) => buildProductItem(AdminCubit.get(context).products[index], context),
                        ),
                      ),


                    ],
                  ),
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                navigateTo(context, NewProductSrceen());
              },
              child: const Icon(Icons.add),
            ),
          );
        },
        listener: (context, state) {

        }
    );

  }

}

Widget buildProductItem(ProductModel model,context) => defaultGestureDetector(
  onTap: ()
  {
    navigateTo(context, EditProductScreen(productModel: model,));
  },
  child: defaultContainer(

    color: constantColor5,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
      [
        Image(
            image: NetworkImage('${model.image}'),
            width: double.infinity,
            //height: 200.0,
            fit: BoxFit.cover,
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
              children: [
                Text(
                  '${model.name}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                        fontSize: 16,
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
                    Text(
                      '${model.oldPrice}',
                      style: const TextStyle(
                        fontSize: 10.0,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ],
                ),

              ],
            ),
          ),
      ],
    ),
  ),
);