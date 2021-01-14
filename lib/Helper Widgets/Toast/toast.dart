import 'dart:async';

import 'package:Todo_App/Helper%20Widgets/Toast/toastWidget.dart';
import 'package:Todo_App/styles/styles.dart';
import 'package:flutter/material.dart';

class Toast {
  OverlayEntry _toastOverlay;
  Toast(this.message);
  String message;
  Timer _timer;
  AnimationController animationController;
  Color backgroundColor = Colors.black;
  Alignment alignment = Alignment.bottomCenter;
  TextStyle messageStyle = TextStyle(fontSize: 18, color: Styles.white1);
  Duration duration = const Duration(seconds: 3);

  void showToast(context) {
    if (_timer == null || !_timer.isActive) {
      _toastOverlay = OverlayEntry(builder: (context) {
        return ToastWidget(
          alignment: alignment,
          backgroundColor: backgroundColor,
          message: message,
          messageStyle: messageStyle,
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
