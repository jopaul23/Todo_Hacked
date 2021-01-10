import 'package:Todo_App/styles/styles.dart';
import 'package:flutter/material.dart';

class InputTextField extends StatefulWidget {
  final String labelText;
  final Function(String) onChanged;
  const InputTextField({this.onChanged, this.labelText = ""});
  _InputTextField createState() => _InputTextField();
}

class _InputTextField extends State<InputTextField> {
  bool isTaped = false;
  Widget build(BuildContext context) {
    return Container(
      //padding: const EdgeInsets.symmetric(horizontal: 40),
      decoration: BoxDecoration(
        color: Styles.white1.withOpacity(.23),
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: Styles.grey4.withOpacity(0.01),
            spreadRadius: 10,
            blurRadius: 7,
            offset: Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      height: 55,
      width: 300,
      alignment: Alignment.center,
      child: Container(
        width: 120,
        child: TextField(
          decoration: InputDecoration(
            hintText: widget.labelText,
            hintStyle: TextStyle(
              color: Styles.white1.withOpacity(.59),
              fontSize: 25,
            ),
            suffixStyle: TextStyle(color: Styles.white1, fontSize: 25),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
