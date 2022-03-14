import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gp/shared/componants/componants.dart';
import 'package:gp/shared/styles/colors.dart';
class RecipeItemScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.grey[50],
      body: SingleChildScrollView(
        child: Column(
          children:
          [
            Stack(
              children:
              [
                Container(
                  width: double.infinity,
                  height: 350,
                  decoration:  BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/Recipe1.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                      top: 30
                  ),
                  child: IconButton(
                    color: Colors.white,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon( Icons.arrow_back, ),
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
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          defaultHeadLineText(
                              context,
                              text: 'Chargrilled Broccolini with Blanco Queso',
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
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          defaultHeadLineText(
                              context, text: 'Nutrition Per Serving'),
                          const SizedBox(height: 5,),
                          Row(
                            children: [
                              Expanded(
                                child: CircleAvatar(
                                  backgroundColor: defaultColor,
                                  radius: 40,
                                  child: CircleAvatar(
                                    radius: 35,
                                    backgroundColor: Colors.white,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment
                                          .center,
                                      children:
                                      [
                                        defaultBodyText(context, text: '220',
                                            fontWeight: FontWeight.bold),
                                        defaultBodyText(context, text: 'Cal',
                                            color: Colors.grey),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              afterTitleOfRecipeItem(context, percentage: '17%',
                                  numberOfGrams: '9.5g',
                                  nameOfType: 'Carbs',
                                  color: Colors.grey),
                              afterTitleOfRecipeItem(context, percentage: '5%',
                                  numberOfGrams: '30g',
                                  nameOfType: 'Proteins',
                                  color: Colors.red),
                              afterTitleOfRecipeItem(context, percentage: '2%',
                                  numberOfGrams: '6g',
                                  nameOfType: 'Fats',
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
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            defaultHeadLineText(context, text: 'Ingredients'),
                            const SizedBox(height: 5,),
                            ListView.separated(
                                padding: const EdgeInsetsDirectional.only(
                                    top: 5,
                                    start: 5
                                ),
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) =>
                                    defaultBodyText(context,
                                        text: '1 pound broccolini stalks'),
                                separatorBuilder: (context, index) =>
                                const SizedBox(height: 5,),
                                itemCount: 5
                            ),
                          ],
                        ),
                      )
                  ),

                  const SizedBox(
                    height: 15,
                  ),

                  defaultContainer(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            defaultHeadLineText(context, text: 'Directions'),
                            const SizedBox(height: 5,),
                            ListView.separated(
                                padding: const EdgeInsetsDirectional.only(
                                    top: 5,
                                    start: 5
                                ),
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) =>
                                    defaultBodyText(context,
                                      text: 'In a large saucepan over medium heat, combine marshmallow cream, sugar, evaporated milk, butter and salt. Bring to a full boil, and cook for 5 minutes, stirring constantly.',
                                    ),
                                separatorBuilder: (context, index) =>
                                const SizedBox(height: 5,),
                                itemCount: 10
                            ),
                          ],
                        ),
                      )
                  ),


                ],
              ),
            ),
          ],
        ),
      ),

    );
  }
}
