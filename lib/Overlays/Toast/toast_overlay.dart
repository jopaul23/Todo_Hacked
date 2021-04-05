import 'dart:async';
import 'package:todo_app/Themes/colors.dart';
import 'package:flutter/material.dart';

import 'toastWidget.dart';

class Toast {
  OverlayEntry _toastOverlay;
  Toast(this.message);
  String message;
  Timer _timer;
  AnimationController animationController;
  Color backgroundColor = black.withOpacity(0.9);
  Alignment alignment = Alignment.bottomCenter;
  TextStyle messageStyle = TextStyle(
      fontSize: 18, //color: Styles.white1
      color: Colors.white);
  Duration duration = const Duration(seconds: 3);

  void showToast(context) {
    if (_timer == null || !_timer.isActive) {
      _toastOverlay = OverlayEntry(builder: (context) {
        return ToastWidget(
          toast: this,
        );
      });
      _timer = Timer.periodic(duration, (_) {
        _toastOverlay.remove();
        _timer.cancel();
      });
      Overlay.of(context).insert(_toastOverlay);
    }
  }
}
