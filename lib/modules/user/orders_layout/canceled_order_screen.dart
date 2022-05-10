import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/layout/home-layout/cubit/cubit.dart';
import 'package:gp/layout/home-layout/cubit/states.dart';
import 'package:gp/shared/componants/componants.dart';

class CanceledOrderUserScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
      listener:  (context,state){},
      builder: (context,state)
      {
        var list = HomeCubit.get(context).canceledOrders;
        return buildOrderScreensUser(list);
      },
    );
  }
}
