import 'package:flutter/material.dart';

import 'toast_overlay.dart';

class ToastWidget extends StatefulWidget {
  final Toast toast;

  const ToastWidget({Key key, this.toast}) : super(key: key);

  @override
  _ToastWidgetState createState() => _ToastWidgetState();
}

class _ToastWidgetState extends State<ToastWidget>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    )..addListener(() {
        setState(() {});
      });
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      Align(alignment: widget.toast.alignment, child: _toastWidget());

  Widget _toastWidget() {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10.0))),
      child: Container(
        height: _animationController.value * 50,
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: widget.toast.backgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            "${widget.toast.message}",
            style: widget.toast.messageStyle,
          ),
        ),
      ),
    );
  }
}
