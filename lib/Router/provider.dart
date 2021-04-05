import 'package:flutter/material.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:todo_app/HomePage/Widgets/mainPage.dart';

final pageStackProvider =
    StateNotifierProvider<PageStack>((ref) => PageStack());

class PageStack extends StateNotifier<List<Widget>> {
  PageStack() : super([HomePage()]);
  addWidget(Widget wid) {
    state.add(wid);
  }

  popWid() {
    debugPrint("removing");
    state.removeLast();
    print(state);
  }
}
