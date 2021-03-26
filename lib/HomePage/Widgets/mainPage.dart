import 'package:Todo_App/Helper%20Widgets/basic_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'calender.dart';
import 'todo_lisitng.dart';

class HomePage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: BasicWidget(
        child: Container(
          height: size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [theme.colorScheme.primary, theme.colorScheme.secondary],
          )),
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
                      color: theme.accentColor,
                      borderRadius: const BorderRadius.only(
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
