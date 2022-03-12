import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/modules/breakfast/cubit/cubit.dart';
import 'package:gp/modules/breakfast/cubit/states.dart';
import 'package:gp/modules/camera/Camera_Screen.dart';
import 'package:gp/shared/componants/componants.dart';

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
              leadingIcon: IconButton(
                icon:  Icon(
                  Icons.arrow_back_ios,
                ),
                onPressed: ()
                {
                  Navigator.pop(context);
                },
              ),
              icon: Icons.camera,
              onPressed: ()
              {
                navigateTo(
                    context,
                    cameraScreen());
              },

            ),
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children:
                  [
                    defaultContainer(
                      height: 50,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: defaultTextFormField(
                          type: TextInputType.text,
                          prefix: Icons.search,
                          hintText: 'Search',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                   GridView.count(
                     crossAxisCount: 2,
                     shrinkWrap: true,
                     physics: NeverScrollableScrollPhysics(),
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
