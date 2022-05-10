import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/layout/home-layout/cubit/cubit.dart';
import 'package:gp/layout/home-layout/cubit/states.dart';
import 'package:gp/shared/componants/componants.dart';
import 'package:gp/shared/componants/constant.dart';
import 'package:gp/shared/localization/app_localization%20.dart';

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
        return  buildSerachMealItem(list, context, title: AppLocalizations.of(context).translate("breakfast"),//'BreakFast',
          onChangedSearch: (value )
          {
            HomeCubit.get(context).getSearchBreakFast(value,lan!);
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
              if(HomeCubit.get(context).calculateTotalFoodCalories()! >= (HomeCubit.get(context).userModel!.totalCalorie)!.round() )
              {
                //Please reduce Your Meal your goal is
                //and your total food is
                showToast(text: '${AppLocalizations.of(context).translate("validate_Food")} ${HomeCubit.get(context).userModel!.totalCalorie} ${AppLocalizations.of(context).translate("and your total food is")} ${HomeCubit.get(context).totalFood} ', state: ToastStates.WARNING);
                HomeCubit.get(context).addBreakFastMeal();
              }else
              {
                HomeCubit.get(context).addBreakFastMeal();
              }

            }
        );
      },
    );
  }
}
