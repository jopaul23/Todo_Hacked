import 'package:Todo_App/AccountPage/Functions/chart.dart';
import 'package:Todo_App/Database/provider.dart';
import 'package:Todo_App/Helper%20Widgets/Graph/f1_graph.dart';
import 'package:Todo_App/Helper%20Widgets/basic_widget.dart';
import 'package:Todo_App/styles/images.dart';
import 'package:Todo_App/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
      print(_chart.getChartData().userLoggedDate);
      setState(() {});
    });

    super.initState();
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BasicWidget(
      pageNo: 3,
      child: Container(
          height: size.height,
          decoration: BoxDecoration(
            gradient: Styles.t1Gradient,
          ),
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
                child: Text(
                  "My account",
                  style: TextStyle(
                    fontFamily: GoogleFonts.rubik().fontFamily,
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    color: Styles.white2,
                    decoration: TextDecoration.none,
                  ),
                ),
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
                      child: Text(
                        "Tasks overview",
                        style: TextStyle(
                          fontFamily: GoogleFonts.rubik().fontFamily,
                          fontSize: 20,
                          color: Styles.grey2,
                          fontWeight: FontWeight.w800,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.04,
                    ),
                    Row(
                      children: [
                        BoxContainer(
                          text: "Completed tasks",
                          number: "${_chart.completedTask}",
                          // number: "${accountFunctions.getCompletedTask()}",
                          color: Styles.t1Orange,
                        ),
                        Spacer(),
                        BoxContainer(
                          text: "Pending tasks",
                          number: "${_chart.pendingTask}",
                          // number: "${accountFunctions.getPendingTask()}",
                          color: Styles.red,
                        )
                      ],
                    ),
                    SizedBox(
                      height: size.width - size.width / 1.25 - 50,
                    ),
                    BarChartTwo(),
                  ],
                ),
              )
            ],
          )),
    );
  }
}

class BoxContainer extends StatelessWidget {
  final Color color;
  final String number;
  final String text;

  const BoxContainer({this.number, this.color, this.text});

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15),
      height: size.width / 3,
      width: size.width / 2.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(30)),
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
      child: Column(
        children: [
          Spacer(),
          Align(
            alignment: Alignment.center,
            child: Text(
              number,
              style: TextStyle(
                  decoration: TextDecoration.none,
                  fontFamily: GoogleFonts.rubik().fontFamily,
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
                  fontFamily: GoogleFonts.rubik().fontFamily,
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
