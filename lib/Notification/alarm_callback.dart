import 'package:Todo_App/Database/provider.dart';
import 'package:Todo_App/Database/todo.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'alarm_manager.dart';

class AlarmCallback {
  static alarmCallback(int id) async {
    print("[*] Called from AlarmManager");
    print(id);
    NotificationManager n = new NotificationManager();
    n.initNotificationManager();
    String message = "No get the title";
    try {
      final providerContainer = ProviderContainer();
      final todo =
          await providerContainer.read(databaseProvider).getTodosUsingId(id);
      message = todo[0].title;
      print(todo);
    } catch (e) {
      print("Error occures");
      print(e);
    }
    n.showNotificationWithDefaultSound("Remainder ", "$message");

    return;
  }
}
