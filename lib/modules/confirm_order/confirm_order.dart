import 'package:flutter/material.dart';

import '../payment/payment_method.dart';


class ConfirmOrder extends StatefulWidget {
 @override
  _ConfirmOrder createState() => _ConfirmOrder();
}

class _ConfirmOrder extends State<ConfirmOrder> {

  Color? color = Colors.teal[300];

  @override
  Widget build(BuildContext context) {

      return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.teal[400],
          foregroundColor: Colors.white,
          onPressed: (){},
         label: Text('Pay Now'),

        ),
         appBar: AppBar(
          backgroundColor: Colors.teal[400],
            title: const Text(
            'Confirm Order'
           ),
            leading: IconButton(
                onPressed: () {
                 /* setState(() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => (),
                      ),
                    );
                  });*/
                },
                icon: const Icon(
                  Icons.arrow_back,
                ),
            ),
        ),
        backgroundColor: Colors.grey[200],
        body: Column(

          children: [
            GestureDetector(
              onTap: ()
              {
                setState(() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PaymentMethod(),
                      ),
                  );
                });
              },
              child:Container(
                 child: Padding(
                   padding: const EdgeInsets.all(10.0),
                    child: Container(
                      height: 45.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                 ),
                        child: Row(
                           children: const [
                             SizedBox(
                              width: 5.0,
                             ),
                             Icon(
                               Icons.monetization_on_outlined,
                             ),
                             SizedBox(
                               width: 5.0,
                                ),
                             Text(
                             'Select Payment Method'
                             ),
                             SizedBox(
                               width: 150.0,
                             ),
                             Icon(
                              Icons.arrow_forward_ios_rounded,

                              ),


                   ],
                 ),
                ),
               ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: 380,
                width: double.infinity,
                decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
               ),
                child: Column(
                  children: [
                    Row(
                      children: const [
                        SizedBox(
                          width: 5.0,
                        ),
                        Padding(
                         padding: EdgeInsets.symmetric(
                           vertical: 5.0
                         ),
                         child: Icon(
                          Icons.store,
                        ),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          'Store',
                           style: TextStyle(
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                      ],
                    ),
                    Row(
                      children: [
                        Column(
                          children: const [
                            Image(
                              image: AssetImage('assets/images/VanillaBottle.png'),
                              height: 120.0,
                              width: 120.0,
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Container(
                         margin: const EdgeInsetsDirectional.only(
                           bottom: 10.0,
                         ),
                          child: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           //mainAxisAlignment: MainAxisAlignment.start,
                           children: [

                            Row(
                                 children:const [
                                  Text(
                                  'Vanilla Banana Flavored Egg Whites',
                                    //maxLines: 2,
                                    //overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                                ],
                           ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children:const [
                                Text(
                                'LE 210.00',
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            Row(
                              children:const [
                                Text(
                                  '6 Bottles X 300gm',
                                   style: TextStyle(
                                     color: Color(0xFF686767),
                                   ),
                                  ),

                              ],
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.only(
                                start: 20.0,
                              ),
                              child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                RawMaterialButton(
                                  shape:const CircleBorder(),
                                  elevation: 1.0,
                                  fillColor: Colors.grey[300],
                                  child: const Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: 15.0,
                                 ),
                                  onPressed: (){},
                                  constraints: const BoxConstraints.tightFor(
                                    width: 20.0,
                                    height: 20.0,
                                  ),
                                 ),
                                const Text(
                                  '1',
                                ),
                                RawMaterialButton(
                                  shape:const CircleBorder(),
                                  elevation: 1.0,
                                  fillColor: Colors.grey[300],
                                  child: const Icon(
                                    Icons.remove,
                                    color: Colors.white,
                                    size: 15.0,
                                  ),
                                  onPressed: (){},
                                  constraints: const BoxConstraints.tightFor(
                                    width: 20.0,
                                    height: 20.0,
                                  ),
                                ),
                              ],
                            ),
                         ),



                          ],
                        ),
                        ),
                      ],
                    ),
                    Container(
                      width: double.infinity,
                      color: const Color(0xCBF5F5F5),
                      height: 2.0,
                    ),
                    Padding(
                     padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                        const SizedBox(
                          width: 7.0,
                        ),
                        const Text(
                          'Shipping: LE 40.00',
                          style: TextStyle(
                            color: Color(0xFF686767),
                          ),
                        ),
                        const SizedBox(
                          width: 181.5,
                        ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 20.0,
                            ),
                          ),
                      ],
                    ),
                 ),
                    Container(
                      width: double.infinity,
                      color: const Color(0xCBF5F5F5),
                      height: 2.0,
                    ),
                    Padding(
                       padding: const EdgeInsetsDirectional.only(
                         top: 10.0,
                       ),
                       child: Row(
                         children:  const [
                          SizedBox(
                            width: 17.0,
                          ),
                          Text(
                            'Subtotal: LE 210.00',
                            style: TextStyle(
                              color: Color(0xFF686767),
                            ),
                          ),
                          ],
                        ),
                      ),
                    Row(
                        children:   [
                          const SizedBox(
                            width: 17.0,
                          ),
                          const Text(
                            'Voucher:',
                            style: TextStyle(
                              color: Color(0xFF686767),
                            ),
                          ),
                          const SizedBox(
                            width: 4.0,
                          ),
                          const Text(
                                '-LE 10.00',
                                style: TextStyle(
                                  color: Colors.teal,
                                ),
                              ),
                          const SizedBox(
                            width: 180.0,
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.arrow_forward_ios_rounded,
                            color: Colors.teal.shade400,
                            size: 15.0,
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                        ],

                    ),
                    Row(
                        children: const [
                          SizedBox(
                            width: 17.0,
                          ),
                          Text(
                            'Shipping fee: LE 40.00',
                            style: TextStyle(
                              color: Color(0xFF686767),
                            ),
                          ),

                        ],
                      ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        children: const [
                          SizedBox(
                            width: 2.0,
                          ),
                          Text(
                            'Total: LE 240.00',
                            style: TextStyle(
                              color: Color(0xFF686767),
                            ),
                          ),

                        ],
                      ),

                    ),


                  ],
                ),
              ),
            ),



            /*const SizedBox(
              height: 132.5,
            ),
             Container(
                height: 60.0,
                width: double.infinity,
                color: Colors.white,
               *//* decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),*//*
                child: Row(
                  children: [
                    const SizedBox(
                      width: 5.0,
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    const Text(
                        'Order Summary: LE 240.00'
                    ),
                    const SizedBox(
                      width: 120.0,
                    ),
                    GestureDetector(
                     onTap: ()
                      {
                        setState(() {
                          color = Colors.teal;
                        });
                      },
                      child: Container(
                       decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(10.0),
                         color: color,
                       ),
                        child: const Padding(
                         padding: EdgeInsets.all(10.0),
                         child: Text(
                           'Pay Now',
                           style: TextStyle(
                             color: Colors.white,
                           ),
                         ),

                        ),
                   ),
                ),


                  ],
                ),
              ),*/

     
          ],
        ),

      );
  }

}