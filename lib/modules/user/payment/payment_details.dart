import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gp/modules/user/payment/payment_method.dart';

import '../confirm_order/confirm_order.dart';


class PaymentDetails extends StatefulWidget {
  @override
  _PaymentDetails createState() => _PaymentDetails();
}

class _PaymentDetails extends State<PaymentDetails> {

  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[400],
        title: const Text(
            'Payment Details'
        ),
        leading:  IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PaymentMethod(),
                ),
              );
            },
            icon: const Icon(
             Icons.arrow_back,
            ),
        ),
      ),
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
         child: Column(

            children: [
              Padding(
                     padding: const EdgeInsets.symmetric(
                     horizontal: 10.0,
                     vertical: 10.0,
                     ),
                     child:Container(
                          height: 110,
                          decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white,
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.only(
                               start: 8.0,
                              ),
                              child: Row(

                               children:  [
                                const Icon(Icons.credit_card),
                                TextButton(
                                    onPressed: () {},
                                    child: const Text(
                                      'Add New Card',
                                    ),
                                  style: TextButton.styleFrom(
                                    primary: Colors.teal,
                                  ),
                                ),
                             ],
                        ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 4.0,
                              ),
                              child:Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                              child: Image.asset('assets/images/1.png'),
                           ),
                                Expanded(
                             flex: 3,
                             child: Image.asset('assets/images/2.png'),
                           ),
                                Expanded(
                             child: Image.asset('assets/images/3.png'),
                           ),
                                Expanded(
                              child: Image.asset('assets/images/4.png'),
                           ),
                                Expanded(
                              child: Image.asset('assets/images/5.png'),
                           ),
                                Expanded(
                              child: Image.asset('assets/images/6.png'),
                           ),
                                Expanded(
                               child: Image.asset('assets/images/7.png'),
                           ),
                       ],
                  ),
                            ),

                       ],
                     ),
                  ),
                ),

              Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.streetAddress,
                        decoration: const InputDecoration(
                          hintText: 'Home Address',
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(
                             Radius.circular(15.0),
                           ),
                          ),
                          prefixIcon: Icon(
                            Icons.home_outlined,
                          ),
                          filled: true,
                          fillColor: Colors.white,

                      ),
                    ),
                      const SizedBox(
                       height: 10.0,
                     ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          hintText: 'Card Number',
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(
                             Radius.circular(10.0),
                           ),
                          ),
                          prefixIcon: Icon(
                            Icons.credit_card,
                          ),
                          filled: true,
                          fillColor: Colors.white,

                      ),
                    ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.datetime,
                        decoration: const InputDecoration(
                          hintText: 'Year/Month',
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(
                              Radius.circular(15.0),
                            ),
                          ),
                          prefixIcon: Icon(
                            Icons.date_range,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          hintText: 'CVV',
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(
                              Radius.circular(15.0),
                            ),
                          ),
                          prefixIcon: Icon(
                            Icons.credit_card,
                          ),
                          suffixIcon: Icon(
                            Icons.info_outline,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),

                      Container(
                        margin: const EdgeInsetsDirectional.only(
                          start: 7.0,
                        ),
                        child: Row(
                          //mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                           const Text(
                          'Save details of card',
                           style: TextStyle(
                            fontSize: 17.0,
                          ),
                        ),
                           Container(
                             margin: const EdgeInsetsDirectional.only(
                               start: 136.0,
                             ),
                             child: Switch(
                              value: isSwitched,
                              onChanged: (value) {
                                setState(() {
                                  isSwitched = value;

                                });
                              },
                              activeTrackColor: Colors.teal[300],
                              activeColor: Colors.teal,
                            ),
                           ),

                        ],

                       ),
                      ),

                      SizedBox(
                         height: 135,
                  ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.teal[400],
                        ),
                        child: MaterialButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ConfirmOrder(),
                              ),
                            );
                          },
                          height: 40.0,
                          child: const Text(
                            'Confirm',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                          ),
                        ),
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