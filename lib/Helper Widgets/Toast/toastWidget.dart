import 'package:Todo_App/styles/styles.dart';
import 'package:flutter/material.dart';

class ToastWidget extends StatefulWidget {
  final TextStyle messageStyle;
  final Color backgroundColor;
  final String message;
  final Alignment alignment;
  final Function() onClose;

  const ToastWidget(
      {Key key,
      this.messageStyle,
      this.backgroundColor,
      this.message,
      this.onClose,
      this.alignment})
      : super(key: key);
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
  Widget build(BuildContext context) {
    debugPrint("toast wdiget");
    print(_animationController.value);
    return Align(alignment: widget.alignment, child: _toastWidget());
  }

  Widget _toastWidget() {
    return Card(
      //shadowColor: Styles.grey1,
      shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(Radius.circular(30.0))),
      child: Container(
        // duration: const Duration(milliseconds: 400),
        width: 250,
        //margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        //padding: const EdgeInsets.only(left: 20.0),
        height: _animationController.value * 50,
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius: BorderRadius.circular(20),
        ),

        child: Align(
          alignment: Alignment.center,
          child: Text(
            "${widget.message}",
            style: widget.messageStyle,
          ),
        ),
      ),
    );
  }
}
