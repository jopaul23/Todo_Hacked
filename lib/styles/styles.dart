import 'package:flutter/material.dart';

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

  static Color white1 = Color(0xffffffff);
  static Color white2 = Color(0xfff6f6f6);
  static Color white3 = Color(0xfff2f2f2);

  static Color grey1 = Color(0xffb3b3b3);
  static Color grey2 = Color(0xff666666);
  static Color grey3 = Color(0xff4d4d4d);
  static Color grey4 = Color(0xff333333);

  static Color red = Color(0xffff4a59);
}
// Theme gradient (t1_gradient): "ffd100"-"f6961e"(yelow -orange gradient)*
// theme text color(t1_orange) : "f7931e"*

// common text color1(white1) : "ffffff"*

// common text color2(Grey1) : "b3b3b3"*
// common text color2(Grey2) : "666666"*
// common text color3(Grey3) : "4d4d4d"*
// common text color3(Grey4) : "333333"*

// White1 = "ffffff"*
// White2 = "f6f6f6"*
// White3 = "f2f2f2"*

// Red = "ff4a59"
