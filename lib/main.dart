import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'Router/page_router.dart';
import 'WelcomeScreen/Widgets/mainPage.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await AndroidAlarmManager.initialize();
  PageRouter.createRoutes();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      onGenerateRoute: PageRouter.sailor.generator(),
      navigatorKey: PageRouter.sailor.navigatorKey,
      theme: ThemeData(
        fontFamily: GoogleFonts.rubik().fontFamily,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: WelcomeScreen(),
    );
  }
}
