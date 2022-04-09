import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/layout/home-layout/cubit/cubit.dart';
import 'package:gp/layout/home-layout/cubit/states.dart';
import 'package:gp/models/meals_model.dart';
import 'package:gp/modules/user/meal_item/meal_item_screen.dart';
import 'package:gp/shared/componants/componants.dart';
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
              title: 'Complete Diary',
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
                        condition: HomeCubit.get(context).completeDiary.length > 0,
                        builder: (context) => ListView.separated(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) => buildCompleteDiaryItem(HomeCubit.get(context).completeDiary[index],context),
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

  Widget buildCompleteDiaryItem(MealsModel model,context)=> InkWell(
    onTap: ()
    {
      navigateTo(context, MealItemScreen(
        mealsModel: model,
      ));
    },
    child: defaultContainer(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                defaultHeadLineText(context, text: '${model.Food}'),
                Row(
                  children: [
                    Text('${model.Calories} cal,' ,style: Theme.of(context).textTheme.caption,),
                    SizedBox(width: 3,),
                    Text('${model.Protein}g Protein,',style: Theme.of(context).textTheme.caption,),
                    SizedBox(width: 3,),
                    Text('${model.Carbs}g Carbs,',style: Theme.of(context).textTheme.caption,),
                    SizedBox(width: 3,),
                    Text('${model.Fat}g Fats',style: Theme.of(context).textTheme.caption,),
                    SizedBox(width: 3,)
                  ],
                ) ,
              ],
            ),
            Spacer(),
            IconButton(
                icon: Icon(
                    Icons.delete_forever
                ),
                onPressed: () {

                }
            ),
          ],
        ),
      ),
    ),
  );
}