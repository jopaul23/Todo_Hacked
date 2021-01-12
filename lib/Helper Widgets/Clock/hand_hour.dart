import 'dart:math' as math;

import 'package:Todo_App/Helper%20Widgets/Clock/Providers/time_provider.dart';
import 'package:Todo_App/styles/styles.dart';
import 'package:flutter/material.dart';

class HourHandPainter extends CustomPainter {
  final Paint hourHandPaint;
  final int hours;
  final int minutes;
  final TimeChangeMode mode;
  HourHandPainter({this.hours, this.minutes, this.mode})
      : hourHandPaint = new Paint() {
    hourHandPaint.color = Styles.grey2;
    hourHandPaint.strokeWidth = 4.0;

    //hourHandPaint.style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final radius = size.width / 2;
    // To draw hour hand
    canvas.save();

    canvas.translate(radius, radius);

    //checks if hour is greater than 12 before calculating rotation
    if (mode == TimeChangeMode.hour)
      canvas.rotate(2 * math.pi * (((this.hours - 3) / 12) + (0 / 720)));
    else
      canvas.rotate(2 * math.pi * ((this.minutes - 15 + (0 / 60)) / 60));

    // Path path = new Path();

    final circleOffset = Offset(radius, 0);
    canvas.drawLine(circleOffset, Offset(0, 0), hourHandPaint);

    canvas.drawCircle(circleOffset, 15.0, hourHandPaint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(HourHandPainter oldDelegate) {
    return true;
  }
}
