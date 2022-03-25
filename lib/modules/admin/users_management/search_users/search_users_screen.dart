import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/layout/admin_layout/cubit/cubit.dart';
import 'package:gp/layout/admin_layout/cubit/states.dart';
import 'package:gp/shared/componants/componants.dart';
import 'package:gp/shared/styles/icon_broken.dart';

class SearchUsersScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context)
  {
    var searchController = TextEditingController();
    return BlocConsumer<AdminCubit,AdminStates>(
      listener: (context,state)
      {

      },
      builder: (context,state)
      {
        var list = AdminCubit.get(context).searchUsers;


        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon (IconBroken.Arrow___Left_2),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children:
              [
                defaultTextFormField(
                  controller: searchController,
                  type: TextInputType.text,
                  onChanged: (value)
                  {
                    AdminCubit.get(context).getSearchUsers(value);

                  },

                  validate: (String? value)
                  {
                    if(value!.isEmpty)
                    {
                      return 'search must not be empty';

                    }
                    return null;

                  },
                  hintText: 'search',
                  prefix: IconBroken.Search,
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(

                  child: ConditionalBuilder(
                    condition:  list.length >0,
                    builder: (context) => ListView.separated(
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context,index) => BuildUserItem(list[index],context),
                        separatorBuilder: (context,index) =>  SizedBox(height: 8,),
                        itemCount: list.length),
                    fallback: (context) => Center(child: Container()),
                  ),
                ),



              ],
            ),
          ),

        );

      },

    );

  }

}