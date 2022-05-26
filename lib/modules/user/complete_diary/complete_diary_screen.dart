import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/layout/home-layout/cubit/cubit.dart';
import 'package:gp/layout/home-layout/cubit/states.dart';
import 'package:gp/models/meals_model.dart';
import 'package:gp/modules/user/meal_item/meal_item_screen.dart';
import 'package:gp/shared/componants/componants.dart';
import 'package:gp/shared/componants/constant.dart';
import 'package:gp/shared/cubit/cubit.dart';
import 'package:gp/shared/localization/app_localization%20.dart';
import 'package:gp/shared/styles/colors.dart';
import 'package:gp/shared/styles/icon_broken.dart';
import 'package:intl/intl.dart';
class CompleteDiaryScreen extends StatefulWidget {

  @override
  State<CompleteDiaryScreen> createState() => _CompleteDiaryScreenState();



}

class _CompleteDiaryScreenState extends State<CompleteDiaryScreen> {
  @override
  void initState(){
    HomeCubit.get(context).getCompleteDiaryItems(selectedDate: DateTime.now());
  }

  DateTime selectedDate = DateTime.now()  ;

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
                    defaultContainer(
                      context,
                      width: double.infinity,
                      child: TextButton(
                        onPressed: () {
                          print('omar essam $selectedDate');
                          pickDate(context);
                        },
                        child: defaultBodyText(
                          context,
                          text: '${DateFormat('yyyy-MM-dd').format(selectedDate)}',
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    ConditionalBuilder(
                        condition: HomeCubit.get(context).completeDiaryByDate.length > 0 && state is !GetAllUsersMealsLoadingState,
                        builder: (context) => ListView.separated(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) => buildCompleteDiaryItem(HomeCubit.get(context).completeDiaryByDate[index],context,index),
                          separatorBuilder: (context, index) => SizedBox(height: 10,),
                          itemCount: HomeCubit.get(context).completeDiaryByDate.length,
                        ),
                        fallback: (context) => Center(
                          child: Column(
                            children: [
                              Icon(IconBroken.Bookmark,color: Colors.grey,),
                              SizedBox(height: 20,),
                              defaultHeadLineText(context, text: 'No Meals Yet',color: Colors.grey),
                            ],
                          ),
                        )
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
      HomeCubit.get(context).deleteCompleteDiaryItem(model.id.toString());

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
                    if(lan=='en')
                      defaultBodyText(
                        context,
                        text: '${model.Food}',
                      fontWeight: FontWeight.bold,
                      maxLines: 1,
                    ),
                    if(lan=='ar')
                      defaultBodyText(
                        context,
                        text: '${model.foodAr}',
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
                    HomeCubit.get(context).deleteCompleteDiaryItem(model.id.toString());
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

  pickDate(BuildContext context)async{
    DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2022),
      lastDate: DateTime(2205),
    );
    if(selected != null && selected != selectedDate)
      {

        setState(() {
          selectedDate = selected ;
          HomeCubit.get(context).getCompleteDiaryItems(selectedDate: selectedDate);
        });
      }
  }

}