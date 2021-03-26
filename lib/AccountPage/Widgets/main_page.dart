import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../Functions/chart.dart';
import '../../Helper%20Widgets/basic_widget.dart';
import '../../styles/images.dart';
import 'Graph/f1_graph.dart';
import '../../Themes/colors.dart' as appColors;

class AccountPage extends StatefulWidget {
  const AccountPage();
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  TodoChart _chart;
  @override
  void initState() {
    _chart = TodoChart();
    _chart.init().then((_) {
      print("todayCompletedTask");
      print(_chart.todayPendingTask);

      setState(() {});
    });

    super.initState();
  }

  Widget build(BuildContext context) {
    debugPrint("rebuilding+++++");
    Size size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    final theme = Theme.of(context);
    return WillPopScope(
      onWillPop: () {
        return Future.value(true);
      },
      child: BasicWidget(
        pageNo: 3,
        child: Container(
            height: size.height,
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [theme.colorScheme.primary, theme.colorScheme.secondary],
            )),
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * 0.04,
                  ),
                  Image(
                    image: ImportedImages.accountsLarge,
                    height: 50,
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Container(
                    height: 24,
                    child: Text("My account", style: textTheme.headline3),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    height: size.height - size.height * 0.07 - 24 - 50,
                    decoration: BoxDecoration(
                      color: Theme.of(context).accentColor,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30)),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: size.height * 0.05,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          height: 25,
                          child: Text("Tasks overview",
                              style: textTheme.headline3),
                        ),
                        SizedBox(
                          height: size.height * 0.04,
                        ),
                        Row(
                          children: [
                            boxContainer(
                              theme,
                              text: "Completed tasks",
                              number: "${_chart.completedTask}",
                              color: theme.primaryColor,
                            ),
                            Spacer(),
                            boxContainer(
                              theme,
                              text: "Pending tasks",
                              number: "${_chart.pendingTask}",
                              color: theme.errorColor,
                            )
                          ],
                        ),
                        SizedBox(
                          height: size.width - size.width / 1.25 - 50,
                        ),

                        // Graph
                        BarChartTwo(
                          todoChart: _chart,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }

  boxContainer(theme, {Color color, String number, String text}) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15),
      height: size.width / 3,
      width: size.width / 2.5,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        color: theme.accentColor,
        boxShadow: [appColors.shadow],
      ),
      child: Column(
        children: [
          Spacer(),
          Align(
            alignment: Alignment.center,
            child: Text(
              number,
              style: TextStyle(
                  decoration: TextDecoration.none,
                  fontSize: 60,
                  fontWeight: FontWeight.w600,
                  color: color),
            ),
          ),
          Spacer(),
          Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              text,
              style: TextStyle(
                  decoration: TextDecoration.none,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: appColors.grey2),
            ),
          ),
        ],
      ),
    );
  }
}
