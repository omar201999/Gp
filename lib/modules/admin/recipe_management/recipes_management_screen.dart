import 'package:flutter/material.dart';
import 'package:gp/modules/admin/recipe_management/edit_recipe/edit_recipe_screen.dart';
import 'package:gp/modules/admin/recipe_management/new_recipe/new_recipe_screen.dart';
import 'package:gp/shared/componants/componants.dart';
import 'package:gp/shared/styles/colors.dart';
import 'package:gp/shared/styles/icon_broken.dart';

class RecipesManagementScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
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

                SizedBox(
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
                const SizedBox(
                  height: 20.0,
                ),
                Column(
                 children: [
                   Row(
                     children: [
                       //headOfRecipeItem(context,head: 'Snacks'),
                       defaultHeadLineText(
                       context,
                       text: 'Breakfast',
                       ),
                       const Spacer(),
                       IconButton(
                           onPressed: () {
                             navigateTo(context, NewRecipeScreen());
                           },
                           icon:  Icon(IconBroken.Paper_Upload)
                       )
                     ],
                   ),
                   Container(
                     height: 280,
                     child: ListView.separated(
                         scrollDirection: Axis.horizontal,
                         itemBuilder:(context,index) => buildRecipe(context),
                         separatorBuilder: (context,index) => const SizedBox(width: 10,),
                         itemCount: 15 ),
                   ),
                 ],
               ),
                const SizedBox(
                  height: 10.0,
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        //headOfRecipeItem(context,head: 'Snacks'),
                        defaultHeadLineText(
                          context,
                          text: 'Lunch',
                        ),
                        const Spacer(),
                        IconButton(
                            onPressed: () {
                              navigateTo(context, NewRecipeScreen());
                            },
                            icon: const Icon(
                                IconBroken.Paper_Upload,
                                //size: 15,
                            )
                        )
                      ],
                    ),
                    Container(
                      height: 280,
                      child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder:(context,index) => buildRecipe(context),
                          separatorBuilder: (context,index) => const SizedBox(width: 10,),
                          itemCount: 15 ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        //headOfRecipeItem(context,head: 'Snacks'),
                        defaultHeadLineText(
                          context,
                          text: 'Dinner',
                        ),
                        const Spacer(),
                        IconButton(
                            onPressed: () {
                              navigateTo(context, NewRecipeScreen());
                            },
                            icon: const Icon(IconBroken.Paper_Upload)
                        )
                      ],
                    ),
                    Container(
                      height: 280,
                      child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder:(context,index) => buildRecipe(context),
                          separatorBuilder: (context,index) => const SizedBox(width: 10,),
                          itemCount: 15 ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        //headOfRecipeItem(context,head: 'Snacks'),
                        defaultHeadLineText(
                          context,
                          text: 'Snacks',
                        ),
                        const Spacer(),
                        IconButton(
                            onPressed: () {
                              navigateTo(context, NewRecipeScreen());
                            },
                            icon: const Icon(IconBroken.Paper_Upload)
                        )
                      ],
                    ),
                    Container(
                      height: 280,
                      child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder:(context,index) => buildRecipe(context),
                          separatorBuilder: (context,index) => const SizedBox(width: 10,),
                          itemCount: 15 ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}

Widget buildRecipe(context) => defaultGesterDetecter(
  onTap: ()
  {
    navigateTo(context, EditRecipeScreen());
  },
  child: defaultContainer(
    //height: 250,
    width: 170,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
      [
        const Expanded(
          flex: 4,
          child: Image(
            image: AssetImage('assets/images/Recipe1.jpg'),
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Expanded(
          child: Padding(
            padding: /*EdgeInsetsDirectional.only(
                start: 10,
            ),*/
            EdgeInsets.symmetric(
              vertical: 2.0,
              horizontal: 6.0,
            ),
            child: Text(''
                'Chargrilled Broccolini with Blanco Queso',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 13
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsetsDirectional.only(
              start: 10,
            ),
            child: Row(
              children:
              const [
                Text(
                  '220',
                  style: TextStyle(
                    letterSpacing: 1,
                  ),
                ),
                SizedBox(
                  width: 4,
                ),
                Text('cal'),
              ],
            ),
          ),
        ),
      ],
    ),
  ),
);