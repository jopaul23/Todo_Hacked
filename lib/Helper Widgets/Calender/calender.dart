import 'package:Todo_App/styles/styles.dart';
import 'package:flutter/material.dart';

class Calender extends StatefulWidget {
  @override
  _CalenderState createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 100,
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          height: 300,
          width: 300,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            color: Styles.white2,
            boxShadow: [
              BoxShadow(
                color: Styles.grey4.withOpacity(0.02),
                spreadRadius: 7,
                blurRadius: 7,
                offset: Offset(0, 2), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            children: [Row()],
          ),
        ),
      ],
    );
  }
}
