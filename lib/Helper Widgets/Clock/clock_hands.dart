import 'package:flutter/material.dart';

import 'Functions/clock_functions.dart';
import 'hand_hour.dart';

class ClockHands extends StatelessWidget {
  final String hour, min;
  final TimeChangeMode mode;

  const ClockHands({Key key, this.hour, this.min, this.mode}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
        aspectRatio: 1.0,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20.0),
          child: Stack(fit: StackFit.expand, children: <Widget>[
            CustomPaint(
              painter: HourHandPainter(
                  mode: mode, hours: int.parse(hour), minutes: int.parse(min)),
            )
          ]),
        ));
  }
}
