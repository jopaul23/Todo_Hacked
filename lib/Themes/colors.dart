import 'package:Todo_App/Themes/themes/light.dart';
import 'package:flutter/material.dart';

const Color t1Orange = Color(0xfff6961e);
const Color cream = Color(0xffe5e5e5);
const Color white2 = Color(0xfff5f5f5);
const Color white3 = Color(0xfff2f2f2);
const Color grey1 = Color(0xffb2b2b2);
const Color greyDark = Color(0xff4d4d4d);
const Color black = Color(0xff333333);
const Color red = Color(0xffff4a59);
final Map gradientMap = {
  AppThemes.LightOranage: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Color(0xfff6961e), Color(0xffffd100)]),
  AppThemes.DarkPurple: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Color(0xff734b6d), Color(0xff42275a)]),
  AppThemes.DarkViolet: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Color(0xff2c5364), Color(0xff203a43), Color(0xff0f2027)]),
  AppThemes.LightGreen: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Color(0xff45b549), Color(0xffdbe25b)]),
  AppThemes.LightBlue: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Color(0xff78ffd5), Color(0xff00799a)])
};
final shadow = BoxShadow(
  spreadRadius: 20,
  blurRadius: 10,
  color: black.withOpacity(0.02),
  offset: Offset(0, 2), // changes position of shadow
);
