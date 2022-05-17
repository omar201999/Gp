import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glass/glass.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gp/layout/home-layout/cubit/cubit.dart';
import 'package:gp/layout/home-layout/cubit/states.dart';
import 'package:gp/models/recipes_model.dart';
import 'package:gp/shared/componants/componants.dart';
import 'package:gp/shared/componants/constant.dart';
import 'package:gp/shared/cubit/cubit.dart';
import 'package:gp/shared/localization/app_localization%20.dart';
import 'package:gp/shared/styles/colors.dart';
import 'package:gp/shared/styles/icon_broken.dart';
import 'package:hexcolor/hexcolor.dart';

class RecipeItemScreen extends StatefulWidget {

  RecipeModel recipeModel;
  RecipeItemScreen({
   required this.recipeModel,
});

  @override
  State<RecipeItemScreen> createState() => _RecipeItemScreenState();
}

class _RecipeItemScreenState extends State<RecipeItemScreen>
{

  double? rating = 3 ;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
    listener: (context,state){},
      builder: (context,state)
      {
        return Scaffold(
          //backgroundColor: Colors.grey[50],
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children:
              [
                Stack(
                  children:
                  [
                    Container(
                      width: double.infinity,
                      height: 400,
                      decoration:  BoxDecoration(
                        image: DecorationImage(
                          image:NetworkImage('${widget.recipeModel.image}'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(
                          top: 40,
                         start: 8,
                      ),
                      child: Container(
                        height: 40,
                        width: 40,
                        child: IconButton(
                          color: defaultColor,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon( IconBroken.Arrow___Left_2, ),
                        ),
                      ).asGlass(
                        tintColor: Colors.transparent,
                        clipBorderRadius: BorderRadius.circular(50.0),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:
                    [
                      defaultContainer(
                        context,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if(lan =='en')
                              defaultHeadLineText(
                                  context,
                                  text:  '${widget.recipeModel.title}',
                                  maxLines: 2
                              ),
                              if(lan =='ar')
                                defaultHeadLineText(
                                    context,
                                    text:  '${widget.recipeModel.titleAr}',
                                    maxLines: 2
                                ),
                            ],
                          ),
                        ),
                        width: double.infinity,
                        height: 100,
                      ),
                      const SizedBox(height: 15,),
                      defaultContainer(
                        context,
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Column(
                                children:
                                [
                                  defaultHeadLineText(
                                      context,
                                      text: widget.recipeModel.averageRating!.toStringAsFixed(1),fontSize: 40,
                                  ),
                                  Text(
                                    AppLocalizations.of(context).translate("Avg rating"),
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                width: 3,
                                height: 110,
                                color: HexColor('#FE617E'),//#FF5A53#ED2C47#FE617E
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    defaultHeadLineText(context, text: AppLocalizations.of(context).translate("Rate This Recipe"),),
                                    RatingBar.builder(
                                      initialRating: rating!,
                                      //minRating: 1,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      updateOnDrag: true,
                                      itemCount: 5,
                                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                      itemBuilder: (context, _) => Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      onRatingUpdate: (rating)
                                      {
                                        this.rating = rating;
                                      },
                                    ),
                                    defaultTextButton(
                                        context,
                                        function: ()
                                        {
                                          HomeCubit.get(context).updateRecipe(
                                            widget.recipeModel.uId!,
                                            image: widget.recipeModel.image!,
                                            calories: widget.recipeModel.calories!,
                                            carbs: widget.recipeModel.carbs!,
                                            category: widget.recipeModel.category!,
                                            directions: widget.recipeModel.directions!,
                                            fats: widget.recipeModel.fats!,
                                            ingredients: widget.recipeModel.ingredients!,
                                            protein: widget.recipeModel.protein!,
                                            title: widget.recipeModel.title!,
                                            //weight: widget.recipeModel.weight!,
                                            averageRating: (widget.recipeModel.totalRating! + rating!) / (widget.recipeModel.numOfRates! + 1)  ,
                                            numOfRates: widget.recipeModel.numOfRates! + 1 ,
                                            totalRating:widget.recipeModel.totalRating! + rating!,
                                            uId: widget.recipeModel.uId!,
                                            directionsAr: widget.recipeModel.directionsAr!,
                                            ingredientsAr:widget.recipeModel.ingredientsAr!,
                                            titleAr: widget.recipeModel.titleAr!,


                                          );
                                        },
                                        text: 'Send'
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 15,),

                      defaultContainer(
                        context,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              defaultHeadLineText(
                                  context, text:AppLocalizations.of(context).translate("Nutrition Per Serving")),// 'Nutrition Per Serving'),
                              const SizedBox(height: 5,),
                              Row(
                                children: [
                                  Expanded(
                                    child: CircleAvatar(
                                      backgroundColor: defaultColor,
                                      radius: 40,
                                      child: CircleAvatar(
                                        radius: 35,
                                        backgroundColor:Colors.white,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment
                                              .center,
                                          children:
                                          [
                                            defaultBodyText(context, text: '${widget.recipeModel.calories}',
                                                fontWeight: FontWeight.bold,color: defaultColor),
                                            defaultBodyText(context, text: AppLocalizations.of(context).translate("cal"),//'Cal',
                                                color: Colors.grey),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  afterTitleOfRecipeItem(context, //percentage: '17%',
                                      numberOfGrams: '${widget.recipeModel.carbs}',
                                      nameOfType: AppLocalizations.of(context).translate("Carbs"),//'Carbs',
                                      color: Colors.grey),
                                  afterTitleOfRecipeItem(context, //percentage: '5%',
                                      numberOfGrams: '${widget.recipeModel.protein}',
                                      nameOfType: AppLocalizations.of(context).translate("Protein"),//'Proteins',
                                      color: Colors.red),
                                  afterTitleOfRecipeItem(context, //percentage: '2%',
                                      numberOfGrams: '${widget.recipeModel.fats}',
                                      nameOfType: AppLocalizations.of(context).translate("Fats"),//'Fats',
                                      color: defaultColor),

                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),


                      defaultContainer(
                          context,
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                defaultHeadLineText(context, text: AppLocalizations.of(context).translate("Ingredients")),//'Ingredients'),
                                const SizedBox(height: 5),
                                if(lan=='en')
                                defaultBodyText(context,
                                    text: '${widget.recipeModel.ingredients}'
                                ),
                                if(lan=='ar')
                                  defaultBodyText(context,
                                      text: '${widget.recipeModel.ingredientsAr}'
                                  ),
                              ],
                            ),
                          )
                      ),

                      const SizedBox(
                        height: 15,
                      ),

                      defaultContainer(
                          context,
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                defaultHeadLineText(context, text: AppLocalizations.of(context).translate("Directions")),//'Directions'),
                                const SizedBox(height: 5,),
                                if(lan=='en')
                                defaultBodyText(context,
                                  text: '${widget.recipeModel.directions}',
                                ),
                                if(lan=='ar')
                                  defaultBodyText(context,
                                    text: '${widget.recipeModel.directionsAr}',
                                  ),
                              ],
                            ),
                          )
                      ),

                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton.extended(
              foregroundColor: Colors.white,
              onPressed: ()
              {
              if(HomeCubit.get(context).calculateTotalFoodCalories()! >= (HomeCubit.get(context).userModel!.totalCalorie)!.round() )
              {
                //AppLocalizations.of(context).translate("  "),//
                showToast(text: '${AppLocalizations.of(context).translate("validate_Food")} ${HomeCubit.get(context).userModel!.totalCalorie} ${AppLocalizations.of(context).translate("and your total food is")} ${HomeCubit.get(context).totalFood} ', state: ToastStates.WARNING);
              }
              else
              {
                HomeCubit.get(context).addRecipeToMeals(
                  title: widget.recipeModel.title,
                    calories: (widget.recipeModel.calories)!.round(),
                    carbs: (widget.recipeModel.carbs)!.round(),
                    fat: (widget.recipeModel.fats)!.round(),
                    protein: (widget.recipeModel.protein)!.round(),
                    //Date: DateFormat.yMMMEd().format(DateTime.now())
                  );
                ScaffoldMessenger.of(context)
                    .showSnackBar(
                    SnackBar(
                      backgroundColor:AppCubit.get(context).constantColor1 ,
                      content: defaultBodyText(context, text: AppLocalizations.of(context).translate("Recipe_add")),
                      duration: const Duration(seconds: 2),
                    )
                );

              }
              },
              label: Text(AppLocalizations.of(context).translate("Add to yours Meal")),//'Add to yours Meal'),

            ),


        );
      },
    );
  }
}
