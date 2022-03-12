import 'package:flutter/material.dart';
import 'package:gp/shared/componants/constant.dart';

class AdminDashBored extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Scaffold(
        appBar: AppBar(),
        body: Center(
          child: TextButton(
            onPressed: ()
            {
              signOut(context);
            },
            child: Text('Sing Out'),
          ),
        ),
      ),
    );
  }
}
