
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/layout/admin_layout/cubit/cubit.dart';
import 'package:gp/layout/admin_layout/cubit/states.dart';
import 'package:gp/modules/admin/users_management/search_users/search_users_screen.dart';
import 'package:gp/shared/componants/componants.dart';
import 'package:gp/shared/styles/icon_broken.dart';

class UsersManagementScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    return BlocConsumer<AdminCubit, AdminStates>(

      listener: (context , state ) {},
      builder: (context , state ){
        return Scaffold(
            appBar: AppBar(

            title: Text('Users'),
            actions: [

            IconButton(
            onPressed: () {
          navigateTo(context, SearchUsersScreen());
        },
        icon: Icon(IconBroken.Search),

        ),
        SizedBox(
        width:15.0
        )
        ],
        ),
          body: ConditionalBuilder(
            condition: AdminCubit.get(context).users.length > 0 && state is !AdminGetAllUsersLoadingState,
        builder: (context) => ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) => BuildUserItem(AdminCubit.get(context).users[index],context),
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
