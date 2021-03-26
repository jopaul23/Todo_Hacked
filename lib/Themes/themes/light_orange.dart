import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../colors.dart';

ThemeData themeData() => ThemeData(
    fontFamily: GoogleFonts.rubik().fontFamily,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    backgroundColor: white2.withOpacity(.96),
    primaryColor: t1Orange,
    dialogBackgroundColor: white1,
    accentColor: white2,
    primaryColorDark: grey2,
    primaryColorLight: white1,
    errorColor: red,
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: grey2,
    ),
    iconTheme: IconThemeData(
      color: t1Orange,
    ),
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
        primary: Color(0xfff6961e),
        secondary: Color(0xffffd100),
        secondaryVariant: grey1.withOpacity(0.2)),
    buttonColor: white1,
    textTheme: TextTheme(
        headline3: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 22,
          color: grey4,
          decoration: TextDecoration.none,
        ),
        headline2: TextStyle(
          fontSize: 25,
          color: white1,
          fontWeight: FontWeight.w800,
          decoration: TextDecoration.none,
        ),
        bodyText1: TextStyle(
          fontSize: 20,
          color: grey2,
        ),
        bodyText2: TextStyle(
          color: red,
          fontWeight: FontWeight.bold,
        ),
        caption: TextStyle(color: white1)),
    inputDecorationTheme: InputDecorationTheme(
      border: InputBorder.none,
      hintStyle: TextStyle(
        color: grey1.withOpacity(0.8),
        fontWeight: FontWeight.w400,
        fontSize: 20,
      ),
    ));
