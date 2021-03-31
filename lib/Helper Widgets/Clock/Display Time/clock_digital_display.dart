import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'timeBox.dart';
import '../Functions/clock_functions.dart';

enum DigitalClock { normal, remainder }

class ClockDigitalDisplay extends StatelessWidget {
  final ClockController clockController;
  final TimeChangeMode mode;
  final Function() onHourSelected, onMinuteSelected;
  final DigitalClock digitalClock;
  const ClockDigitalDisplay(
      {Key key,
      this.clockController,
      this.mode,
      this.digitalClock,
      this.onHourSelected,
      this.onMinuteSelected})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (digitalClock == DigitalClock.normal) return normalTimedisplay(context);
    return digitalTimeDisplay(context);
  }

  Widget normalTimedisplay(context) {
    final theme = Theme.of(context);
    return RichText(
        text: TextSpan(
            text: clockController.hourInString,
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                onHourSelected();
              },
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: mode == TimeChangeMode.hour
                    ? theme.errorColor
                    : theme.primaryColorDark,
                fontSize: 40),
            children: [
          TextSpan(
            text: " : ",
            style: TextStyle(
                color: theme.primaryColorDark,
                fontSize: 40,
                decoration: TextDecoration.none),
          ),
          TextSpan(
            text: clockController.minuteInString,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: mode == TimeChangeMode.minute
                    ? theme.errorColor
                    : theme.primaryColorDark,
                fontSize: 40),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                onMinuteSelected();
              },
          ),
        ]));
  }

  Widget digitalTimeDisplay(context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TimeBox(
            timeType: "HRS",
            time: clockController.hourInString,
            onPressed: onHourSelected,
            backGroundColor: mode == TimeChangeMode.hour
                ? theme.primaryColor
                : theme.primaryColorDark,
          ),
          SizedBox(
            width: 10,
          ),
          Text(":", style: theme.textTheme.bodyText2.copyWith(fontSize: 40)),
          SizedBox(
            width: 10,
          ),
          TimeBox(
            timeType: "MIN",
            onPressed: onMinuteSelected,
            time: clockController.minuteInString,
            backGroundColor: mode == TimeChangeMode.hour
                ? theme.primaryColor
                : theme.primaryColorDark,
          ),
        ],
      ),
    );
  }
}
