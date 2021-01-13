import 'package:Todo_App/Helper%20Widgets/dropdown.dart';
import 'package:Todo_App/Helper%20Widgets/inputfield.dart';
import 'package:intl/intl.dart';
import 'package:Todo_App/Helper%20Widgets/Clock/clock_body.dart';
import 'package:Todo_App/styles/styles.dart';
import 'package:flutter/material.dart';

class TodoAddPage extends StatefulWidget {
  @override
  _TodoAddPageState createState() => _TodoAddPageState();
}

class _TodoAddPageState extends State<TodoAddPage> {
  OverlayEntry clock;
  String time;

  @override
  void initState() {
    DateTime now = DateTime.now();
    time = DateFormat('kk:mm').format(now);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Styles.cream,
      body: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            height: size.height * 0.098,
            padding: EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Styles.grey4.withOpacity(0.02),
                    spreadRadius: 10,
                    blurRadius: 7,
                    offset: Offset(0, 2), // changes position of shadow
                  ),
                ],
                gradient: Styles.t1Gradient,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                )),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios_rounded,
                      color: Styles.t1Orange.withOpacity(0.7),
                      size: 40,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                Align(
                  alignment: Alignment.bottomRight,
                  child: CustomDropdown(
                    text: "Catagories",
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: size.height * 0.05,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
            height: size.height * 0.06,
            child: TextField(
              cursorHeight: 40,
              cursorColor: Styles.grey1,
              style: TextStyle(
                fontSize: 30,
                color: Styles.grey2,
              ),
              decoration: InputDecoration(
                  hintText: "Add your text",
                  hintStyle: TextStyle(
                    color: Styles.grey1.withOpacity(0.8),
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
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50), topRight: Radius.circular(50)),
              boxShadow: [
                BoxShadow(
                  color: Styles.grey4.withOpacity(0.03),
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
                  text: time,
                  buttoncolor: Styles.white3,
                  textcolor: Styles.grey2,
                  icon: Icons.access_time,
                  width: 300,
                  onPressed: () {
                    debugPrint("Pressed");
                    clock = _createClockOverlay();
                    Overlay.of(context).insert(clock);
                  },
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

  OverlayEntry _createClockOverlay() {
    return OverlayEntry(builder: (context) {
      return Align(
        alignment: Alignment.center,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 30.0),
          decoration: BoxDecoration(
            color: Styles.white1,
            borderRadius: const BorderRadius.all(Radius.circular(35.0)),
            boxShadow: [
              BoxShadow(
                color: Styles.grey4.withOpacity(0.01),
                spreadRadius: 10,
                blurRadius: 7,
                offset: Offset(0, 2), // changes position of shadow
              ),
            ],
          ),
          child: ClockBody(
            isBeforeNoon: int.parse(time.split(":")[0]) < 12,
            onClicked: (String hour, String minute, bool isBeforeNoon) {
              print("$hour:$minute");
              setState(() {
                if (!isBeforeNoon) {
                  if (hour != "12") hour = (12 + int.parse(hour)).toString();
                } else if (hour == "12") hour = "00";
                time = hour + ":" + minute;
              });
              clock.remove();
            },
          ),
        ),
      );
    });
  }
}
