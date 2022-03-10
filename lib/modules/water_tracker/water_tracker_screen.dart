import 'package:flutter/material.dart';
import 'package:gp/shared/componants/componants.dart';

class WaterTrackerScreen extends StatelessWidget {
  const WaterTrackerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(title: 'Water Tracker Screen'),
    );
  }
}
