import 'package:Todo_App/Helper%20Widgets/basic_widget.dart';
import 'package:Todo_App/HomePage/Functions/homepage_todo_function.dart';
import 'package:Todo_App/styles/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'calender.dart';
import 'todo_lisitng.dart';

class HomePage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final mode = useProvider(homePageChangeModeProvider.state);
    final changeMode = useProvider(homePageChangeModeProvider);

    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: BasicWidget(
        pageNo: mode == HomePageChangeMode.favorites ? 2 : 1,
        onFavClicked: () {
          changeMode.changeMode(HomePageChangeMode.favorites);
        },
        onHomeClicked: () {
          changeMode.changeMode(HomePageChangeMode.normal);
        },
        child: Container(
          height: size.height,
          decoration: BoxDecoration(
            gradient: Styles.t1Gradient,
          ),
          child: Stack(
            children: <Widget>[
              //top calender
              Calender(DateTime.now()),

              Padding(
                padding: EdgeInsets.only(top: 160),
                child: Container(
                  height: size.height,
                  padding: const EdgeInsets.only(top: 5),
                  decoration: BoxDecoration(
                      color: Styles.white2.withOpacity(.96),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40.0),
                          topRight: Radius.circular(40.0))),
                  child: SingleChildScrollView(
                      padding: EdgeInsets.only(top: 5, bottom: 80),
                      child: TodoListing()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
