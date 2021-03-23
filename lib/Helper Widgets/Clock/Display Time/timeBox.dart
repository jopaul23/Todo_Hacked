import 'package:flutter/material.dart';
import 'package:Todo_App/styles/styles.dart';
import 'package:google_fonts/google_fonts.dart';

class TimeBox extends StatelessWidget {
  final String timeType;
  final String time;
  final Function onPressed;
  final backGroundColor;
  const TimeBox(
      {Key key,
      @required this.timeType,
      this.onPressed,
      this.time,
      this.backGroundColor})
      : super(key: key);

  String timeToString(int timeInInt) {
    String converedString;
    timeInInt < 10
        ? converedString = "0" + timeInInt.toString()
        : converedString = timeInInt.toString();
    return converedString;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: backGroundColor,
          // color: Styles.t1Orange.withOpacity(0.9),
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Styles.grey4.withOpacity(0.02),
              spreadRadius: 7,
              blurRadius: 7,
              offset: Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        height: 80,
        width: 70,
        child: Column(
          children: [
            Spacer(),
            Align(
                alignment: Alignment.center,
                child: Text(
                  "$time",
                  style: TextStyle(
                    fontSize: 40,
                    fontFamily: GoogleFonts.rubik().fontFamily,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none,
                    color: Styles.white1,
                  ),
                )),
            SizedBox(
              height: 5,
            ),
            Text(
              timeType,
              style: TextStyle(
                  fontSize: 12,
                  decoration: TextDecoration.none,
                  color: Styles.white1.withOpacity(0.8)),
            ),
          ],
        ),
      ),
    );
  }
}
