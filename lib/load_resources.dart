import 'package:hive/hive.dart';
import 'package:hooks_riverpod/all.dart';

import 'AccountPage/Functions/user_details.dart';
import 'Database/provider.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:android_alarm_manager/android_alarm_manager.dart';

import 'Router/page_router.dart';

void load() async {
  final appDocumentDir = await pathProvider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(UserTodoDetailsAdapter());
  UserTodoDetails.hiveBox = await Hive.openBox('user_todo');
  ProviderContainer db = ProviderContainer()..read(databaseProvider);
  UserTodoDetails.database = db;
  // await AndroidAlarmManager.initialize();

  PageRouter.createRoutes();
}
