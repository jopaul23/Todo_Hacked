import 'package:flutter/material.dart';

enum AppThemes { LightOranage }

final Map appThemeMap = {
  AppThemes.LightOranage: ThemeData(
    brightness: Brightness.light,
  )
};
