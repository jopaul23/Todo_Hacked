import 'package:Todo_App/Helper%20Widgets/Clock/analog_clock.dart';
import 'package:flutter/material.dart';

import '../Helper Widgets/Clock/Display Time/clock_digital_display.dart';
import '../Helper Widgets/Clock/Functions/clock_functions.dart';
import '../Themes/colors.dart';

OverlayEntry createReminderOverlay(
    {int hour,
    int minute,
    DigitalClock clock = DigitalClock.normal,
    Function(String, String) onSelected}) {
  print("$hour:$minute");
  ClockController clockController = ClockController()
    ..isBeforeNoon = hour < 12
    ..updateHour(hour)
    ..updateMinute(minute);

  return OverlayEntry(builder: (context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Container(
          height: 400,
          width: 400,
          decoration: BoxDecoration(
            //      color: Styles.white1,
            borderRadius: const BorderRadius.all(Radius.circular(35.0)),
            //   boxShadow: [Styles.shadow()]
          ),
          child: Stack(
            children: [
              AnalogClock(
                clockController: clockController,
                display: DigitalClock.remainder,
                padding: EdgeInsets.only(top: 80, right: 20),
              ),
              Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 50.0, bottom: 8.0),
                    child: TextButton(
                      onPressed: () {
                        onSelected(clockController.hourInString,
                            clockController.minuteInString);
                      },
                      child: Text("Ok",
                          style: TextStyle(
                              color: Colors.red,
                              decoration: TextDecoration.none,
                              fontSize: 30,
                              fontWeight: FontWeight.bold)),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  });
}
