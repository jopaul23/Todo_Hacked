import 'package:flutter/material.dart';

import '../Helper Widgets/Clock/clock_digital_display.dart';
import '../Helper Widgets/Clock/clock_body.dart';
import '../Helper Widgets/Clock/Functions/clock_functions.dart';
import '../Styles/styles.dart';

OverlayEntry createReminderOverlay(
    {String hour,
    String minute,
    DigitalClock clock = DigitalClock.normal,
    Function(Duration) onSelected}) {
  print("$hour:$minute");
  ClockFunctions timeProvider = ClockFunctions()
    ..updateHourIgnoringAmPm("${int.parse(hour)}")
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
            beforeNoon: true,
            onClicked: (String hour, String minute) {
              final duration =
                  Duration(hours: int.parse(hour), minutes: int.parse(minute));
              onSelected(duration);
            },
          ),
        ),
      ),
    );
  });
}
