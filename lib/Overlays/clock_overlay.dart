import 'package:flutter/material.dart';

import '../Helper Widgets/Clock/clock_digital_display.dart';
import '../Helper Widgets/Clock/clock_body.dart';
import '../Helper Widgets/Clock/Functions/clock_functions.dart';
import '../Styles/styles.dart';

OverlayEntry createClockOverlay(
    {DateTime date,
    DigitalClock clock = DigitalClock.normal,
    Function(String hour, String minute) onSelected}) {
  String hour = date.hour.toString();
  String minute = date.minute.toString();

  final bool isBeforeNoon = date.hour < 12;
  ClockFunctions timeProvider = ClockFunctions()
    ..updateHour(isBeforeNoon ? hour : "${int.parse(hour) - 12}", isBeforeNoon)
    ..updateMinute(minute);
  return OverlayEntry(builder: (context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Container(
          height: 300,
          width: 400,
          decoration: BoxDecoration(
              color: Styles.white1,
              borderRadius: const BorderRadius.all(Radius.circular(35.0)),
              boxShadow: [Styles.shadow()]),
          child: ClockBody(
            digitalClock: clock,
            timeContainer: timeProvider,
            beforeNoon: isBeforeNoon,
            onClicked: onSelected,
            // DateTime time;
            // final duration =
            //     Duration(hours: int.parse(hour), minutes: int.parse(minute));
            // if (!date.isAfter(date))
            //   time = date.subtract(duration);
            // else
            //   time = date.add(duration);
          ),
        ),
      ),
    );
  });
}
