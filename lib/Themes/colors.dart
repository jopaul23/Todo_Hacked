import 'dart:math';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:todo_app/Themes/themes/light.dart';

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
      transform: GradientRotation(pi / 4),
      begin: Alignment.bottomCenter,
      end: Alignment.topRight,
      colors: [
        HexColor("ffd100"),
        HexColor("f6961e"),
      ]),
  AppThemes.DarkPurple: LinearGradient(
      transform: GradientRotation(pi / 4),
      begin: Alignment.topLeft,
      end: Alignment.centerRight,
      colors: [
        HexColor("2f0743"),
        HexColor("41295a"),
      ]),
  AppThemes.DarkViolet: LinearGradient(
      transform: GradientRotation(pi / 4),
      begin: Alignment.topLeft,
      end: Alignment.centerRight,
      colors: [
        HexColor("293b4d"),
        HexColor("000000"),
      ]),
  AppThemes.LightGreen: LinearGradient(
      transform: GradientRotation(pi / 4),
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
      colors: [
        HexColor("b8d857"),
        HexColor("45b549"),
      ]),
  AppThemes.LightBlue: LinearGradient(
      transform: GradientRotation(pi / 4),
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
      colors: [
        HexColor("78ffd5"),
        HexColor("00799a"),
      ])
};
final shadow = BoxShadow(
  spreadRadius: 20,
  blurRadius: 10,
  color: black.withOpacity(0.02),
  offset: Offset(0, 2), // changes position of shadow
);
