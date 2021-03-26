import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../Functions/clock_functions.dart';
import '../Functions/providers.dart';
import 'clock_digital_display.dart';

class TimeDisplay extends HookWidget {
  final ClockController clockController;
  final DigitalClock digitalClock;

  const TimeDisplay({Key key, this.clockController, this.digitalClock})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mode = useProvider(timeChangeModeProvider);
    final modeValue = useProvider(timeChangeModeProvider.state);
    final isBeforeNoon = useState(clockController.isBeforeNoon);
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClockDigitalDisplay(
            clockController: clockController,
            digitalClock: digitalClock,
            mode: modeValue,
            onHourSelected: () {
              mode.changeMode(TimeChangeMode.hour);
            },
            onMinuteSelected: () {
              mode.changeMode(TimeChangeMode.minute);
            },
          ),
          RichText(
            text: TextSpan(
                text: "am\n",
                style: TextStyle(
                    color: isBeforeNoon.value
                        ? theme.errorColor
                        : theme.primaryColorDark,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    if (!isBeforeNoon.value) {
                      isBeforeNoon.value = true;
                      clockController.isBeforeNoon = isBeforeNoon.value;
                      clockController.updateHour(clockController.hour);
                    }
                  },
                children: [
                  TextSpan(
                    text: "pm",
                    style: TextStyle(
                        color: !isBeforeNoon.value
                            ? theme.errorColor
                            : theme.primaryColorDark,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.none),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        if (isBeforeNoon.value) {
                          isBeforeNoon.value = false;
                          clockController.isBeforeNoon = isBeforeNoon.value;
                          clockController.updateHour(clockController.hour);
                        }
                      },
                  ),
                ]),
          )
        ],
      ),
    );
  }
}
