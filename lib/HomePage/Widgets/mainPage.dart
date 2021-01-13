import 'package:Todo_App/Helper%20Widgets/basic_widget.dart';
import 'package:Todo_App/styles/styles.dart';
import 'package:flutter/material.dart';

import 'calender.dart';
import 'search.dart';
import 'todo_card.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return BasicWidget(
      pageNo: 1,
      child: Container(
        height: size.height,
        decoration: BoxDecoration(
          gradient: Styles.t1Gradient,
        ),
        child: Stack(
          children: <Widget>[
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
                  child: Column(
                    children: [
                      TodoListSearch(),
                      const SizedBox(height: 10.0),
                      Text(
                        "Today",
                        style: TextStyle(
                            color: Styles.grey1, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10.0),
                      TodoCards(
                        dateTime: "Tue 12:00 pm",
                        title: "Todo app to be completed",
                        tagName: "Work",
                        tagColor: Colors.amber,
                      ),
                      TodoCards(
                        dateTime: "Wed 15:00 pm",
                        title: "Garden Works",
                        tagName: "Home",
                        tagColor: Colors.teal,
                      ),
                      TodoCards(
                          dateTime: "fri 06:30 am",
                          title: "Walk in mrng",
                          tagName: "walk",
                          tagColor: Colors.blueGrey),
                      TodoCards(
                        dateTime: "Tue 12:00 pm",
                        title: "Make cake",
                        tagName: "cook",
                        tagColor: Colors.orange,
                      ),
                      TodoCards(
                        dateTime: "Tue 12:00 pm",
                        title: "Make cake",
                        tagName: "cook",
                        tagColor: Colors.orange,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
