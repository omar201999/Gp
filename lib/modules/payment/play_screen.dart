import 'package:flutter/material.dart';

enum SingingCharacter { paypal, creditcard, cashondelivery}

class PlayScreen extends StatefulWidget {
  @override
  _PaymentMethod createState() => _PaymentMethod();
}

class _PaymentMethod extends State<PlayScreen>{

  SingingCharacter? _character = SingingCharacter.paypal;
 @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal[400],
          title: const Text(
              'Select Payment Methods'
          ),


        ),
        backgroundColor: Colors.grey[300],
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
                  value: SingingCharacter.creditcard,
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
                  value: SingingCharacter.paypal,
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



          ],
        )

    );

  }


}
