import 'package:flutter/material.dart';
import 'package:gp/shared/componants/componants.dart';
import 'package:gp/shared/styles/colors.dart';

class CustomerDashBoardScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Container(
        color: Colors.grey[200],
        child: Column(
          children: [
            Container(
              height: 220,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Image(
                      fit: BoxFit.cover,
                      height: 180,
                      width: double.infinity,
                      image: NetworkImage('https://img.freepik.com/free-photo/vegetables-set-left-black-slate_1220-685.jpg?w=1380'),
                    ),
                  ),
                  CircleAvatar(
                    radius: 52,
                    backgroundColor: Colors.white,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 2),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage('https://img.freepik.com/free-photo/no-problem-concept-bearded-man-makes-okay-gesture-has-everything-control-all-fine-gesture-wears-spectacles-jumper-poses-against-pink-wall-says-i-got-this-guarantees-something_273609-42817.jpg?w=1060'),
                      radius: 50,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              children: [
                defaultHeadLineText(context, text: 'Amr Ramadan '),
                SizedBox(
                  height: 5,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: defaultContainer(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      defaultHeadLineText(context, text: 'Goal Weight',color: defaultColor),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              CircleAvatar(
                                backgroundColor: defaultColor,
                                radius: 35,
                              ),
                              CircleAvatar(
                                child: defaultHeadLineText(context, text: '75',color: defaultColor),
                                backgroundColor: Colors.white,
                                radius: 30,
                              ),

                            ],
                          ),
                        ],
                      ),
                      TextButton(
                          onPressed: (){},
                          child: defaultBodyText(
                              context,
                              text: 'add weight',
                              color: defaultColor
                          )
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: defaultContainer(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      defaultHeadLineText(context, text: 'Goal',color: defaultColor),
                      SizedBox(height: 20,),
                      secondPart(
                          context,
                          subHeadLine: 'Current Weight' ,
                          subHeadLine2: '65',
                          caption: 'Gain .25 kg per week'
                      ),
                      SizedBox(height: 20,),
                      secondPart(
                          context,
                          subHeadLine: 'Daily Calories' ,
                          subHeadLine2: '2750g' ,
                          caption: 'Carbs 255g , fat 80g , protein 250g'
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),

      ),
    );
  }
}


Widget secondPart(BuildContext context , {
  String? subHeadLine ,
  String? subHeadLine2 ,
  String? caption ,
}) => Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [

    Row(
      children: [
        defaultBodyText(context, text: '$subHeadLine'),
        Spacer(),
        defaultBodyText(context, text: '$subHeadLine2'),
      ],
    ),
    SizedBox(height: 5,),
    Text(
      '$caption',
      style: Theme.of(context).textTheme.caption,
    ),
  ],
);