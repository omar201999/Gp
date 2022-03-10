import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gp/modules/recipe/recipe_item_screen.dart';
import 'package:gp/shared/componants/componants.dart';

class RecipeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(title: 'Reciepe'),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
              [
                defaultContainer(
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: defualtTextFormField(
                      type: TextInputType.text,
                      prefix: Icons.search,
                      hintText: 'Search',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                headOfRecipeItem(context,head: 'Breack Fast'),
                Container(
                  height: 250,
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder:(context,index) => buildRecipeItem(context),
                      separatorBuilder: (context,index) => SizedBox(width: 10,),
                      itemCount: 15 ),
                ),
                headOfRecipeItem(context,head: 'Lunch'),
                Container(
                  height: 250,
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder:(context,index) => buildRecipeItem(context),
                      separatorBuilder: (context,index) => SizedBox(width: 10,),
                      itemCount: 15 ),
                ),
                headOfRecipeItem(context,head: 'Dinner'),
                Container(
                  height: 250,
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder:(context,index) => buildRecipeItem(context),
                      separatorBuilder: (context,index) => SizedBox(width: 10,),
                      itemCount: 15 ),
                ),
                headOfRecipeItem(context,head: 'Snacks'),
                Container(
                  height: 250,
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder:(context,index) => buildRecipeItem(context),
                      separatorBuilder: (context,index) => SizedBox(width: 10,),
                      itemCount: 15 ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



