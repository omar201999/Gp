import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/layout/admin_layout/cubit/cubit.dart';
import 'package:gp/layout/admin_layout/cubit/states.dart';
import 'package:gp/layout/home-layout/cubit/cubit.dart';
import 'package:gp/models/product_model.dart';
import 'package:gp/models/user_model.dart';
import 'package:gp/shared/componants/componants.dart';

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
            ),
            body: ConditionalBuilder(
                condition: AdminCubit.get(context).users.length > 0 ,
                builder: (context) => ListView.separated(
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) => BuildOrderItem(AdminCubit.get(context).users[index],AdminCubit.get(context).orders[index],context,index),
                  separatorBuilder: (context, index) => myDivider(),
                  itemCount: AdminCubit.get(context).users.length,
                ),
                fallback: (context) => Center(child: CircularProgressIndicator())
            ),
          );
        }

    );
  }


}
