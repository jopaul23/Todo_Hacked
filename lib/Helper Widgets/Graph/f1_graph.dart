import 'package:Todo_App/AccountPage/Functions/chart.dart';
import 'package:Todo_App/AccountPage/Functions/user_details.dart';
import 'package:Todo_App/Helper%20Widgets/Graph/graph.dart';
import 'package:Todo_App/styles/styles.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BarChartTwo extends StatefulWidget {
  final TodoChart todoChart;

  const BarChartTwo({Key key, this.todoChart}) : super(key: key);

  @override
  State<StatefulWidget> createState() => BarChartTwoState();
}

class BarChartTwoState extends State<BarChartTwo> {
  final Color leftBarColor = const Color(0xff53fdd7);
  final Color rightBarColor = const Color(0xffff5182);
  final double width = 9;
  int touchedGroupIndex;
  List weeklyData = [];
  Graph graph = Graph();
  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(covariant BarChartTwo oldWidget) {
    setState(() {
      print("fsds ${widget.todoChart.pendingTask}");
      weeklyData = graph.graphValues(widget.todoChart);
    });
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
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
      maxY: graph.yMultiple.toDouble() * 4,
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
              return "${graph.n}";
            case 1:
              return "${graph.n + 1}";
            case 2:
              return "${graph.n + 2}";
            case 3:
              return "${graph.n + 3}";
            case 4:
              return "${graph.n + 4}";
            case 5:
              return "${graph.n + 5}";
            case 6:
              return "${graph.n + 6}";
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
          if (value == graph.yMultiple * 0) {
            return '${graph.yMultiple * 0}';
          } else if (value == graph.yMultiple * 1) {
            return '${graph.yMultiple * 1}';
          } else if (value == graph.yMultiple * 2) {
            return '${graph.yMultiple * 2}';
          } else if (value == graph.yMultiple * 3) {
            return '${graph.yMultiple * 3}';
          } else if (value == graph.yMultiple * 4) {
            return '${graph.yMultiple * 4}';
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
      (index) => _buildBar(
        index,
        weeklyData[index][0].toDouble(),
        weeklyData[index][1].toDouble(),
      ),
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
