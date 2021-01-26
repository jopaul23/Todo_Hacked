import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class Styles {
  static Gradient t1Gradient = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [
      Color(0xfff6961e),
      Color(0xffffd100),
    ],
  );
  static Color t1Orange = Color(0xfff6961e);

  static Color cream = Color(0xfff2f6e7);

  static Color white1 = Color(0xffffffff);
  static Color white2 = Color(0xfff6f6f6);
  static Color white3 = Color(0xfff2f2f2);

  static Color grey1 = Color(0xffb3b3b3);
  static Color grey2 = Color(0xff666666);
  static Color grey3 = Color(0xff4d4d4d);
  static Color grey4 = Color(0xff333333);
  static BoxShadow shadow({color}) => BoxShadow(
        color: color ?? Styles.grey4.withOpacity(0.02),
        spreadRadius: 10,
        blurRadius: 7,
        offset: Offset(0, 2), // changes position of shadow
      );
  static Color red = Color(0xffff4a59);

  static ThemeData themeData() => ThemeData(
      fontFamily: GoogleFonts.rubik().fontFamily,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      backgroundColor: white2.withOpacity(.96),
      textTheme: TextTheme(
        headline3: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 18,
          color: white2,
          decoration: TextDecoration.none,
        ),
        headline2: TextStyle(
          fontSize: 20,
          color: Styles.grey2,
          fontWeight: FontWeight.w800,
          decoration: TextDecoration.none,
        ),
        bodyText1: TextStyle(
          fontSize: 30,
          color: Styles.grey2,
        ),
      ),
      cursorColor: Styles.grey1,
      inputDecorationTheme: InputDecorationTheme(
        border: InputBorder.none,
        hintStyle: TextStyle(
          color: grey1.withOpacity(0.8),
          fontWeight: FontWeight.w400,
          fontSize: 30,
        ),
      ));
}
