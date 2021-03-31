import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../colors.dart';

enum AppThemes { LightOranage, DarkViolet, DarkPurple, LightGreen, LightBlue }

final Map appThemeMap = {
  AppThemes.LightOranage: themeData(t1Orange),
  AppThemes.DarkViolet: themeData(Color(0xff2c5364)),
  AppThemes.DarkPurple: themeData(Color(0xff734b6d)),
  AppThemes.LightGreen: themeData(Color(0xff45b549)),
  AppThemes.LightBlue: themeData(Color(0xff00799a)),
};

ThemeData themeData(Color primaryColor) => ThemeData(
    fontFamily: GoogleFonts.rubik().fontFamily,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    backgroundColor: white2.withOpacity(.96),
    primaryColor: primaryColor,
    dialogBackgroundColor: white2,
    accentColor: white2,
    primaryColorDark: greyDark,
    primaryColorLight: Colors.white,
    errorColor: red,
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: Colors.white,
    ),
    iconTheme: IconThemeData(
      color: primaryColor,
    ),
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
        primary: Color(0xfff6961e),
        secondary: Color(0xffffd100),
        secondaryVariant: grey1.withOpacity(0.2)),
    buttonColor: Colors.white,
    textTheme: TextTheme(
        headline3: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 22,
          color: black,
          decoration: TextDecoration.none,
        ),
        headline2: TextStyle(
          fontSize: 25,
          color: Colors.white,
          fontWeight: FontWeight.w800,
          decoration: TextDecoration.none,
        ),
        bodyText1: TextStyle(
          fontSize: 20,
          color: greyDark,
        ),
        bodyText2: TextStyle(
          color: grey1,
          fontWeight: FontWeight.bold,
        ),
        caption: TextStyle(color: Colors.white)),
    inputDecorationTheme: InputDecorationTheme(
      border: InputBorder.none,
      hintStyle: TextStyle(
        color: grey1.withOpacity(0.8),
        fontWeight: FontWeight.w400,
        fontSize: 20,
      ),
    ));
