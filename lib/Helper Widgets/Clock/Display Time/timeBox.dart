import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../Themes/colors.dart' as appColors;

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
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: backGroundColor,
          borderRadius: const BorderRadius.all(Radius.circular(25)),
          boxShadow: [appColors.shadow],
        ),
        height: 80,
        width: 70,
        child: Column(
          children: [
            Spacer(),
            Align(
                alignment: Alignment.center,
                child: Text("$time",
                    style: theme.textTheme.headline2.copyWith(fontSize: 40))),
            SizedBox(
              height: 5,
            ),
            Text(
              timeType,
              style: TextStyle(
                  fontSize: 12,
                  decoration: TextDecoration.none,
                  color: theme.primaryColorLight),
            ),
          ],
        ),
      ),
    );
  }
}
