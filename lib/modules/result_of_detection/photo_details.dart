import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PhotoDetails extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.grey[300],
          child: Column(
            children: [
              Image(
                image: NetworkImage('https://th.bing.com/th/id/R.181db64682d8636f392b7f5c079c590c?rik=irpWstcQOg2OWQ&pid=ImgRaw&r=0'),
                width: double.infinity,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          'Apple',
                          style: TextStyle(
                            color: Colors.teal,
                            fontSize: 30
                          ),
                        ),
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Expanded(
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Protein : 10 g',
                                style: TextStyle(
                                  fontSize: 20
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Calories : 10 g',
                                style: TextStyle(
                                    fontSize: 20
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'carb : 10 g',
                                style: TextStyle(
                                    fontSize: 20
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'fat : 10 g',
                                style: TextStyle(
                                    fontSize: 20
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'sugar : 10 g',
                                style: TextStyle(
                                    fontSize: 20
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Fiber : 10 g',
                                style: TextStyle(
                                    fontSize: 20
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Sodium : 10 g',
                                style: TextStyle(
                                    fontSize: 20
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Potassium : 10 g',
                                style: TextStyle(
                                    fontSize: 20
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Vitamin A : 10 g',
                                style: TextStyle(
                                    fontSize: 20
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Vitamin C : 10 g',
                                style: TextStyle(
                                    fontSize: 20
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Calcium : 10 g',
                                style: TextStyle(
                                    fontSize: 20
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Iron : 10 g',
                                style: TextStyle(
                                    fontSize: 20
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Cholesterol : 10 g',
                                style: TextStyle(
                                    fontSize: 20
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
