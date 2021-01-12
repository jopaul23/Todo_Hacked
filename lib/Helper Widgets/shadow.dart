import 'package:Todo_App/styles/styles.dart';
import 'package:flutter/material.dart';

class BoxShadowContainer extends StatelessWidget {
  final double height, width;
  final Widget child;
  final Alignment alignment;
  final Color color;
  final BorderRadius radius;
  const BoxShadowContainer(
      {this.height = 55,
      this.width = 300,
      this.color,
      this.radius,
      @required this.child,
      this.alignment = Alignment.center});
  @override
  Widget build(BuildContext context) {
    Color bgColor = color == null ? Styles.white1.withOpacity(.23) : color;
    BorderRadius rad =
        radius == null ? BorderRadius.all(Radius.circular(40.0)) : radius;
    return Container(
      alignment: alignment,
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: rad,
        boxShadow: [
          BoxShadow(
            color: Styles.grey4.withOpacity(0.01),
            spreadRadius: 10,
            blurRadius: 7,
            offset: Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: child,
    );
  }
}
