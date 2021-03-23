import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'clock_functions.dart';

final timeChangeModeProvider =
    StateNotifierProvider<TimeModeNotifier>((_) => TimeModeNotifier());

class TimeModeNotifier extends StateNotifier<TimeChangeMode> {
  TimeModeNotifier() : super(TimeChangeMode.hour);
  void changeMode(TimeChangeMode mode) => state = mode;
}
