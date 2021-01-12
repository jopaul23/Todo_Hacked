import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';

import 'Providers/time_provider.dart';
import 'hand_hour.dart';

class ClockHands extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final hour = useProvider(timeHourProvider.state);
    final mode = useProvider(timeChangeModeProvider.state);
    final min = useProvider(timeMinuteProvider.state);
    return AspectRatio(
        aspectRatio: 1.0,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20.0),
          child: Stack(fit: StackFit.expand, children: <Widget>[
            CustomPaint(
              painter: HourHandPainter(
                  hours: mode == TimeChangeMode.hour
                      ? int.parse(hour)
                      : int.parse(min) ~/ 5,
                  minutes: 0),
            )
          ]),
        ));
  }
}
