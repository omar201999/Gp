import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomerDashBoardScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[300],
      child: Column(
        children: [
          ClipPath(
            clipper: MyClipper(),
            child: Container(
              height: 225,
              width: double.infinity,
              color: Colors.teal,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage('https://scontent.fcai19-4.fna.fbcdn.net/v/t39.30808-6/274699050_3245520135677565_4694208403740772397_n.jpg?_nc_cat=101&ccb=1-5&_nc_sid=09cbfe&_nc_eui2=AeHW69ZOv6L6_idfpTu73pb5s6U__mn6PH2zpT_-afo8fRBRTF2xcZGCgB5lXWGn0wyCt5U09sNFpuoRcDutX6Gc&_nc_ohc=TmGfrsvCVXcAX_zLcxf&_nc_ht=scontent.fcai19-4.fna&oh=00_AT_pT7dWJBc9GOeHxR1qn7fTcdmZej0F1l9YEMFWj6_l-g&oe=622B9E33'),
                        ),
                      ],
                    ),
                    SizedBox(width: 30,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Amr Ramadan',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          '21 Years',
                          style: TextStyle(
                            color: Colors.grey[300],
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          '73 Kg',
                          style: TextStyle(
                            color: Colors.grey[300],
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          '173 CM',
                          style: TextStyle(
                            color: Colors.grey[300],
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(

                    children: [
                      Container(
                        width: 280,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: Text(
                                'Goal Progress',
                                style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.teal,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Container(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Stack(
                                            children: [
                                              CircleAvatar(
                                                radius: 40,
                                                backgroundColor: Colors.teal,
                                              ),
                                              Container(
                                                width: 80,
                                                height: 80,
                                                alignment: Alignment.center,
                                                child: CircleAvatar(
                                                  radius: 30,
                                                  backgroundColor: Colors.white,
                                                ),
                                              ),
                                              Container(
                                                width: 80,
                                                height: 80,
                                                alignment: Alignment.center,
                                                child: Text(
                                                  '75',
                                                  style: TextStyle(
                                                    fontSize: 25,
                                                    color: Colors.teal,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),

                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 35,
                                    child: TextButton(
                                        onPressed:(){},
                                        child:Text(
                                          'Add Weight',
                                          style: TextStyle(color: Colors.teal),
                                        )
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsetsDirectional.only(
                  bottom: 20,
                  start: 20,
                  end: 20
              ),
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Goal',
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.teal,
                            ),
                          ),
                          SizedBox(height: 15,),
                          Expanded(
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Weight',
                                      style: TextStyle(
                                          fontSize: 17
                                      ),
                                    ),
                                    Text(
                                      '73',
                                      style: TextStyle(
                                          fontSize: 20
                                      ),
                                    ),
                                    Text(
                                      'Gain .25 per week',
                                      style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.grey[600]
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 10,),
                          Expanded(
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Daily Calories',
                                      style: TextStyle(
                                          fontSize: 17
                                      ),
                                    ),
                                    Text(
                                      '2750',
                                      style: TextStyle(
                                          fontSize: 20
                                      ),
                                    ),
                                    Text(
                                      'Carbs 299g / Fat 80g / Protein 120g',
                                      style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.grey[600]
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
              ),
            ),
          ),
/*
              Container(
                color: Colors.teal,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Icon(Icons.home,color: Colors.white,),
                            Text(
                                'HOME',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Icon(Icons.add_business_outlined,color: Colors.white,),
                            Text(
                                'MARKETING',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Icon(Icons.app_registration,color: Colors.white,),
                            Text(
                                'RECIPE',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Icon(Icons.account_box,color: Colors.white,),
                            Text(
                                'ME',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
*/
        ],
      ),

    );
  }
}

class MyClipper extends CustomClipper<Path> {
  Path getClip(Size size)
  {
    var path = new Path();
    path.lineTo(0, size.height-70);

    var controllPoint = Offset(150, size.height);
    var endPoint = Offset(size.width,size.height);
    path.quadraticBezierTo(controllPoint.dx, controllPoint.dy, endPoint.dx, endPoint.dy);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    return path;
  }
  bool shouldReclip( CustomClipper<Path> oldClipper)
  {
    return true ;
  }
}