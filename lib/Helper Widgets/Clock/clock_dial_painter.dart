import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'Functions/clock_functions.dart';

class ClockDialPainter extends CustomPainter {
  final Paint tickPaint;
  final TextPainter textPainter;
  final TextStyle textStyle;
  final TimeChangeMode mode;
  ClockDialPainter(this.mode)
      : tickPaint = Paint(),
        textPainter = TextPainter(
          textAlign: TextAlign.center,
          textDirection: TextDirection.rtl,
        ),
        textStyle = TextStyle(
            // color: Styles.t1Orange,
            fontSize: 18.0,
            fontWeight: FontWeight.w500) {
    tickPaint.color = Colors.blueGrey;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final angle = 2 * math.pi / 60;
    final radius = size.width / 2;
    canvas.save();

    // drawing
    canvas.translate(radius, radius);
    for (var i = 0; i < 60; i++) {
      if (i % 5 == 0) {
        canvas.save();
        canvas.translate(0.0, -radius + 5);

        textPainter.text = TextSpan(
          text: mode == TimeChangeMode.hour
              ? '${i == 0 ? 12 : i ~/ 5}'
              : i == 0
                  ? "00"
                  : "$i",
          style: textStyle,
        );

        //helps make the text painted vertically
        canvas.rotate(-angle * i);

        textPainter.layout();

        textPainter.paint(canvas,
            Offset(-(textPainter.width / 2), -(textPainter.height / 2)));

        canvas.restore();
      }

      canvas.rotate(angle);
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
