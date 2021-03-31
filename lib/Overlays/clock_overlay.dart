import 'package:Todo_App/Helper%20Widgets/Clock/analog_clock.dart';
import 'package:flutter/material.dart';

import '../Helper Widgets/Clock/Display Time/clock_digital_display.dart';
import '../Helper Widgets/Clock/Functions/clock_functions.dart';
import '../Themes/colors.dart';

OverlayEntry createClockOverlay(
    {DateTime date,
    DigitalClock clock = DigitalClock.normal,
    Function(String hour, String minute) onSelected}) {
  ClockController clockController = ClockController()
    ..isBeforeNoon = date.hour < 12
    ..updateHour(date.hour)
    ..updateMinute(date.minute);

  return OverlayEntry(builder: (context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Container(
          height: 300,
          width: 400,
          decoration: BoxDecoration(
            //       color: Styles.white1,
            borderRadius: const BorderRadius.all(Radius.circular(35.0)),
            //   boxShadow: [Styles.shadow()]
          ),
          child: Stack(
            children: [
              AnalogClock(
                  clockController: clockController,
                  padding: const EdgeInsets.only(top: 50, left: 40.0)),
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
