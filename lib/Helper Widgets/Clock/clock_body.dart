import 'dart:math';

import 'package:Todo_App/styles/styles.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';

import 'Providers/time_provider.dart';
import 'clock_face.dart';

class ClockBody extends HookWidget {
  final Function(String hour, String minute, bool beforeNoon) onClicked;
  final bool isBeforeNoon;
  ClockBody({this.onClicked, this.isBeforeNoon = true});
  @override
  Widget build(BuildContext context) {
    final hour = useProvider(timeHourProvider.state);
    final min = useProvider(timeMinuteProvider.state);
    final mode = useProvider(timeChangeModeProvider.state);
    final bool isHourSelected = mode == TimeChangeMode.hour;
    final beforeNoon = useState(isBeforeNoon);
    return GestureDetector(
      onPanStart: (DragStartDetails details) {
        String time = calculateTime(details.localPosition, isHourSelected);

        if (isHourSelected)
          context.read(timeHourProvider).updateTime(time);
        else
          context.read(timeMinuteProvider).updateTime(time);
      },
      onPanUpdate: (DragUpdateDetails details) {
        String time = calculateTime(details.localPosition, isHourSelected);
        if (isHourSelected) {
          context.read(timeHourProvider).updateTime(time);
        } else
          context.read(timeMinuteProvider).updateTime(time);
      },
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 80.0, vertical: 15),
            child: RichText(
                text: TextSpan(
                    text: "$hour",
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        context
                            .read(timeChangeModeProvider)
                            .changeMode(TimeChangeMode.hour);
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
                        context
                            .read(timeChangeModeProvider)
                            .changeMode(TimeChangeMode.minute);
                      },
                  ),
                ])),
          ),
          Positioned(
            right: 60,
            top: 10,
            child: Stack(
              children: [
                GestureDetector(
                  onTap: () => beforeNoon.value = true,
                  child: Text(
                    "am",
                    style: TextStyle(
                        color: !beforeNoon.value ? Colors.grey : Styles.red,
                        fontSize: 25,
                        decoration: TextDecoration.none),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: GestureDetector(
                    onTap: () => beforeNoon.value = false,
                    child: Text(
                      "pm",
                      style: TextStyle(
                          color: beforeNoon.value ? Colors.grey : Styles.red,
                          fontSize: 25,
                          decoration: TextDecoration.none),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: AspectRatio(
                aspectRatio: 1.0,
                child: Stack(children: <Widget>[
                  Center(
                    child: Container(
                      width: 200,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Styles.t1Orange,
                      ),
                      child: ClockFace(),
                    ),
                  )
                ])),
          ),
          Positioned(
            bottom: 0,
            right: 30,
            child: TextButton(
              onPressed: () {
                onClicked(hour, min, beforeNoon.value);
              },
              child: Text(
                "OK",
                style: TextStyle(
                  fontSize: 25.0,
                  color: Styles.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  String calculateTime(Offset offset, bool isHour) {
    double angle = atan2(-(175 - offset.dx), (175 - offset.dy)) * 180 / pi;
    angle = angle + 180;
    if (isHour) {
      String hour = (((angle + 15) ~/ 30 + 6) % 12).toString();
      if (hour == "0") hour = "12";
      if (hour.length == 1) hour = "0" + hour;
      return hour;
    } else {
      String minute = (((angle + 3) ~/ 6 + 30) % 60).toString();
      if (minute.length == 1) minute = "0" + minute;
      return minute;
    }
  }
}
