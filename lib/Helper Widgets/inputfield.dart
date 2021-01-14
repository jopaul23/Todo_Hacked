import 'dart:ffi';

import 'package:Todo_App/styles/styles.dart';
import 'package:flutter/material.dart';

class InputButton extends StatefulWidget {
  final Color textcolor;
  final Color buttoncolor;
  final String text;
  final double width;
  final IconData icon;
  final Function() onPressed;
  const InputButton(
      {@required this.text,
      this.onPressed,
      this.textcolor,
      this.buttoncolor,
      this.icon,
      this.width});
  _InputButtonState createState() => _InputButtonState();
}

@override
class _InputButtonState extends State<InputButton> {
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: widget.width,
        height: 50,
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        padding: EdgeInsets.symmetric(vertical: 2, horizontal: 15),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Styles.grey4.withOpacity(0.03),
              spreadRadius: 10,
              blurRadius: 7,
              offset: Offset(0, 2), // changes position of shadow
            ),
          ],
          color: widget.buttoncolor,
          borderRadius: BorderRadius.circular(24),
        ),
        child: FlatButton(
            onPressed: widget.onPressed,
            child: Row(
              children: [
                if (widget.icon != null)
                  Icon(
                    widget.icon,
                    color: Styles.t1Orange,
                  ),
                Text(
                  "    " + widget.text,
                  style: TextStyle(
                    color: widget.textcolor,
                    fontSize: 18,
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
