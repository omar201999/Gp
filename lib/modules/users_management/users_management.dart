
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/layout/admin_layout/cubit/cubit.dart';
import 'package:gp/layout/admin_layout/cubit/states.dart';
import 'package:gp/models/user_model.dart';
import 'package:gp/shared/componants/componants.dart';
import 'package:gp/shared/componants/constant.dart';

class UsersManagementScreen extends StatelessWidget {

  void deleteUser(uId){
    var collection = FirebaseFirestore.instance.collection('users');
     collection.doc('uId').delete().then((value) {
       print('done');
     }).catchError((error){
       print(error.toString());
     });
  }

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<AdminCubit, AdminStates>(

      listener: (context , state ) {},
      builder: (context , state ){
        return ConditionalBuilder(
            condition: AdminCubit.get(context).users.length > 0,
        builder: (context) => ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) => BuildUserItem(AdminCubit.get(context).users[index]),
        separatorBuilder: (context, index) => myDivider(),
        itemCount: AdminCubit.get(context).users.length,
        ),
        fallback: (context) => Center(child: CircularProgressIndicator())
        );
      }

    );


  }

  Widget  BuildUserItem (UserModel model)=> Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children:
      [
        CircleAvatar(
          radius: 40.0,
          backgroundImage: NetworkImage(
              '${model.profileImage}'
          ),
        ),
        SizedBox(
          width: 20,),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children:
            [
              Text(
                '${model.name}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                '${model.email}',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        IconButton(
            icon: Icon(
              Icons.delete_forever
            ),
            onPressed: () {
              deleteUser(uId);
            }
        ),
      ],
    ),
  );

}