import 'package:flutter/widgets.dart';

class MessageBorder extends ShapeBorder {
  final bool arrowAtTop;
  MessageBorder(this.arrowAtTop);

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.only(bottom: 20);

  @override
  Path getInnerPath(Rect rect, {TextDirection textDirection}) => null;

  @override
  Path getOuterPath(Rect rect, {TextDirection textDirection}) {
    rect = Rect.fromPoints(rect.topLeft, rect.bottomRight - Offset(0, 20));
    if (arrowAtTop)
      return Path()
        ..addRRect(RRect.fromRectAndRadius(rect, Radius.circular(35)))
        ..moveTo(rect.topCenter.dx + 10, rect.topCenter.dy)
        ..relativeLineTo(-10, -20)
        ..relativeLineTo(-10, 20)
        ..close();
    else
      return Path()
        ..addRRect(RRect.fromRectAndRadius(rect, Radius.circular(35)))
        ..moveTo(rect.bottomCenter.dx - 10, rect.bottomCenter.dy)
        ..relativeLineTo(10, 20)
        ..relativeLineTo(10, -20)
        ..close();
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection textDirection}) {
    // TODO: implement paint
  }

  @override
  ShapeBorder scale(double t) => this;
}
