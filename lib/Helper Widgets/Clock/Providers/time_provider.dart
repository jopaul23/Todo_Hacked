import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TimeProvider {
  String time = "12:00";
  void updateHour(String hour, bool isBeforeNoon) {
    final List split = time.split(":");
    print(hour);
    if (isBeforeNoon) {
      if (hour.length == 1)
        hour = "0" + hour;
      else if (hour == "12") hour = "00";
    } else {
      hour = (int.parse(hour) + 12).toString();
    }
    split[0] = hour;
    time = split[0] + ":" + split[1];
  }

  void updateHourIgnoringAmPm(String hour) {
    final List split = time.split(":");

    if (hour.length == 1)
      hour = "0" + hour;
    else if (hour == "12") hour = "00";

    split[0] = hour;
    time = split[0] + ":" + split[1];
  }

  void changeTo24(String hour) {
    print(hour);
    final List split = time.split(":");

    split[0] = (int.parse(hour) + 12).toString();
    time = split[0] + ":" + split[1];
  }

  void changeTo12(String hour) {
    final List split = time.split(":");
    hour = (int.parse(hour) - 12).toString();
    if (hour.length == 1)
      hour = "0" + hour;
    else if (hour == "12") hour = "00";

    split[0] = hour;
    time = split[0] + ":" + split[1];
  }

  void updateMinute(String min) {
    final List split = time.split(":");
    if (min.length == 1) min = "0" + min;
    split[1] = min;
    time = split[0] + ":" + split[1];
  }
}

// class TimeMinuteNotifier extends StateNotifier<String> {
//   static String initialminute;

//   TimeMinuteNotifier() : super(initialminute) {
//     print(initialminute);
//   }
//   void updateTime(String min) => state = min;
// }

enum TimeChangeMode { minute, hour }

final timeChangeModeProvider =
    StateNotifierProvider<TimeModeNotifier>((_) => TimeModeNotifier());

class TimeModeNotifier extends StateNotifier<TimeChangeMode> {
  TimeModeNotifier() : super(TimeChangeMode.hour);
  void changeMode(TimeChangeMode mode) => state = mode;
}
