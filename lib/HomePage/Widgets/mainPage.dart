import 'package:Todo_App/styles/styles.dart';
import 'package:flutter/material.dart';

import 'calender.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
        child: Container(
      height: size.height,
      decoration: BoxDecoration(
        gradient: Styles.t1Gradient,
      ),
      child: Column(
        children: <Widget>[Calender(DateTime.now())],
      ),
    ));
  }
}
