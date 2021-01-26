import 'package:flutter/material.dart';

import '../../styles/styles.dart';

class InputButton extends StatelessWidget {
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

  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: width,
        height: 50,
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        padding: EdgeInsets.symmetric(vertical: 2, horizontal: 15),
        decoration: BoxDecoration(
          boxShadow: [Styles.shadow()],
          color: buttoncolor,
          borderRadius: BorderRadius.circular(24),
        ),
        child: FlatButton(
            onPressed: onPressed,
            child: Row(
              children: [
                Icon(
                  icon,
                  color: Styles.t1Orange,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      text,
                      style: TextStyle(
                        color: textcolor ?? Styles.grey2,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
