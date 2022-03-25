import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/layout/home-layout/cubit/cubit.dart';
import 'package:gp/layout/home-layout/cubit/states.dart';
import 'package:gp/shared/componants/componants.dart';

class BreakFastScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     return BlocConsumer<HomeCubit,HomeStates>(
      listener: (context,state)
      {

      },
      builder: (context,state)
      {
        var list = HomeCubit.get(context).searchBreakFast;
        return  buildSerachMealItem(list, context, title: 'BreakFast',
          onChangedSearch: (value )
          {
            HomeCubit.get(context).getSearchBreakFast(value);
          },
          isChecked: HomeCubit.get(context).isCheckedBreakFast,
          //value: isChecked,
          /*onChanged: (value)
          {
            HomeCubit.get(context).changeCheckBoxLunch(value, index);
          },*/
          changeChekBox: HomeCubit.get(context).changeCheckBoxBreakFast,
            function: ()
            {
              HomeCubit.get(context).addBreakFastMeal();
            }
        );
      },
    );
  }
}
