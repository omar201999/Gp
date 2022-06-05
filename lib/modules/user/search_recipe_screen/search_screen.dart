import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/layout/admin_layout/cubit/cubit.dart';
import 'package:gp/layout/admin_layout/cubit/states.dart';
import 'package:gp/shared/componants/componants.dart';
import 'package:gp/shared/componants/constant.dart';
import 'package:gp/shared/localization/app_localization%20.dart';

class SearchRecipeScreen extends StatelessWidget {

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

        var list = AdminCubit.get(context).searchRecipe;
        return Scaffold(
          appBar: AppBar(
            title: Text(AppLocalizations.of(context).translate("search")),
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
                    AdminCubit.get(context).getSearchRecipe(value,lan!);

                  },

                  validate: (String? value)
                  {
                    if(value!.isEmpty)
                    {
                      return AppLocalizations.of(context).translate("search must not be empty");

                    }
                    return null;

                  },
                  hintText: AppLocalizations.of(context).translate("search"),
                  prefix: Icons.search,
                ),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(

                    child: ConditionalBuilder(
                    condition:  list.length >0,
                    builder: (context) => ListView.separated(
                    physics: const BouncingScrollPhysics(), // بتشيل الload اللي فوق دا بيخليه ينط كدا
                    itemBuilder: (context,index) => buildRecipeItem(list[index],context,index),
                        separatorBuilder: (context,index) =>  const SizedBox(height: 8,),
                    itemCount: list.length
                    ),
                      fallback: (context) =>  ListView.separated(
                          physics: const BouncingScrollPhysics(), // بتشيل الload اللي فوق دا بيخليه ينط كدا
                          itemBuilder: (context,index) => buildRecipeItem(AdminCubit.get(context).allRecipe[index],context,index),
                          separatorBuilder: (context,index) =>  const SizedBox(height: 8,),
                          itemCount: AdminCubit.get(context).allRecipe.length
                      ),
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
