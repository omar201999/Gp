import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gp/modules/user/payment/payment_details.dart';

import '../confirm_order/confirm_order.dart';



enum SingingCharacter { paypal, creditcard, cashondelivery}

class PaymentMethod extends StatefulWidget {
  // PaymentMethod({Key? key}) : super(key: key);
  @override
  _PaymentMethod createState() => _PaymentMethod();
}

class _PaymentMethod extends State<PaymentMethod>{

  SingingCharacter? _character = SingingCharacter.paypal;



  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       backgroundColor: Colors.teal[400],
       title: const Text(
         'Select Payment Methods'
       ),
       leading:
       IconButton(
         onPressed: () {
           setState(() {
             Navigator.push(
               context,
               MaterialPageRoute(
                 builder: (context) => ConfirmOrder(),
               ),
             );
           });
         },
         icon: const Icon(
           Icons.arrow_back,
         ),
       ),
       ),
     backgroundColor: Colors.grey[200],
     body: Column(
       children: [
         const SizedBox(
           height: 10.0,
         ),
         Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,

          ),
          child: Container(
           decoration: BoxDecoration(
             color: Colors.white,
             borderRadius: BorderRadius.circular(10.0)
           ),
           child: RadioListTile<SingingCharacter>(
               value: SingingCharacter.paypal,
               title: const Text('PayPal'),
               groupValue: _character,
               onChanged: (SingingCharacter? val){
                 setState(() {
                   _character= val;
                 });
               },
               activeColor: Colors.teal,
              secondary: const Image(
                  image: AssetImage('assets/images/1.png'),
                  height: 45.0,
                  width: 50.0,
              ),

             ),
   ),
   ),
         const SizedBox(
           height: 8.0,
         ),
         Padding(
           padding: const EdgeInsets.symmetric(
             horizontal: 10.0,
           ),
           child: Container(
             decoration: BoxDecoration(
                 color: Colors.white,
                 borderRadius: BorderRadius.circular(10.0)
             ),
             child:RadioListTile<SingingCharacter>(
               title: const Text('Credit Cards'),
               value: SingingCharacter.creditcard,
               groupValue: _character,
               onChanged: (SingingCharacter? value) {
               setState(() {
               _character = value;
             });
           },
               activeColor: Colors.teal,
               secondary: const Image(
             image: AssetImage('assets/images/2.png'),
             height: 55.0,
             width: 120.0,
           ),
         ),
        ),
       ),
         const SizedBox(
           height: 8.0,
         ),
         Padding(
           padding: const EdgeInsets.symmetric(
             horizontal: 10.0,
           ),
           child: Container(
             decoration: BoxDecoration(
                 color: Colors.white,
                 borderRadius: BorderRadius.circular(10.0)
             ),
             child:RadioListTile<SingingCharacter>(
               value: SingingCharacter.cashondelivery,
               title: const Text('Cash on delivery'),
               groupValue: _character,
               onChanged: (SingingCharacter? val){
                 setState(() {
               _character= val;
             });
             },
                activeColor: Colors.teal,
                secondary: const Image(
                 image: AssetImage('assets/images/Hnetimage.png'),
                 height: 30.0,
                 width: 30.0,
           ),
    ),
    ),

         ),

         const SizedBox(
           height: 410.0,
         ),
          Container(
             width: double.infinity,
             margin: const EdgeInsets.symmetric(
             horizontal: 30.0,
            ),
              decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.teal[400],
           ),
              child: MaterialButton(
                onPressed: () {
                  setState(() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PaymentDetails(),
                      ),
                    );
                  });
                },
                child: const Text(
                 'Continue',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
               ),

           ),
         ),


       ],
     )

   );

  }


}

