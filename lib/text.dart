/*import 'package:flutter/material.dart';

class CheckBoxInListView extends StatefulWidget {
  @override
  _CheckBoxInListViewState createState() => _CheckBoxInListViewState();
}

class _CheckBoxInListViewState extends State<CheckBoxInListView> {
  List<String> _texts = [
    "InduceSmile.com",
    "Flutter.io",
    "google.com",
    "youtube.com",
    "yahoo.com",
    "gmail.com"
  ];

  List<bool> _isChecked;

  @override
  void initState() {
    super.initState();
    _isChecked = List<bool>.filled(_texts.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _texts.length,
      itemBuilder: (context, index) {
        return CheckboxListTile(
          title: Text(_texts[index]),
          value: _isChecked[index],
          onChanged: (val) {
            setState(
                  () {
                _isChecked[index] = val!;
              },
            );
          },
        );
      },
    );
  }
}
*/