import 'package:Todo_App/styles/styles.dart';
import 'package:flutter/material.dart';

class TodoCards extends StatelessWidget {
  final String tagName, title, dateTime;
  final Color tagColor;
  const TodoCards(
      {Key key, this.tagName, this.title, this.dateTime, this.tagColor})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 30.0),
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: Styles.white2,
        borderRadius: const BorderRadius.all(Radius.circular(30.0)),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            children: [
              tags(),
              const SizedBox(width: 10.0),
              Icon(Icons.edit_outlined),
              Spacer(),
              Icon(Icons.favorite_border_rounded),
              const SizedBox(width: 5.0),
              Icon(Icons.notifications_none_rounded),
              const SizedBox(width: 5.0),
              Icon(Icons.check_box_outline_blank_rounded)
            ],
          ),
          const SizedBox(height: 10.0),
          Text("$title",
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Styles.grey4.withOpacity(0.9))),
          const SizedBox(height: 30.0),
          Row(
            children: [
              Icon(
                Icons.calendar_today_outlined,
                size: 30,
                color: Styles.t1Orange,
              ),
              const SizedBox(width: 5.0),
              Text(
                "$dateTime",
                style: TextStyle(fontSize: 15, color: Styles.grey2),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget tags() {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 2.0),
      decoration: BoxDecoration(
          color: tagColor,
          borderRadius: const BorderRadius.all(Radius.circular(30.0))),
      child: Text(
        "$tagName",
        style: TextStyle(color: Styles.white3),
      ),
    );
  }
}
