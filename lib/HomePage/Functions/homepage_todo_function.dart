import 'package:Todo_App/Database/todo.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:moor/moor.dart';

class HomePageTodoFunction {
  static String searchTodos;
  static String formatDueTime(DateTime date) {
    return DateFormat("EEE,kk:mm").format(date);
  }

  static String getWeekDay(DateTime dateTocheck) {
    final today = DateTime.now();

    if (today.day == dateTocheck.day)
      return "today";
    else if (dateTocheck.day == today.day + 1)
      return "Tommarrow";
    else {
      final format = DateFormat("d-M-y").format(dateTocheck);
      return "on " + format;
    }
  }
}

final homePageChangeModeProvider =
    StateNotifierProvider<HomePageChangeModeNotifier>(
        (ref) => HomePageChangeModeNotifier());

enum HomePageChangeMode { normal, search, favorites }

class HomePageChangeModeNotifier extends StateNotifier<HomePageChangeMode> {
  HomePageChangeModeNotifier() : super(HomePageChangeMode.normal);
  void changeMode(HomePageChangeMode mode) {
    state = mode;
  }
}
