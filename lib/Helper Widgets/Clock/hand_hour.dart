import 'dart:math' as math;

import 'package:Todo_App/styles/styles.dart';
import 'package:flutter/material.dart';

class HourHandPainter extends CustomPainter {
  final Paint hourHandPaint;
  int hours;
  int minutes;

  HourHandPainter({this.hours, this.minutes}) : hourHandPaint = new Paint() {
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
    canvas
        .rotate(2 * math.pi * (((this.hours - 3) / 12) + (this.minutes / 720)));

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
