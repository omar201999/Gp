import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/layout/admin_layout/cubit/cubit.dart';
import 'package:gp/layout/admin_layout/cubit/states.dart';
import 'package:gp/models/order-model.dart';
import 'package:gp/models/product_model.dart';
import 'package:gp/shared/componants/componants.dart';
import 'package:gp/shared/styles/colors.dart';
import 'package:gp/shared/styles/icon_broken.dart';

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
                condition: AdminCubit.get(context).orders.length > 0 ,
                builder: (context) => ListView.separated(
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) => BuildOrderItem(AdminCubit.get(context).orders[index],context,index),
                  separatorBuilder: (context, index) => myDivider(),
                  itemCount: AdminCubit.get(context).orders.length,
                ),
                fallback: (context) => Center(child: CircularProgressIndicator())
            ),
          );
        }

    );
  }

  Widget  BuildOrderItem (OrderModel model,context,index)=> SingleChildScrollView(

    child:Padding(
      padding: const EdgeInsets.all(16.0),
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
          SizedBox(
            height: 3,
          ),
        /* ListView.separated(
            shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context,index) =>buildConfirmOrderItem(context,AdminCubit.get(context).productsOrders[index]),
              separatorBuilder: (context,index) =>  SizedBox(width: 10,),
              itemCount:AdminCubit.get(context).productsOrders.length,
          ),*/
        ],
      ),
    ),
  );
  Widget buildConfirmOrderItem(context,ProductModel model) => defaultContainer(
      color: constantColor5,
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
    );


}
