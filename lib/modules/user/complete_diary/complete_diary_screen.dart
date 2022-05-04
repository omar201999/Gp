import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/layout/home-layout/cubit/cubit.dart';
import 'package:gp/layout/home-layout/cubit/states.dart';
import 'package:gp/models/meals_model.dart';
import 'package:gp/modules/user/meal_item/meal_item_screen.dart';
import 'package:gp/shared/componants/componants.dart';
import 'package:gp/shared/cubit/cubit.dart';
import 'package:gp/shared/localization/app_localization%20.dart';
import 'package:gp/shared/styles/colors.dart';
import 'package:gp/shared/styles/icon_broken.dart';
class CompleteDiaryScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
        listener: (context, state)
        {

        },
        builder: (context,state)
        {
          return Scaffold(
            appBar: buildAppBar(
              title: AppLocalizations.of(context).translate("complete_daily"),//'Complete Diary',
              icon: IconBroken.Arrow___Left_2,
              onPressed: ()
              {
                Navigator.pop(context);
              },
            ),
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    ConditionalBuilder(
                        condition: HomeCubit.get(context).completeDiary.length > 0 && state is !GetAllUsersMealsLoadingState,
                        builder: (context) => ListView.separated(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) => buildCompleteDiaryItem(HomeCubit.get(context).completeDiary[index],context,index),
                          separatorBuilder: (context, index) => SizedBox(height: 10,),
                          itemCount: HomeCubit.get(context).completeDiary.length,
                        ),
                        fallback: (context) => Center(child: CircularProgressIndicator())
                    ),
                  ],
                ),
              ),
            ),
          );

        }
    );
  }

  Widget buildCompleteDiaryItem(MealsModel model,context,index)=> Dismissible(
    key: Key(model.Food!),
    onDismissed: (direction)
    {
      HomeCubit.get(context).deleteCompleteDiaryItem(HomeCubit.get(context).completeDiaryId[index]);
      ScaffoldMessenger.of(context)
          .showSnackBar(
          SnackBar(
            backgroundColor:AppCubit.get(context).constantColor1 ,
            content: defaultBodyText(context, text: AppLocalizations.of(context).translate("delete_diary_message")),
            duration: const Duration(seconds: 2),
          )
      );
    },
    background: Container(
      //alignment: Alignment.centerLeft,
      child:Padding(
        padding: const EdgeInsets.all(8.0),
        child: defaultHeadLineText(context, text: AppLocalizations.of(context).translate("Delete this meal"),color: Colors.white),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration:BoxDecoration(
        color: defaultColor,//HexColor('#4d4d4d')
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    child: InkWell(
      onTap: ()
      {
        /*navigateTo(context, MealItemScreen(
          mealsModel: model,
        ));*/
        showDialog(
            context: context,
            builder: (context) => MealItemScreen(mealsModel: model),
          barrierDismissible: true,
        );
      },
      child: defaultContainer(
        context,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    defaultBodyText(
                        context,
                        text: '${model.Food}',
                      fontWeight: FontWeight.bold,
                      maxLines: 1,
                    ),
                    Row(
                      children: [
                        Text('${model.Calories} ${AppLocalizations.of(context).translate("cal")},' ,style: Theme.of(context).textTheme.caption,),
                        SizedBox(width: 3,),
                        Text('${model.Protein}${AppLocalizations.of(context).translate("Protein")},',style: Theme.of(context).textTheme.caption,),
                        SizedBox(width: 3,),
                        Text('${model.Carbs}${AppLocalizations.of(context).translate("Carbs")},',style: Theme.of(context).textTheme.caption,),
                        SizedBox(width: 3,),
                        Text('${model.Fat}${AppLocalizations.of(context).translate("Fats")}',style: Theme.of(context).textTheme.caption,),
                        SizedBox(width: 3,)
                      ],
                    ) ,
                  ],
                ),
              ),
              IconButton(
                  icon: Icon(
                      Icons.delete_forever
                  ),
                  onPressed: () {
                    HomeCubit.get(context).deleteCompleteDiaryItem(HomeCubit.get(context).completeDiaryId[index]);
                    ScaffoldMessenger.of(context)
                        .showSnackBar(
                        SnackBar(
                          backgroundColor:AppCubit.get(context).constantColor1 ,
                          content: defaultBodyText(context, text: AppLocalizations.of(context).translate("delete_diary_message")),
                          duration: const Duration(seconds: 2),
                        )
                    );
                  }
              ),
            ],
          ),
        ),
      ),
    ),
  );
}