import 'package:flutter/material.dart';
import 'package:gp/shared/componants/componants.dart';

class MarketScreen extends StatelessWidget {
  const MarketScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
          title: 'Ma',
        onPressed: ()
        {

        },
        icon: Icons.add_shopping_cart,

      ),
    );
  }
}
