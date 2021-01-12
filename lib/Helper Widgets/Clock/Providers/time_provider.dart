import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final timeHourProvider =
    StateNotifierProvider<TimeHourNotifier>((_) => TimeHourNotifier());

final timeMinuteProvider =
    StateNotifierProvider<TimeMinuteNotifier>((_) => TimeMinuteNotifier());

class TimeHourNotifier extends StateNotifier<String> {
  TimeHourNotifier() : super("12");
  void updateTime(String hour) => state = hour;
}

class TimeMinuteNotifier extends StateNotifier<String> {
  TimeMinuteNotifier() : super("00");
  void updateTime(String min) => state = min;
}

enum TimeChangeMode { minute, hour }

final timeChangeModeProvider =
    StateNotifierProvider<TimeModeNotifier>((_) => TimeModeNotifier());

class TimeModeNotifier extends StateNotifier<TimeChangeMode> {
  TimeModeNotifier() : super(TimeChangeMode.hour);
  void changeMode(TimeChangeMode mode) => state = mode;
}
