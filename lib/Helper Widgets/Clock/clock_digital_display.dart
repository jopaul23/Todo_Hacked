import 'package:Todo_App/styles/styles.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../Helper%20Widgets/Clock/remainder.dart';
import 'Functions/clock_functions.dart';

enum DigitalClock { normal, remainder }

class ClockDigitalDisplay extends StatelessWidget {
  final String time;
  final bool isHourSelected;
  final TimeChangeMode mode;
  final Function() onHourSelected, onMinuteSelected;
  final DigitalClock digitalClock;
  const ClockDigitalDisplay(
      {Key key,
      this.time,
      this.mode,
      this.digitalClock,
      this.isHourSelected,
      this.onHourSelected,
      this.onMinuteSelected})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (digitalClock == DigitalClock.normal) return display1();
    return display2();
  }

  Widget display1() {
    String hour = time.split(":")[0];
    String min = time.split(":")[1];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 80.0, vertical: 15),
      child: RichText(
          text: TextSpan(
              text: "$hour",
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  onHourSelected();
                },
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isHourSelected ? Colors.red : Colors.grey,
                  fontSize: 40),
              children: [
            TextSpan(
              text: " : ",
              style: TextStyle(
                  color: Colors.red,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.none),
            ),
            TextSpan(
              text: "$min ",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: !isHourSelected ? Colors.red : Colors.grey,
                  fontSize: 40),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  onMinuteSelected();
                },
            ),
          ])),
    );
  }

  Widget display2() {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TimeBox(
            timeType: "HRS",
            time: time.substring(0, 2),
            onPressed: onHourSelected,
            backGroundColor: mode == TimeChangeMode.hour
                ? Styles.t1Orange.withOpacity(0.9)
                : Colors.grey,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            ":",
            style: TextStyle(
              color: Styles.red,
              fontSize: 40,
              decoration: TextDecoration.none,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          TimeBox(
            timeType: "MIN",
            onPressed: onMinuteSelected,
            time: time.substring(3),
            backGroundColor: mode != TimeChangeMode.hour
                ? Styles.t1Orange.withOpacity(0.9)
                : Colors.grey,
          ),
        ],
      ),
    );
  }
}
