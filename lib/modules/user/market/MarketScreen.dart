import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/layout/admin_layout/cubit/cubit.dart';
import 'package:gp/layout/admin_layout/cubit/states.dart';
import 'package:gp/models/product_model.dart';
import 'package:gp/modules/admin/market_management/edit_product/edit_product_screen.dart';
import 'package:gp/modules/admin/market_management/new_product/new_product_screen.dart';
import 'package:gp/shared/componants/componants.dart';
import 'package:gp/shared/styles/colors.dart';

class MarketingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

          return Scaffold(
            appBar: buildAppBar(
                title: 'Marketing ',
                actions:
                [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context,);

                    },
                    icon: Icon(
                      Icons.shopping_cart,
                    ),
                  ),
                ]
            ),
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
                        height: 40,
                      ),
                      GridView.count(
                        crossAxisCount: 2,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: 1 / 1.50,
                        children: List.generate(
                          AdminCubit.get(context).products.length,
                              (index) => buildmarket_item(AdminCubit.get(context).products[index], context),
                        ),
                      ),


                    ],
                  ),
                ),
              ),
            ),
          );
        }


        }






