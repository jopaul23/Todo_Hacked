import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../Functions/chart.dart';
import '../../Helper%20Widgets/basic_widget.dart';
import '../../HomePage/Functions/homepage_todo_function.dart';
import '../../Router/page_router.dart';
import '../../styles/images.dart';
import '../../styles/styles.dart';
import 'Graph/f1_graph.dart';

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
    print("rebuilding+++++");
    Size size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    return Consumer(builder: (context, watch, _) {
      final changeMode = watch(homePageChangeModeProvider);
      return WillPopScope(
        onWillPop: () {
          return Future.value(true);
        },
        child: BasicWidget(
          pageNo: 3,
          onFavClicked: () {
            changeMode.changeMode(HomePageChangeMode.favorites);
            PageRouter.sailor.navigate(PageRouter.homePage);
          },
          child: Container(
              height: size.height,
              decoration: BoxDecoration(
                gradient: Styles.t1Gradient,
              ),
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
                        color: Styles.white2.withOpacity(.96),
                        borderRadius: BorderRadius.only(
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
                                style: textTheme.headline2),
                          ),
                          SizedBox(
                            height: size.height * 0.04,
                          ),
                          Row(
                            children: [
                              boxContainer(
                                text: "Completed tasks",
                                number: "${_chart.completedTask}",
                                color: Styles.t1Orange,
                              ),
                              Spacer(),
                              boxContainer(
                                text: "Pending tasks",
                                number: "${_chart.pendingTask}",
                                color: Styles.red,
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
    });
  }

  boxContainer({Color color, String number, String text}) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15),
      height: size.width / 3,
      width: size.width / 2.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        color: Styles.white2,
        boxShadow: [Styles.shadow()],
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
                  color: Styles.grey2),
            ),
          ),
        ],
      ),
    );
  }
}
