import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:sailor/sailor.dart';
import 'package:todo_app/AccountPage/Widgets/main_page.dart';
import 'package:todo_app/HomePage/Widgets/mainPage.dart';
import 'package:todo_app/TodoAddPage/Widgets/mainPage.dart';
import 'package:todo_app/WelcomeScreen/Widgets/mainPage.dart';

class PageRouter {
  static final String welcomePage = "/welcomePage";
  static final String homePage = "/homePage";
  static final String accountPage = "/accountPage";
  static final String favorites = "/favorites";
  static final String todoAddPage = "/todoAddPage";

  static final sailor = Sailor();

  static void createRoutes() {
    sailor.addRoutes([
      SailorRoute(
        name: welcomePage,
        defaultTransitions: [SailorTransition.slide_from_bottom],
        defaultTransitionDuration: const Duration(milliseconds: 300),
        builder: (context, args, params) {
          return WelcomeScreen();
        },
      ),
      SailorRoute(
        name: accountPage,
        builder: (context, args, params) {
          return AccountPage();
        },
      ),
      SailorRoute(
        name: homePage,
        defaultTransitions: [SailorTransition.fade_in],
        defaultTransitionDuration: const Duration(milliseconds: 300),
        builder: (context, args, params) {
          return HomePage();
        },
      ),
      SailorRoute(
        name: todoAddPage,
        builder: (context, args, params) {
          debugPrint("addpage  is stacked or removed");

          return TodoAddPage();
        },
      ),
    ]);
  }
}
