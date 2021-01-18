import 'dart:math';

import 'package:Todo_App/styles/styles.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';

import 'Providers/time_provider.dart';
import 'clock_digital_display.dart';
import 'clock_face.dart';

class ClockBody extends StatefulWidget {
  final Function(String hour, String minute) onClicked;
  final digitalClock;
  final timeContainer;
  final bool beforeNoon;
  const ClockBody(
      {Key key,
      this.digitalClock,
      this.onClicked,
      this.timeContainer,
      this.beforeNoon})
      : super(key: key);
  @override
  _ClockodyState createState() => _ClockodyState();
}

class _ClockodyState extends State<ClockBody> {
  TimeChangeMode mode = TimeChangeMode.hour;
  bool isBeforeNoon;
  @override
  void initState() {
    isBeforeNoon = widget.beforeNoon;
    print(widget.timeContainer.time);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isHourSelected = mode == TimeChangeMode.hour;
    return GestureDetector(
      onPanStart: (DragStartDetails details) {
        String time = calculateTime(details.localPosition, isHourSelected);

        if (isHourSelected) if (widget.digitalClock == DigitalClock.normal)
          widget.timeContainer.updateHour(time, isBeforeNoon);
        else
          widget.timeContainer.updateHourIgnoringAmPm(time);
        else
          widget.timeContainer.updateMinute(time);

        this.setState(() {});
      },
      onPanUpdate: (DragUpdateDetails details) {
        String time = calculateTime(details.localPosition, isHourSelected);

        if (isHourSelected) if (widget.digitalClock == DigitalClock.normal)
          widget.timeContainer.updateHour(time, isBeforeNoon);
        else
          widget.timeContainer.updateHourIgnoringAmPm(time);
        else
          widget.timeContainer.updateMinute(time);
        this.setState(() {});
      },
      child: Stack(
        children: [
          ClockDigitalDisplay(
            time: widget.timeContainer.time,
            digitalClock: widget.digitalClock,
            mode: mode,
            isHourSelected: isHourSelected,
            onHourSelected: () {
              this.setState(() {
                mode = TimeChangeMode.hour;
              });
            },
            onMinuteSelected: () {
              this.setState(() {
                mode = TimeChangeMode.minute;
              });
            },
          ),
          if (widget.digitalClock == DigitalClock.normal)
            Positioned(
              right: 60,
              top: 10,
              child: Stack(
                children: [
                  GestureDetector(
                    onTap: () {
                      if (!isBeforeNoon) {
                        widget.timeContainer.changeTo12(
                          widget.timeContainer.time.split(":")[0],
                        );
                        print("new time is");
                        print(widget.timeContainer.time);
                      }
                      this.setState(() {
                        isBeforeNoon = true;
                      });
                    },
                    child: Text(
                      "am",
                      style: TextStyle(
                          color: isBeforeNoon ? Styles.red : Colors.grey,
                          fontSize: 25,
                          decoration: TextDecoration.none),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: GestureDetector(
                      onTap: () {
                        if (isBeforeNoon) {
                          widget.timeContainer.changeTo24(
                            widget.timeContainer.time.split(":")[0],
                          );
                          print("new time is");
                          print(widget.timeContainer.time);
                        }
                        this.setState(() {
                          isBeforeNoon = false;
                        });
                      },
                      child: Text(
                        "pm",
                        style: TextStyle(
                            color: isBeforeNoon ? Colors.grey : Styles.red,
                            fontSize: 25,
                            decoration: TextDecoration.none),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          Padding(
            padding: const EdgeInsets.only(top: 50.0),
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
                      child: ClockFace(
                        hour: widget.timeContainer.time.substring(0, 2),
                        min: widget.timeContainer.time.substring(3),
                        mode: mode,
                      ),
                    ),
                  )
                ])),
          ),
          Positioned(
            bottom: 0,
            right: 30,
            child: TextButton(
              onPressed: () {
                String hour = widget.timeContainer.time.substring(0, 2);
                String min = widget.timeContainer.time.substring(3);
                widget.onClicked(hour, min);
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
