import 'package:Todo_App/Database/todo.dart';
import 'package:Todo_App/HomePage/Widgets/mainPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'AccountPage/Functions/user_details.dart';

import 'Router/page_router.dart';
import 'package:hive/hive.dart';
import 'Themes/bloc/themebloc_bloc.dart';
import 'Themes/themes/light.dart';
import 'WelcomeScreen/Widgets/mainPage.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await pathProvider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(UserTodoDetailsAdapter());
  UserTodoDetails.hiveBox = await Hive.openBox('user_todo');
  // ProviderContainer db = ProviderContainer();
  // UserTodoDetails.database = db.read(databaseProvider);
  UserTodoDetails.database = TodoDao(TodoListDataBase());
  // await AndroidAlarmManager.initialize();

  PageRouter.createRoutes();

  PageRouter.createRoutes();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
// ignore: close_sinks
  ThemeblocBloc blocTheme;
  @override
  void initState() {
    super.initState();
    blocTheme = ThemeblocBloc();
  }

  @override
  void dispose() {
    debugPrint("App is Closeing");
    closeHiveBox();
    super.dispose();
  }

  closeHiveBox() async => await Hive.close();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => blocTheme,
        child: BlocBuilder(
          cubit: blocTheme,
          builder: (context, state) {
            return MaterialApp(
              title: 'Todo App',
              debugShowCheckedModeBanner: false,
              onGenerateRoute: PageRouter.sailor.generator(),
              navigatorKey: PageRouter.sailor.navigatorKey,
              theme: appThemeMap[state.theme],
              home: UserTodoDetails.hiveBox.isEmpty
                  ? WelcomeScreen()
                  : HomePage(),
            );
          },
        ));
  }
}
