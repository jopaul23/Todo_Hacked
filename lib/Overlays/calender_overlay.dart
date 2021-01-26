import "package:flutter/material.dart";

import '../Helper Widgets/Calender/calender.dart';

OverlayEntry createCalenderOverlay({Function(DateTime) onSelected}) =>
    OverlayEntry(builder: (context) {
      final Size size = MediaQuery.of(context).size;
      return Positioned(
        top: size.height * 0.5 - 200,
        left: (size.width - 350) / 2,
        child: Center(
          child: HomeCalendarPage(onSelected: onSelected),
        ),
      );
    });
