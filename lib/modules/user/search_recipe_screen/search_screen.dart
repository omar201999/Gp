import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/layout/home-layout/cubit/cubit.dart';
import 'package:gp/layout/home-layout/cubit/states.dart';
import 'package:gp/shared/componants/componants.dart';

class SearchRecipeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context)
  {
    var searchController = TextEditingController();
    return BlocConsumer<HomeCubit,HomeStates>(
      listener: (context,state)
      {

      },
      builder: (context,state)
      {
        var list = HomeCubit.get(context).search;


        return Scaffold(
          appBar: AppBar(),
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
                    HomeCubit.get(context).getSearch(value);

                  },

                  validate: (String? value)
                  {
                    if(value!.isEmpty)
                    {
                      return 'search must not be empty';

                    }
                    return null;

                  },
                  label: 'serach',
                  prefix: Icons.search,
                ),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(

                    child: ConditionalBuilder(
                    condition:  list.length >0,
                    builder: (context) => ListView.separated(
                    physics: BouncingScrollPhysics(), // بتشيل الload اللي فوق دا بيخليه ينط كدا
                    itemBuilder: (context,index) => buildRecipeItem(list[index],context),
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
