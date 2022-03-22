import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/layout/home-layout/cubit/cubit.dart';
import 'package:gp/layout/home-layout/cubit/states.dart';
import 'package:gp/models/meals_model.dart';
import 'package:gp/shared/componants/componants.dart';

class CompleteDiaryScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
      listener: (context, state) {

      },
        builder: (context,state) {
        MealsModel? meals = HomeCubit.get(context).meals;
        return Scaffold(
          appBar: buildAppBar(title: 'Complete Diary'),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  ListView.separated(
                      itemBuilder: (context,index) =>defaultContainer(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              defaultHeadLineText(context, text: '${meals?.Food}'),
                              Row(
                                children: [
                                  Text('${meals?.Calories}' ,style: Theme.of(context).textTheme.caption,),
                                  SizedBox(width: 10,),
                                  Text('${meals?.Protein}',style: Theme.of(context).textTheme.caption,),
                                  SizedBox(width: 10,),
                                  Text('${meals?.Carbs}',style: Theme.of(context).textTheme.caption,),
                                  SizedBox(width: 10,),
                                  Text('${meals?.Fat}',style: Theme.of(context).textTheme.caption,),
                                  SizedBox(width: 10,)
                                ],
                              ) ,
                            ],
                          ),
                        ),
                      ),
                      separatorBuilder: (context,index) => SizedBox(height: 10,),
                      itemCount: HomeCubit.get(context).comleteDiary.length,
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                  )
                ],
              ),
            ),
          ),
        );

        }
    );
  }
}
