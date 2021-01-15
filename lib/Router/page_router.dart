import 'package:Todo_App/AccountPage/Widgets/main_page.dart';
import 'package:Todo_App/HomePage/Widgets/mainPage.dart';
import 'package:Todo_App/TodoAddPage/Widgets/mainPage.dart';
import 'package:Todo_App/WelcomeScreen/Widgets/mainPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:sailor/sailor.dart';

class PageRouter {
  static final String welcomePage = "/welcomePage";
  static final String homePage = "/homePage";
  static final String accountPage = "/accountPage";
  static final String favorites = "/favorites";
  static final String todoAddPage = "/todoAddPage";
  static final List<Widget> stackedWidgets = [];
  static final sailor = Sailor();
  static final observer = sailor.navigationStackObserver;

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
        name: homePage,
        builder: (context, args, params) {
          debugPrint("HomePage  is stacked or removed");
          return HomePage();
        },
      ),
      SailorRoute(
        name: accountPage,
        builder: (context, args, params) {
          debugPrint("account  is stacked or removed");
          return AccountPage();
        },
      ),
      SailorRoute(
        name: favorites,
        defaultTransitions: [SailorTransition.fade_in],
        defaultTransitionDuration: const Duration(milliseconds: 300),
        builder: (context, args, params) {
          return HomePage();
        },
      ),
      SailorRoute(
        name: todoAddPage,
        // params: [SailorParam(name: "id", isRequired: true)],
        builder: (context, args, params) {
          debugPrint("addpage  is stacked or removed");
          return TodoAddPage();
        },
      ),
    ]);
  }
}
