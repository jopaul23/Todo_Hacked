import 'package:Todo_App/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'Providers/time_provider.dart';
import 'clock_dial_painter.dart';
import 'clock_hands.dart';

class ClockFace extends StatelessWidget {
  final String hour, min;
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
              ClockHands(
                hour: hour,
                min: min,
                mode: mode,
              ),
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
