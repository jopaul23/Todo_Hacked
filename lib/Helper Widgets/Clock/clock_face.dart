import 'package:flutter/material.dart';

import 'Functions/clock_functions.dart';
import 'clock_dial_painter.dart';
import 'hand_hour.dart';
import '../../styles/styles.dart';

class ClockFace extends StatelessWidget {
  final int hour, min;
  final TimeChangeMode mode;

  const ClockFace({Key key, this.hour, this.min, this.mode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: AspectRatio(
        aspectRatio: 1.0,
        child: Container(
          width: double.infinity,
          decoration:
              BoxDecoration(shape: BoxShape.circle, color: Styles.white1),
          child: Stack(
            children: <Widget>[
              //clock hands go here
              AspectRatio(
                  aspectRatio: 1.0,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20.0),
                    child: Stack(fit: StackFit.expand, children: <Widget>[
                      CustomPaint(
                        painter: HourHandPainter(
                            mode: mode, hours: hour, minutes: min),
                      )
                    ]),
                  )),
              //centerpoint
              Center(
                child: Container(
                  width: 15.0,
                  height: 15.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Styles.t1Orange,
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: double.infinity,
                padding: const EdgeInsets.all(10.0),
                child: CustomPaint(
                  painter: ClockDialPainter(
                    mode,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
