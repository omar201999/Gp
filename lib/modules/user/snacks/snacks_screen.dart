import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/layout/home-layout/cubit/cubit.dart';
import 'package:gp/layout/home-layout/cubit/states.dart';
import 'package:gp/shared/componants/componants.dart';
import 'package:gp/shared/localization/app_localization%20.dart';

class SnacksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
      listener: (context,state)
      {

      },
      builder: (context,state)
      {
        var list = HomeCubit.get(context).searchSnacks;
        return  buildSerachMealItem(list, context, title: AppLocalizations.of(context).translate("snacks"),//'Snacks',
          onChangedSearch: (value )
          {
            HomeCubit.get(context).getSearchSnacks(value);
          },
          isChecked: HomeCubit.get(context).isCheckedSnacks,
          //value: isChecked,
          /*onChanged: (value)
          {
            HomeCubit.get(context).changeCheckBoxLunch(value, index);
          },*/
          changeChekBox: HomeCubit.get(context).changeCheckBoxSnacks,
          function: ()
          {
            if(HomeCubit.get(context).calculateTotalFoodCalories()! >= (HomeCubit.get(context).userModel!.totalCalorie)!.round() )
            {
              showToast(text: '${AppLocalizations.of(context).translate("validate_Food")} ${HomeCubit.get(context).userModel!.totalCalorie} ${AppLocalizations.of(context).translate("and your total food is")} ${HomeCubit.get(context).totalFood} ', state: ToastStates.WARNING);
            }
            else
            {
              HomeCubit.get(context).addSnacksMeal();

            }
          }
        );
      },
    );
  }
}
