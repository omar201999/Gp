import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/layout/home-layout/cubit/cubit.dart';
import 'package:gp/layout/home-layout/cubit/states.dart';
import 'package:gp/modules/user/orders_layout/canceled_order_screen.dart';
import 'package:gp/modules/user/orders_layout/confirmed_order_screen.dart';
import 'package:gp/modules/user/orders_layout/new_order_screen.dart';
import 'package:gp/shared/styles/icon_broken.dart';


class OrderLayoutScreen extends StatefulWidget {



  @override
  State<OrderLayoutScreen> createState() => _OrderLayoutScreenState();
}

class _OrderLayoutScreenState extends State<OrderLayoutScreen> with TickerProviderStateMixin {
   TabController? tabController;
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    tabController!.addListener(() {
      setState(() {

      });
    });
  }
  @override
  Widget build(BuildContext context)
  {
    List<String> titleAppBar =
    [
      'New Order',
      'Confirm Order',
      'Cancel Order',

    ];
    return  BlocConsumer<HomeCubit, HomeStates>(
        listener: (context , state ) {},
        builder: (context , state ){
          return Scaffold(
            //'Orders',
            //IconBroken.Arrow___Left_2,
              //Navigator.pop(context);

              appBar: AppBar(
                title: Text(titleAppBar[tabController!.index]),
                titleSpacing: 16,
                leading: IconButton(
                  onPressed: ()
                  {
                    Navigator.pop(context);
                  },
                  icon: Icon(IconBroken.Arrow___Left_2,),

                ),
                bottom: TabBar(
                  labelColor: Colors.blue,
                  controller: tabController,
                  tabs: [
                    Tab(
                      text:'New Order' ,
                    ),
                    Tab(
                      text:'Confirm Order' ,
                    ),
                    Tab(
                      text:'Cancel Order' ,
                    ),
                  ],
                ),
              ),
            body: ConditionalBuilder(
                condition: state is! GetAllOrdersLoadingState,
                builder: (context) => TabBarView(
                  controller:tabController ,
                children:
                [
                  NewOrderUserScreen(),
                  ConfirmedOrderUserScreen(),
                  CanceledOrderUserScreen(),
                ],
              ),
                fallback: (context) => const Center(child: CircularProgressIndicator())

            )
          );
        }

    );
  }
}
