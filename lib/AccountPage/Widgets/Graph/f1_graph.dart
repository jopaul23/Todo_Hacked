import 'package:Todo_App/AccountPage/Functions/chart.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'graph.dart';
import '../../../Themes/colors.dart' as appColors;

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
  var theme;
  @override
  void initState() {
    weeklyData = graph.graphValues(widget.todoChart);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant BarChartTwo oldWidget) {
    setState(() {
      print("fsds ${widget.todoChart.pendingTask}");
      weeklyData = graph.graphValues(widget.todoChart);
    });
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    return Container(
      height: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18.0),
        color: theme.accentColor,
        boxShadow: [appColors.shadow.scale(2)],
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
<<<<<<< HEAD:lib/Helper Widgets/Graph/f1_graph.dart
      widget.weeklyData.length, // y1                 // y2
      (index) => _buildBar(
          index, widget.weeklyData[index][0], widget.weeklyData[index][1]),
=======
      weeklyData.length, // y1                 // y2
      (index) => _buildBar(
        index,
        weeklyData[index][0].toDouble(),
        weeklyData[index][1].toDouble(),
      ),
>>>>>>> 312bf3b05ed95335dfb7c807b80f7d52fed7a1b7:lib/AccountPage/Widgets/Graph/f1_graph.dart
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
          colors: [theme.primaryColor, theme.primaryColor.withOpacity(0.9)],
          width: width,
        ),
        BarChartRodData(
          y: y2,
          colors: [theme.errorColor, theme.errorColor.withOpacity(0.9)],
          width: width,
        ),
      ],
    );
  }
}
