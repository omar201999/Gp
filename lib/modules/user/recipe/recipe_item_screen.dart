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

class CurvePainter extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
   path.lineTo(0,size.height-40);
    path.quadraticBezierTo(size.width / 4, size.height , size.width / 2, size.height);
    path.quadraticBezierTo(size.width - (size.width / 4), size.height , size.width, size.height-40);
    path.lineTo(size.width, 0);
    return path;
  }
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
class RecipeItemScreen extends StatefulWidget {

  RecipeModel recipeModel;
  int index;
  RecipeItemScreen({
   required this.recipeModel,
   required this.index,
});

  @override
  State<RecipeItemScreen> createState() => _RecipeItemScreenState();
}

class _RecipeItemScreenState extends State<RecipeItemScreen>
{
  @override
  void initState() {
    super.initState();
    if(HomeCubit.get(context).favoritesRecipes.isNotEmpty)
    {
     for(int i=0;i < HomeCubit.get(context).favoritesRecipes.length;i++)
     {
       if(HomeCubit.get(context).favoritesRecipes[i].uId == widget.recipeModel.uId)
       {
         setState(() {
           HomeCubit.get(context).isFavorite[widget.index]=true;
         });
       }
     }
    }
    else
    {
      setState(() {
        HomeCubit.get(context).isFavorite[widget.index]=false;
      });
    }
  }

  double? rating = 3 ;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
    listener: (context,state){},
      builder: (context,state)
      {
        return Scaffold(
          //backgroundColor: Colors.grey[50],
          body: SafeArea(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children:
                [
                  Stack(
                    alignment: Alignment.topLeft,
                    children: [
                      ClipPath(
                        clipper: CurvePainter(),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 400,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              //alignment: Alignment.center,
                              image:NetworkImage('${widget.recipeModel.image}'
                              ),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.only(
                              top: 5,
                              start: 10
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
                          Spacer(),
                          Padding(
                            padding: const EdgeInsetsDirectional.only(
                                top: 5,
                                end: 5
                            ),
                            child: Container(
                              height: 40,
                              width: 40,
                              child: IconButton(
                                color: defaultColor,
                                onPressed: ()
                                {
                                  HomeCubit.get(context).changeFavorites(widget.index);
                                  if(HomeCubit.get(context).isFavorite[widget.index]==true)
                                  {
                                    HomeCubit.get(context).addRecipeToFavorites(
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
                                      averageRating: widget.recipeModel.averageRating! ,
                                      numOfRates: widget.recipeModel.numOfRates! ,
                                      totalRating:widget.recipeModel.totalRating! ,
                                      recId: widget.recipeModel.uId!,
                                      directionsAr: widget.recipeModel.directionsAr!,
                                      ingredientsAr:widget.recipeModel.ingredientsAr!,
                                      titleAr: widget.recipeModel.titleAr!,
                                      isFavorite: true,
                                    );
                                  }
                                  else
                                    {
                                      HomeCubit.get(context).deleteFavoritesRecipes(widget.recipeModel.uId!,);
                                    }
                                },
                                icon: Icon(
                                    Icons.favorite,
                                    color: HomeCubit.get(context).isFavorite[widget.index]? Color(0xffe41e3f) : Colors.grey,
                                ),
                              ),
                            ).asGlass(
                              tintColor: Colors.black,
                              clipBorderRadius: BorderRadius.circular(50.0),
                            ),
                          ),

                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                      [
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


                        const SizedBox(height: 15,),
                      Row(
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
                            color: Color(0xfffe617e),//#FF5A53#ED2C47#FE617E
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                defaultHeadLineText(context, text: AppLocalizations.of(context).translate("Rate This Recipe"),),
                                RatingBar.builder(
                                  initialRating: (widget.recipeModel.averageRating)!.toDouble(),
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
                                        //isFavorite: widget.recipeModel.isFavorite!,
                                      );
                                      if(HomeCubit.get(context).favoritesRecipes.isNotEmpty)
                                      {
                                        for(int i=0;i < HomeCubit.get(context).favoritesRecipes.length;i++)
                                        {
                                          if(HomeCubit.get(context).favoritesRecipes[i].uId == widget.recipeModel.uId)
                                          {
                                            HomeCubit.get(context).updateFavoriteRecipe(
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
                                              uId1: widget.recipeModel.uId!,
                                              directionsAr: widget.recipeModel.directionsAr!,
                                              ingredientsAr:widget.recipeModel.ingredientsAr!,
                                              titleAr: widget.recipeModel.titleAr!,
                                              //isFavorite: widget.recipeModel.isFavorite!,
                                            );
                                          }
                                        }
                                      }
                                    },
                                    text: 'Send'
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                        const SizedBox(height: 10,),
                        defaultHeadLineText(
                          context, text: AppLocalizations.of(context).translate("Nutrition Per Serving"),//'Nutrition Per Serving',
                        ),
                        Row(
                          children:
                          [
                            //'${widget.recipeModel.carbs}g' AppLocalizations.of(context).translate("Carbs")
                            buildNutritionItemForRecipeItemScreen(
                                context,
                              imagePath:  'assets/images/cereal-grain-svgrepo-com.svg',
                              numOFNutrition: '${widget.recipeModel.carbs}${AppLocalizations.of(context).translate("g")}',
                              typeOFNutrition: AppLocalizations.of(context).translate("Carbs2"),
                            ),
                            buildNutritionItemForRecipeItemScreen(
                                context,
                              imagePath:  'assets/images/avocado-svgrepo-com (1).svg',
                              numOFNutrition: '${widget.recipeModel.protein}${AppLocalizations.of(context).translate("g")}',
                              typeOFNutrition: AppLocalizations.of(context).translate("Protein1"),
                            ),
                            buildNutritionItemForRecipeItemScreen(
                                context,
                              imagePath:  'assets/images/fire-svgrepo-com.svg',
                              numOFNutrition: '${widget.recipeModel.calories}${AppLocalizations.of(context).translate("g")}',
                              typeOFNutrition: AppLocalizations.of(context).translate("cal1"),
                            ),
                            buildNutritionItemForRecipeItemScreen(
                                context,
                              imagePath: 'assets/images/pizza.svg',
                              numOFNutrition: '${widget.recipeModel.fats}${AppLocalizations.of(context).translate("g")}',
                              typeOFNutrition: AppLocalizations.of(context).translate("Fats1"),
                            ),
                          ],
                        ),

                        const SizedBox(
                          height: 15,
                        ),
                      Column(
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

                        const SizedBox(
                          height: 15,
                        ),

                      Column(
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
                      )
                        ,

                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
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
                  widget.recipeModel.uId!,
                  title: widget.recipeModel.title,
                    calories: (widget.recipeModel.calories)!.round(),
                    carbs: (widget.recipeModel.carbs)!.round(),
                    fat: (widget.recipeModel.fats)!.round(),
                    protein: (widget.recipeModel.protein)!.round(),
                  foodAr: widget.recipeModel.titleAr,
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
