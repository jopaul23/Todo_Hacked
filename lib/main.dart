import 'package:Todo_App/HomePage/Widgets/mainPage.dart';
import 'package:Todo_App/styles/styles.dart';
import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'AccountPage/Functions/user_details.dart';
import 'Router/page_router.dart';
import 'package:hive/hive.dart';
import 'WelcomeScreen/Widgets/mainPage.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await pathProvider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(UserTodoDetailsAdapter());
  UserTodoDetails.hiveBox = await Hive.openBox('user_todo');

  await AndroidAlarmManager.initialize();

  PageRouter.createRoutes();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    debugPrint("App is Closeing");
    closeHiveBox();
    super.dispose();
  }

  closeHiveBox() async => await Hive.close();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      onGenerateRoute: PageRouter.sailor.generator(),
      navigatorKey: PageRouter.sailor.navigatorKey,
      theme: Styles.themeData(),
      home: UserTodoDetails.hiveBox.isEmpty ? WelcomeScreen() : HomePage(),
    );
  }
}
