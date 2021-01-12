import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';

import 'Providers/time_provider.dart';
import 'hand_hour.dart';

class ClockHands extends HookWidget {
  final List positions = [
    Offset(121.4, 14.8),
    Offset(151.5, 46.1),
    Offset(160.6, 81.7),
    Offset(155.9, 120.6),
    Offset(125.0, 151.9),
    Offset(83.5, 161.0),
    Offset(45.7, 147.5),
    Offset(20.3, 122.8),
    Offset(6.8, 85.0),
    Offset(20, 53),
    Offset(45.7, 23.9),
    Offset(88.3, 10.4)
  ];
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
          child: GestureDetector(
            onPanStart: (DragStartDetails details) {
              final Offset selectedOff = details.localPosition;
              for (int i = 0; i < positions.length; i++) {
                final Offset off = positions[i];
                var distance = off - selectedOff;

                if (distance.dx.abs() >= 0 &&
                    distance.dx.abs() <= 20 &&
                    distance.dy.abs() >= 0 &&
                    distance.dy.abs() <= 20) {
                  if (mode == TimeChangeMode.hour) {
                    String time = "${i + 1}";
                    if (time.length == 1) time = "0$time";
                    context.read(timeHourProvider).updateTime(time);
                  } else {
                    String time = "${(i + 1) * 5}";
                    time = time == "60" ? "00" : time;
                    if (time.length == 1) time = "0$time";
                    context.read(timeMinuteProvider).updateTime(time);
                  }

                  break;
                }
              }
            },
            child: Stack(fit: StackFit.expand, children: <Widget>[
              CustomPaint(
                painter: HourHandPainter(
                    hours: mode == TimeChangeMode.hour
                        ? int.parse(hour)
                        : int.parse(min) ~/ 5,
                    minutes: 0),
              )
            ]),
          )),
    );
  }
}
