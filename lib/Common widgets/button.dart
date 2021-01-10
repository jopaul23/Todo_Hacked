import 'package:Todo_App/styles/styles.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final Color textcolor;
  final Color buttoncolor;
  final String text;
  final Function() onPressed;
  const Button(
      {@required this.text, this.onPressed, this.textcolor, this.buttoncolor});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        padding: EdgeInsets.symmetric(vertical: 2, horizontal: 15),
        decoration: BoxDecoration(
          color: buttoncolor,
          borderRadius: BorderRadius.circular(24),
        ),
        child: FlatButton(
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(
              color: textcolor,
              fontSize: 25,
            ),
          ),
        ),
      ),
    );
  }
}
