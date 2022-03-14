import 'package:flutter/material.dart';

class NutritionScreen extends StatefulWidget
{
  @override
  _NutritionScreenState createState() => _NutritionScreenState();
}

class _NutritionScreenState extends State<NutritionScreen>
{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.teal[400],
        title: Text(
          'Nutrition',
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children:
          [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,

              ),
              child: Row(
                children:
                [
                  Expanded(
                    flex: 1,
                    child: IconButton(
                      onPressed: (){},
                      icon: Icon
                        (
                        Icons.arrow_back,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: TextButton(
                      onPressed: (){},
                      child: Text(
                        'Today',
                        textAlign: TextAlign.center,
                        style: TextStyle
                          (
                            fontWeight: FontWeight.w300,
                            color: Colors.black
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: IconButton(
                      onPressed: (){},
                      icon: Icon
                        (
                        Icons.arrow_forward,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children:
              [
                Expanded(
                  flex: 3,
                    child: Text('')),
                Expanded(
                    flex: 1,
                    child: Text('Total')),
                Expanded(
                    flex: 1,
                    child: Text('Total')),
                Expanded(
                    flex: 1,
                    child: Text('Total')),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            ListView.separated(
              physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context,index) => buildNutrtion(),
                separatorBuilder: (context,index) => Container(
                  width: double.infinity,
                  height: 1,
                  color: Colors.grey,
                ),
                itemCount: 5)

          ],
        ),
      ),
    );
  }
  Widget buildNutrtion() => Container(
    decoration: BoxDecoration(
      color: Colors.white,

    ),
    child: Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children:
        [
          Row(
            children:
            [
              Expanded(
                  flex: 3,
                  child: Text('Protein')),
              Expanded(
                  flex: 1,
                  child: Text('0')),
              Expanded(
                  flex: 1,
                  child: Text('139')),
              Expanded(
                  flex: 1,
                  child: Text('139')),
            ],
          ),
          Slider(
              activeColor: Colors.teal[400],
              min: 10,
              max: 100,
              inactiveColor : Colors.grey,
              value: 50,
              onChanged: (double value) {  }),
        ],
      ),
    ),
  );
}
/*
            Table(
              children:
              [
                TableRow(
                  children:
                  [
                    Text('Protin'),
                    Text('0'),
                    Text('139'),
                    Text('139'),

                  ],
                ),
                TableRow(
                  children:
                  [
                    Text('Protin'),
                    Text('0'),
                    Text('139'),
                    Text('139'),

                  ],
                ),
                TableRow(
                  children:
                  [
                    Text('Protin'),
                    Text('0'),
                    Text('139'),
                    Text('139'),

                  ],
                ),
                TableRow(
                  children:
                  [
                    Text('Protin'),
                    Text('0'),
                    Text('139'),
                    Text('139'),

                  ],
                ),
                TableRow(
                  children:
                  [
                    Text('Protin'),
                    Text('0'),
                    Text('139'),
                    Text('139'),

                  ],
                ),
              ],
            ),
*/
