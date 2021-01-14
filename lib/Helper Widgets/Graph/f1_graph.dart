import 'package:Todo_App/styles/styles.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BarChartTwo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BarChartTwoState();
}

class BarChartTwoState extends State<BarChartTwo> {
  final Color leftBarColor = const Color(0xff53fdd7);
  final Color rightBarColor = const Color(0xffff5182);
  final double width = 9;
  int touchedGroupIndex;

  final List<List<double>> weeklyData = [
    [5, 12],
    [16, 12],
    [18, 5],
    [21, 16],
    [17, 6],
    [19, 1.5],
    [10, 1.5],
  ];
  int maxValue = 21; //maxValue is the greatest no. in the weaklyData
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 270,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18.0),
        color: Styles.white2,
        boxShadow: [
          BoxShadow(
            color: Styles.grey4.withOpacity(0.02),
            spreadRadius: 7,
            blurRadius: 7,
            offset: Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      margin: EdgeInsets.all(10.0),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          const SizedBox(
            height: 25,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
              child: BarChart(
                _mainBarData(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  BarChartData _mainBarData() {
    return BarChartData(
      maxY: 20,
      titlesData: _buildAxes(),
      borderData: FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(
            color: const Color(0xffb3b3b3),
            width: 3,
          ),
          left: BorderSide(
            color: const Color(0xffb3b3b3),
            width: 3,
          ),
        ),
      ),
      barGroups: _buildAllBars(),
    );
  }

  FlTitlesData _buildAxes() {
    int n = maxValue ~/ 4 + 1; //multiples of n will be displayed in y axis
    return FlTitlesData(
      show: true,
      // Build X axis.
      bottomTitles: SideTitles(
        showTitles: true,
        // textStyle: TextStyle(
        //     color: const Color(0xff7589a2),
        //     fontWeight: FontWeight.bold,
        //     fontSize: 14),
        margin: 20,
        getTitles: (double value) {
          switch (value.toInt()) {
            case 0:
              return 'Mon';
            case 1:
              return 'Tue';
            case 2:
              return 'Wed';
            case 3:
              return 'Thu';
            case 4:
              return 'Fri';
            case 5:
              return 'Sat';
            case 6:
              return 'Sun';
            default:
              return '';
          }
        },
      ),
      // Build Y axis.
      leftTitles: SideTitles(
        showTitles: true,
        // getTextStyles:,
        margin: 10,
        reservedSize: 14,
        getTitles: (value) {
          int val;
          if (value == n * 0) {
            val = n * 0;
            return '$val';
          } else if (value == n * 1) {
            val = n * 1;
            return '$val';
          } else if (value == n * 2) {
            val = n * 2;
            return '$val';
          } else if (value == n * 3) {
            val = n * 3;
            return '$val';
          } else if (value == n * 4) {
            val = n * 4;
            return '$val';
          } else {
            return '';
          }
        },
      ),
    );
  }

  // Function to draw all the bars.
  List<BarChartGroupData> _buildAllBars() {
    return List.generate(
      weeklyData.length, // y1                 // y2
      (index) => _buildBar(index, weeklyData[index][0], weeklyData[index][1]),
    );
  }

  // Function to define how to bar would look like.
  BarChartGroupData _buildBar(int x, double y1, double y2) {
    return BarChartGroupData(
      barsSpace: 2,
      x: x,
      barRods: [
        BarChartRodData(
          y: y1,
          colors: [Styles.t1Orange, Styles.t1Orange.withOpacity(0.9)],
          width: width,
        ),
        BarChartRodData(
          y: y2,
          colors: [Styles.red, Styles.red.withOpacity(0.9)],
          width: width,
        ),
      ],
    );
  }
}
