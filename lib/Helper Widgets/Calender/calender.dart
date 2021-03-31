import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../Themes/colors.dart' as appColors;

class HomeCalendarPage extends StatefulWidget {
  final Function(DateTime) onSelected;
  final DateTime initalDate;
  const HomeCalendarPage({Key key, this.onSelected, this.initalDate})
      : super(key: key);
  @override
  _HomeCalendarPageState createState() => _HomeCalendarPageState();
}

class _HomeCalendarPageState extends State<HomeCalendarPage> {
  CalendarController _controller;
  DateTime selectedDate = DateTime.now();
  @override
  void initState() {
    super.initState();
    _controller = CalendarController();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 350,
          decoration: BoxDecoration(
            boxShadow: [appColors.shadow],
            // color: Styles.white1,
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          child: Column(
            children: [
              Material(
                child: TableCalendar(
                  initialCalendarFormat: CalendarFormat.month,
                  weekendDays: const [DateTime.sunday],
                  startingDayOfWeek: StartingDayOfWeek.sunday,
                  availableCalendarFormats: const {
                    CalendarFormat.month: "month"
                  },
                  calendarStyle: CalendarStyle(
                      todayColor: Colors.white.withOpacity(0.3),
                      selectedColor: theme.primaryColorLight,
                      todayStyle: theme.textTheme.headline3),
                  headerStyle: HeaderStyle(
                    centerHeaderTitle: true,
                  ),
                  onDaySelected: (date, events, _) {
                    selectedDate = date;
                  },
                  builders: CalendarBuilders(
                    selectedDayBuilder: (context, date, events) {
                      return Container(
                          margin: const EdgeInsets.all(5.0),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: theme.primaryColor,
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
                            //  color: Styles.grey1.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(20)),
                        child: Text(
                          date.day.toString(),
                          style: TextStyle(color: Colors.white),
                        )),
                  ),
                  calendarController: _controller,
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: TextButton(
                  onPressed: () {
                    widget.onSelected(selectedDate);
                  },
                  child: Text("OK",
                      style: theme.textTheme.bodyText2.copyWith(fontSize: 30)),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
