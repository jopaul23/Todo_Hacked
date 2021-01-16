import 'package:Todo_App/AccountPage/Widgets/main_page.dart';
import 'package:Todo_App/HomePage/Widgets/mainPage.dart';
import 'package:Todo_App/Router/provider.dart';
import 'package:Todo_App/TodoAddPage/Widgets/mainPage.dart';
import 'package:Todo_App/WelcomeScreen/Widgets/mainPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:sailor/sailor.dart';

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
          debugPrint("account  is stacked or removed");
          return Consumer(builder: (context, watch, _) {
            final page = watch(pageStackProvider);
            page.addWidget(AccountPage());
            return AccountPage();
          });
        },
      ),
      SailorRoute(
        name: homePage,
        defaultTransitions: [SailorTransition.fade_in],
        defaultTransitionDuration: const Duration(milliseconds: 300),
        builder: (context, args, params) {
          return Consumer(builder: (context, watch, _) {
            final page = watch(pageStackProvider);
            page.addWidget(HomePage());
            return HomePage();
          });
        },
      ),
      SailorRoute(
        name: todoAddPage,
        // params: [SailorParam(name: "id", isRequired: true)],
        builder: (context, args, params) {
          debugPrint("addpage  is stacked or removed");
          return Consumer(builder: (context, watch, _) {
            final page = watch(pageStackProvider);
            page.addWidget(TodoAddPage());
            return TodoAddPage();
          });
        },
      ),
    ]);
  }
}
