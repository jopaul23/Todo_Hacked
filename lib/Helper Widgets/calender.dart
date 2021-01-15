import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:Todo_App/styles/styles.dart';

class HomeCalendarPage extends StatefulWidget {
  @override
  _HomeCalendarPageState createState() => _HomeCalendarPageState();
}

class _HomeCalendarPageState extends State<HomeCalendarPage> {
  CalendarController _controller;

  @override
  void initState() {
    super.initState();
    _controller = CalendarController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 350,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Styles.grey4.withOpacity(0.02),
                    spreadRadius: 7,
                    blurRadius: 7,
                    offset: Offset(0, 2), // changes position of shadow
                  ),
                ],
                color: Styles.white1,
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              child: Column(
                children: [
                  TableCalendar(
                    initialCalendarFormat: CalendarFormat.month,
                    weekendDays: const [DateTime.sunday],
                    startingDayOfWeek: StartingDayOfWeek.sunday,
                    availableCalendarFormats: const {
                      CalendarFormat.month: "month"
                    },
                    calendarStyle: CalendarStyle(
                        todayColor: Colors.white.withOpacity(0.3),
                        selectedColor: Styles.white1,
                        todayStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22.0,
                            color: Styles.grey4)),
                    headerStyle: HeaderStyle(
                      centerHeaderTitle: true,
                      // formatButtonDecoration: BoxDecoration(
                      //   color: Colors.brown,
                      //   borderRadius: BorderRadius.circular(22.0),
                      // ),
                      // formatButtonTextStyle: TextStyle(color: Colors.white),
                      // formatButtonShowsNext: false,
                    ),
                    // onDaySelected: (date, events) {
                    //   print(date.toUtc());
                    // },
                    builders: CalendarBuilders(
                      selectedDayBuilder: (context, date, events) {
                        print(date); //print the selected date
                        // if (date < DateTime.now()) {
                        return Container(
                            margin: const EdgeInsets.all(5.0),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Styles.t1Orange,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              date.day.toString(),
                              style: TextStyle(color: Colors.white),
                            ));
                        //}
                      },
                      todayDayBuilder: (context, date, events) => Container(
                          margin: const EdgeInsets.all(5.0),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Styles.grey1.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(20)),
                          child: Text(
                            date.day.toString(),
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                    calendarController: _controller,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: FlatButton(
                      onPressed: () {
                        print("OK");
                      },
                      child: Text("OK",
                          style: TextStyle(
                              fontSize: 30,
                              color: Styles.red,
                              fontWeight: FontWeight.bold)),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
