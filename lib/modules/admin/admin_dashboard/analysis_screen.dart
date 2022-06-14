import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gp/layout/admin_layout/cubit/cubit.dart';
import 'package:gp/shared/componants/componants.dart';
import 'package:gp/shared/cubit/cubit.dart';
import 'package:gp/shared/styles/colors.dart';
import 'package:gp/shared/styles/icon_broken.dart';
import 'package:intl/intl.dart';

class Analysis extends StatefulWidget {

  @override
  _AnalysisState createState() => _AnalysisState();
}

class _AnalysisState extends State<Analysis> {

  List<Color> gradientColors = [
    const Color(0xff1ea2cb),
    const Color(0xff3e40e0),
  ];

  //DateTime firstDay = DateTime.utc(DateTime.now().year, DateTime.now().month, 1);


  //bool showAvg = false;

  @override
  Widget build(BuildContext context) {

    int totalAmount = 0;
    int sumTotalAmountProducts(){
      totalAmount = 0;
      for( int index = 0; index < AdminCubit.get(context).products.length; index++ ){
        totalAmount = totalAmount + (AdminCubit.get(context).products[index].quantity!).toInt();
      }
      return totalAmount;
    }

    List<PieChartSectionData> showingSections() {
      return List.generate(
          AdminCubit.get(context).products.length,
              (index) {
            int totalAmount = sumTotalAmountProducts();
            //final isTouched = index == touchedIndex;
            const fontSize = 16.0;
            const radius = 50.0;
            return buildPieChartItem(
                AdminCubit.get(context).products[index],
                context,
                radius,
                fontSize,
                index,
                totalAmount
            );
          });
    }

    return Scaffold(
      appBar: buildAppBar(
        title: 'Analysis',
        icon: IconBroken.Arrow___Left_2,

        onPressed: () {
          Navigator.pop(context);
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0
            ),
             child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   defaultHeadLineText(context, text:'Orders within Last 3 months'),
                   const SizedBox(
                     height: 10,
                   ),
                   Padding(
                     padding: const EdgeInsets.all(15.0),
                     child: defaultContainer(
                       context,
                       height: 420,
                       decoration: const BoxDecoration(
                         borderRadius: BorderRadius.all(
                           Radius.circular(18),
                         ),
                         color: constantColor5,
                         //Color(0xff232d37)
                       ),
                       child: Padding(
                         padding: const EdgeInsets.only(
                             right: 18.0, left: 12.0, top: 24, bottom: 12),
                         child: LineChart(
                           // showAvg ? avgData() :
                           mainData(),
                         ),
                       ),
                     ),
                   ),
                   const SizedBox(
                     height: 15,
                   ),
                   defaultHeadLineText(context, text:'Products in Stock'),
                   const SizedBox(
                     height: 10,
                   ),
                   Padding(
                     padding: const EdgeInsets.symmetric(
                       horizontal: 15,
                     ),
                     child: AspectRatio(
                       aspectRatio: 1.3,
                       child: Card(
                         color: Colors.grey[50],
                         child: Row(
                           children: [
                             const SizedBox(
                               height: 18,
                             ),
                             Expanded(
                               child: AspectRatio(
                                 aspectRatio: 1,
                                 child: PieChart(
                                   PieChartData(
                                       borderData: FlBorderData(
                                         show: false,
                                       ),
                                       sectionsSpace: 0,
                                       centerSpaceRadius: 40,
                                       sections: showingSections()
                                   ),
                                 ),
                               ),
                             ),
                             const SizedBox(
                               height: 10,
                             ),

                           ],
                         ),
                       ),
                     ),
                   ),
                   Padding(
                     padding: const EdgeInsets.symmetric(
                         vertical: 10,
                         horizontal: 15
                     ),
                     child: Container(
                       color: Colors.grey[50],
                       height: 250,
                       child: ListView.builder(
                           physics: NeverScrollableScrollPhysics(),
                           itemCount: AdminCubit.get(context).products.length,
                           itemBuilder: (context, index) => indicator2(
                               color: colors[index],
                               text: '${AdminCubit.get(context).products[index].name}',
                               isSquare: true,
                               secondText: ((AdminCubit.get(context).products[index].quantity!/totalAmount*100).round()).toString()+'%',
                               secondTextColor: colors[index]
                           )
                       ),
                     ),
                   )
                 ]
             ),
        ),
      )
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff68737d),
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    Widget text;
    switch (value.toInt()) {
      case 1:
        text = Text(DateFormat('MMM').format(DateTime.utc(DateTime.now().year, DateTime.now().month-3)), style: style);
        break;
      case 3:
        text = Text(DateFormat('MMM').format(DateTime.utc(DateTime.now().year, DateTime.now().month-2)), style: style);
        break;
      case 5:
        text = Text(DateFormat('MMM').format(DateTime.utc(DateTime.now().year, DateTime.now().month-1)), style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 8.0,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff67727d),
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );
    String text;
    switch (value.toInt()) {
      case 2:
        text = '2';
        break;
      case 6:
        text = '6';
        break;
      case 10:
        text = '10';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Colors.grey,
            //const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: Colors.grey,
            //const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border.all(
              color: Colors.grey,
              //const Color(0xff37434d),
              width: 1)),
      minX: 0,
      maxX: 6,
      minY: 0,
      maxY: 11,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(0, AdminCubit.get(context).countConfirmedOrders(DateTime.utc(DateTime.now().year, DateTime.now().month-4).month)),
            FlSpot(1, AdminCubit.get(context).countConfirmedOrders(DateTime.utc(DateTime.now().year, DateTime.now().month-3).month)),
            FlSpot(3, AdminCubit.get(context).countConfirmedOrders(DateTime.utc(DateTime.now().year, DateTime.now().month-2).month)),
            FlSpot(5, AdminCubit.get(context).countConfirmedOrders(DateTime.utc(DateTime.now().year, DateTime.now().month-1).month)),
            FlSpot(6, AdminCubit.get(context).countConfirmedOrders(DateTime.utc(DateTime.now().year, DateTime.now().month).month)),
          ],
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          barWidth: 5,
          //isStrokeCapRound: true,
          dotData: FlDotData(
            show: true,
          ),
         /* belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),*/
        ),
      ],
    );
  }

}
