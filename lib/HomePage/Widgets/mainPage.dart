import 'package:Todo_App/Helper%20Widgets/basic_widget.dart';
import 'package:Todo_App/Router/page_router.dart';
import 'package:Todo_App/Themes/bloc/themebloc_bloc.dart';
import 'package:Todo_App/Themes/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'calender.dart';
import 'todo_lisitng.dart';

class HomePage extends StatelessWidget {
  // ignore: close_sinks

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
              gradient: gradientMap[
                  BlocProvider.of<ThemeblocBloc>(context).state.theme]),
          child: Stack(
            children: <Widget>[
              //top calender
              Calender(DateTime.now()),
              Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: CircleAvatar(
                      backgroundColor: black,
                      radius: 24,
                      child: TextButton(
                          onPressed: () {
                            PageRouter.sailor.navigate(PageRouter.accountPage);
                          },
                          child:
                              Icon(FontAwesomeIcons.user, color: Colors.white)),
                    ),
                  )),
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
        )));
  }
}
