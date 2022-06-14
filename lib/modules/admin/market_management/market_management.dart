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
import 'package:simple_shadow/simple_shadow.dart';
import 'package:gp/shared/styles/icon_broken.dart';

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
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
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

Widget buildProductItem(ProductModel model, context, index) => defaultGestureDetector(
  onTap: ()
  {
      navigateTo(context, EditProductScreen(productModel: model, index: index,));

  },
  child:
  defaultContainer(
    context,
    decoration: BoxDecoration (
      color: constantColor5,
      borderRadius: BorderRadius.circular(15.0),
    ),
    //color: constantColor5,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
      [
        Stack(
          children: [

             Padding(
              padding: const EdgeInsetsDirectional.only(
               top: 20,
               bottom: 5,
               end: 20,
               start: 20
              ),
              child: SimpleShadow(
                   child: Image(
                     image: NetworkImage('${model.image}'),
                     width: 140.0,
                     height: 140.0,
                     fit: BoxFit.cover,
                   ),
                   opacity: 0.5,
                   //color: Colors.blue,
                   offset: Offset(1, 1),
                   sigma: 8,
                 )
          ),
            if (model.discount != 0 && model.quantity != 0)
              Padding(
                  padding: const EdgeInsetsDirectional.only(
                    start: 10.0,
                    top: 10.0,
                  ),
                  child: defaultContainer(
                    context,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25)
                    ),
                    padding: EdgeInsets.symmetric(
                        horizontal: 5.0
                    ),
                    child: Text(
                      '${model.discount}% OFF',
                         // AppLocalizations.of(context).translate("off"),
                      style: const TextStyle(
                          fontSize: 10.0,
                          fontWeight: FontWeight.w900
                      ),
                    )
                ),
              ),
            if (model.quantity == 0)
              Padding(
                padding: const EdgeInsetsDirectional.only(
                  start: 10.0,
                  top: 10.0,
                ),
                child: Container(
                 decoration: BoxDecoration(
                     color: Colors.red,
                    borderRadius: BorderRadius.circular(25)
                 ),
                 padding: const EdgeInsets.symmetric(
                    horizontal: 5.0
                 ),
                 child:Text(
                  'Out of Stock',
                   //AppLocalizations.of(context).translate("not_available"),
                  style: TextStyle(
                      fontSize: 10.0,
                    color: Colors.white,
                  ),
                ),
              ),
              )

          ],
        ),

        Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 5.0,
                horizontal: 10.0,
              ),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 5.0,
                    horizontal: 10.0,
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
                              fontWeight: FontWeight.w900,
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
                        ],
                      ),

                    ],
                  ),
                )
              )
          ),
      ],
    ),
  ),
);