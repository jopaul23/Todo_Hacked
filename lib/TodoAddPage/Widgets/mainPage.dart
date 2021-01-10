import 'package:Todo_App/styles/styles.dart';
import 'package:flutter/material.dart';
import "package:Todo_App/Common widgets/inputfield.dart";
import 'package:Todo_App/Common widgets/button.dart';

class TodoAddPage extends StatefulWidget {
  @override
  _TodoAddPageState createState() => _TodoAddPageState();
}

class _TodoAddPageState extends State<TodoAddPage> {
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Styles.cream,
      body: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            height: size.height * 0.098,
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Styles.grey4.withOpacity(0.04),
                    spreadRadius: 10,
                    blurRadius: 7,
                    offset: Offset(0, 2), // changes position of shadow
                  ),
                ],
                gradient: Styles.t1Gradient,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25))),
          ),
          SizedBox(
            height: size.height * 0.05,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
            height: size.height * 0.06,
            child: TextField(
              decoration: InputDecoration(
                  hintText: "Add your text",
                  hintStyle: TextStyle(
                    color: Styles.grey1,
                    fontWeight: FontWeight.w400,
                    fontSize: 30,
                  ),
                  border: InputBorder.none),
            ),
          ),
          SizedBox(
            height: size.height * 0.05,
          ),
          Container(
            height: size.height -
                size.height * 0.1 -
                size.height * 0.098 -
                size.height * 0.06,
            decoration: BoxDecoration(
              color: Styles.white3,
              borderRadius: BorderRadius.circular(50),
              boxShadow: [
                BoxShadow(
                  color: Styles.grey4.withOpacity(0.04),
                  spreadRadius: 10,
                  blurRadius: 9,
                  offset: Offset(0, 2), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.08,
                ),
                InputButton(
                  text: "10:30",
                  buttoncolor: Styles.white3,
                  textcolor: Styles.grey2,
                  icon: Icons.timer,
                  width: 300,
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                InputButton(
                  text: "1 may 2020",
                  buttoncolor: Styles.white3,
                  textcolor: Styles.grey2,
                  icon: Icons.calendar_today_rounded,
                  width: 300,
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                InputButton(
                  text: "30 mins before",
                  buttoncolor: Styles.white3,
                  textcolor: Styles.grey2,
                  icon: Icons.notifications,
                  width: 300,
                ),
                SizedBox(
                  height: size.height * 0.04,
                ),
                InputButton(
                  text: "   Add task",
                  buttoncolor: Styles.t1Orange,
                  textcolor: Styles.white3,
                  width: 200,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
