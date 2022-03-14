import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gp/shared/componants/componants.dart';
import 'package:gp/shared/styles/colors.dart';
import 'package:gp/shared/styles/icon_broken.dart';

class RecipeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(title: 'Recipe'),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
              [
                /*defaultContainer(

                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: defaultTextFormField(
                      type: TextInputType.text,
                      prefix: IconBroken.Search,
                      hintText: 'Search',
                      border: InputBorder.none,
                    ),
                  ),
                ),*/

                defaultContainer(
                  height: 65,
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                        hintText: 'Search',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(15.0),
                            ),
                            borderSide: BorderSide.none
                        ),
                        prefixIcon: Icon(IconBroken.Search),
                        filled: true,
                        fillColor: constantColor5
                    ),
                  ),
                ),
                headOfRecipeItem(context,head: 'Breakfast'),
                Container(
                  height: 290,
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder:(context,index) => buildRecipeItem(context),
                      separatorBuilder: (context,index) => SizedBox(width: 10,),
                      itemCount: 15 ),
                ),
                headOfRecipeItem(context,head: 'Lunch'),
                Container(
                  height: 290,
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder:(context,index) => buildRecipeItem(context),
                      separatorBuilder: (context,index) => SizedBox(width: 10,),
                      itemCount: 15 ),
                ),
                headOfRecipeItem(context,head: 'Dinner'),
                Container(
                  height: 280,
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder:(context,index) => buildRecipeItem(context),
                      separatorBuilder: (context,index) => SizedBox(width: 10,),
                      itemCount: 15 ),
                ),
                headOfRecipeItem(context,head: 'Snacks'),
                Container(
                  height: 280,
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



