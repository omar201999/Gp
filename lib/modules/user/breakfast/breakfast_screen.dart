import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/modules/user/breakfast/cubit/cubit.dart';
import 'package:gp/modules/user/breakfast/cubit/states.dart';
import 'package:gp/modules/user/camera/Camera_Screen.dart';
import 'package:gp/shared/componants/componants.dart';
import 'package:gp/shared/styles/colors.dart';
import 'package:gp/shared/styles/icon_broken.dart';

class BreakFastScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => BreakFastCuibt(),
      child: BlocConsumer<BreakFastCuibt,BreakFastStates>(
        listener: (context,state)
        {

        },
        builder: (context,state)
        {
          return Scaffold(
            appBar: buildAppBar(
                title: 'Breakfast',
                icon: IconBroken.Arrow___Left_2,
                onPressed: () {
                  Navigator.pop(context);
                },
                actions: [
                  IconButton(
                 icon: Icon(Icons.camera),
                 onPressed: ()
                {
                    navigateTo(
                     context,
                     cameraScreen());
              },
                  ),
             ],
            ),
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children:
                  [
                    defaultContainer(
                      color: constantColor5,
                      child: defaultTextFormField(
                          type: TextInputType.text,
                          prefix: Icons.search,
                          hintText: 'Search',
                          border: InputBorder.none,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                   GridView.count(
                     crossAxisCount: 2,
                     shrinkWrap: true,
                     physics: const NeverScrollableScrollPhysics(),
                     mainAxisSpacing: 1,
                     crossAxisSpacing: 1,
                     childAspectRatio: 1 / 1.5,
                     children: List.generate(
                             15,
                             (index) => buildSelectItem(
                               context,
                               index,
                               value: BreakFastCuibt.get(context).isChecked[index],
                               onChanged: (value)
                               {
                                 BreakFastCuibt.get(context).changeCheckBox(index, value);
                               }
                             ),
                     ),
                   ),

                   /* Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:
                      [
                        Container(

                          width: 170,
                          child: ListView.separated(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context,index) => buildSelectItem(context,index),
                            separatorBuilder:(context,index) => SizedBox(height: 15,) ,
                            itemCount: 10,
                          ),
                        ),
                        SizedBox(width: 15,),
                        Container(

                          width: 170,
                          child: ListView.separated(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context,index) => buildSelectItem(context,index),
                            separatorBuilder:(context,index) => SizedBox(height: 15,) ,
                            itemCount: 10,
                          ),
                        ),
                      ],
                    ),*/




                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
