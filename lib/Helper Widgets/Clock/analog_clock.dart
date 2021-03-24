import 'package:Todo_App/Styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';

import 'Display Time/clock_digital_display.dart';
import 'Display Time/time_display.dart';
import 'Functions/clock_functions.dart';
import 'clock_face.dart';
import 'Functions/providers.dart';

class AnalogClock extends HookWidget {
  final ClockController clockController;
  final DigitalClock display;
  final EdgeInsets padding;
  const AnalogClock(
      {Key key,
      this.clockController,
      this.display = DigitalClock.normal,
      this.padding = const EdgeInsets.only(top: 50, left: 40.0)})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final mode = useProvider(timeChangeModeProvider.state);
    final hour = useState(clockController.hour);
    final min = useState(clockController.minute);

    return GestureDetector(
      onPanStart: (DragStartDetails details) {
        calculateTime(details, hour, min, mode);
      },
      onPanUpdate: (DragUpdateDetails details) {
        calculateTime(details, hour, min, mode);
      },
      child: Stack(
        children: [
          TimeDisplay(
            digitalClock: display,
            clockController: clockController,
          ),
          Padding(
            padding: padding,
            child: AspectRatio(
                aspectRatio: 1,
                child: Stack(children: <Widget>[
                  Center(
                    child: Container(
                      width: 200,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Styles.t1Orange,
                      ),
                      child: ClockFace(
                        hour: hour.value,
                        min: min.value,
                        mode: mode,
                      ),
                    ),
                  )
                ])),
          ),
        ],
      ),
    );
  }

  void calculateTime(details, hour, min, mode) {
    if (mode == TimeChangeMode.hour)
      hour.value = clockController.calculateHour(details.localPosition);
    else
      min.value = clockController.calculateMinute(details.localPosition);
  }
}
