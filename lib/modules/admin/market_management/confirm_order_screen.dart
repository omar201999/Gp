
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/layout/admin_layout/cubit/cubit.dart';
import 'package:gp/layout/admin_layout/cubit/states.dart';
import 'package:gp/models/new_order_model.dart';
import 'package:gp/modules/admin/market_management/products_for_order.dart';
import 'package:gp/shared/componants/componants.dart';
import 'package:gp/shared/styles/icon_broken.dart';
import 'package:intl/intl.dart';

class ConfirmOrderScreen extends StatelessWidget {

  const ConfirmOrderScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<AdminCubit, AdminStates>(

        listener: (context , state ) {},
        builder: (context , state ){
          return Scaffold(
            appBar: buildAppBar(
              title: 'Orders',
              icon: IconBroken.Arrow___Left_2,
              onPressed: ()
              {
                Navigator.pop(context);
              },
            ),
            body: ConditionalBuilder(
                condition: AdminCubit.get(context).orders.isNotEmpty && state is !AdminGetAllOrdersLoadingState ,
                builder: (context) => SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding:  const EdgeInsets.symmetric(
                      horizontal: 16
                    ),
                    child: ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) => BuildOrderItem(AdminCubit.get(context).orders[index],context,index),
                      separatorBuilder: (context, index) => myDivider(),
                      itemCount: AdminCubit.get(context).orders.length,
                    ),
                  ),
                ),
                fallback: (context) => const Center(child: CircularProgressIndicator())
            ),
          );
        }

    );
  }

  Widget  BuildOrderItem (NewOrderModel model,context,index)=> Padding(
    padding: const EdgeInsetsDirectional.only(
      top: 10,
      bottom: 10
    ),
    child: InkWell(
      onTap: ()
      {
        if(model.cardItemList != null)
        {
          navigateTo(context, ProductsForOrder(products: model.cardItemList!, orderID: model.orderId!,));
        }
        else
          {
            showToast(text: 'this customer buy one product ', state: ToastStates.WARNING);

          }
      },
      child: Column(
        children:
        [
          defaultContainer(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children:
                [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                      [
                        defaultBodyText(context, text: 'User name is ${model.userName}'),
                        SizedBox(
                          height: 5,
                        ),
                        defaultBodyText(context, text: 'Address is ${model.address}'),
                        SizedBox(
                          height: 5,
                        ),
                        defaultBodyText(context, text: 'Phone is ${model.phone}'),
                        SizedBox(
                          height: 5,
                        ),
                        defaultBodyText(context, text: 'Data is ${convertToDataTime(model.dateTime!)} '),
                      ],
                    ),
                  ),
                  defaultTextButton(context, function: ()
                  {
                  }, text: 'Confirm'),
                ],
              ),
            ),
          ),

         /* ListView.separated(
            shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context,index) =>Card(
                child: Column(
                  children: [
                    Image(
                      image: NetworkImage('${model.cardItemList![0]['image']}'),
                      width: double.infinity,
                      height: 200.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          defaultBodyText(context, text: '${model.cardItemList![0]['name']}'),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              defaultBodyText(context, text: ' currentPrice:${model.cardItemList![0]['currentPrice']}'),
                              Spacer(),
                              defaultBodyText(context, text: 'quantity:${model.cardItemList![0]['quantity']}'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              separatorBuilder: (context,index) =>  SizedBox(width: 5,),
              itemCount:model.cardItemList!.length,
          ),*/
        ],
      ),
    ),
  );
  String convertToDataTime(String date) => DateFormat('dd-MM-yyyy HH:mm').format(DateTime.parse(date));



}
