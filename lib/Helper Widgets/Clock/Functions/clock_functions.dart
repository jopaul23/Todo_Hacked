import 'dart:math';
import 'dart:ui';

enum TimeChangeMode { minute, hour }

class ClockController {
  String minuteInString = "00";
  String hourInString = "12";
  int hour = 12;
  int minute = 0;
  bool isBeforeNoon = false;
  Function(int, int) onChanged;

  double getAngle(Offset offset) =>
      atan2(-(175 - offset.dx), (175 - offset.dy)) * 180 / pi;

  void updateHour(int newhour) {
    String temphour = newhour.toString();
    hour = newhour;

    if (isBeforeNoon) {
      if (temphour.length ==
          1) // if the hour is a single digit then add 0 to the left
        hourInString = "0" + temphour;
      else if (temphour == "12")
        hourInString = "00";
      else if (hour > 12) {
        // if the hour is greater than 12 .ie in 24 hours format then change to 12 hours format
        newhour = hour - 12;
        updateHour(
            newhour); //calling the function again for formatting the hour
      } else
        hourInString = temphour;
    } else {
      //change to 24 hour format
      hourInString = (hour + 12).toString();
      hour = int.parse(hourInString);
    }
  }

  void updateMinute(int newMin) {
    minute = newMin;
    String min = newMin.toString();
    if (min.length ==
        1) // if the minute is a single digit then add 0 to the left
      minuteInString = "0" + min;
    else
      minuteInString = min;
  }

  int calculateHour(Offset offset) {
    final angle = getAngle(offset) + 180;
    //hour calculating formula
    int hrs = (((angle + 15) ~/ 30 + 6) % 12);

    updateHour(hrs);
    if (onChanged != null) onChanged(hour, minute); //callback function

    return hrs;
  }

  int calculateMinute(Offset offset) {
    final angle = getAngle(offset) + 180;
    //min calculating formula
    int min = (((angle + 3) ~/ 6 + 30) % 60);
    updateMinute(min);
    if (onChanged != null) onChanged(hour, minute); //callback function
    return min;
  }
}
