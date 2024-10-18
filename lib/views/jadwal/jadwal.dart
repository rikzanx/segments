import 'package:flutter/material.dart';
import 'package:segments/apicontroller.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:intl/intl.dart' show DateFormat;

class Jadwal extends StatefulWidget {
  const Jadwal({super.key, required this.title});

  final String title;

  @override
  JadwalState createState() => JadwalState();
}

class JadwalState extends State<Jadwal> {
  final DateTime _currentDate = DateTime(2021, 12, 3);
  DateTime _currentDate2 = DateTime(2021, 12, 3);
  String _currentMonth = DateFormat.yMMM().format(DateTime(2021, 12, 3));
  DateTime _targetDateTime = DateTime(2021, 12, 21);
//  List<DateTime> _markedDate = [DateTime(2018, 9, 20), DateTime(2018, 10, 11)];
  static final Widget _eventIcon = Container(
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(25)),
        border: Border.all(color: Colors.blue, width: 2.0)),
    child: const Icon(
      Icons.person,
      color: Colors.amber,
    ),
  );

  final EventList<Event> _markedDateMap = EventList<Event>(
    events: {
      DateTime(2021, 12, 10): [
        Event(
          date: DateTime(2021, 12, 10),
          title: 'Event 1',
          icon: _eventIcon,
          dot: Container(
            margin: const EdgeInsets.symmetric(horizontal: 1.0),
            color: Colors.red,
            height: 5.0,
            width: 5.0,
          ),
        ),
        // new Event(
        //   date: new DateTime(2021, 12, 10),
        //   title: 'Event 2',
        //   icon: _eventIcon,
        // ),
        // new Event(
        //   date: new DateTime(2021, 12, 10),
        //   title: 'Event 3',
        //   icon: _eventIcon,
        // ),
      ],
    },
  );

  Map<String, dynamic> data = {};

  @override
  void initState() {
    // print("oke tok");

    /// Add more events to _markedDateMap EventList
    _markedDateMap.add(
        DateTime(2021, 2, 25),
        Event(
          date: DateTime(2019, 2, 25),
          title: 'Event 5',
          icon: _eventIcon,
        ));

    _markedDateMap.add(
        DateTime(2021, 12, 10),
        Event(
          date: DateTime(2019, 12, 10),
          title: 'Event 4',
          icon: _eventIcon,
        ));

    _markedDateMap.addAll(DateTime(2021, 12, 11), [
      Event(
        date: DateTime(2021, 12, 11),
        title: 'Event 1',
        icon: _eventIcon,
      ),
      Event(
        date: DateTime(2021, 12, 11),
        title: 'Event 2',
        icon: _eventIcon,
      ),
      Event(
        date: DateTime(2021, 12, 11),
        title: 'Event 3',
        icon: _eventIcon,
      ),
    ]);
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /// Example Calendar Carousel without header and custom prev & next button
    final calendarCarouselNoHeader = CalendarCarousel<Event>(
      todayBorderColor: Colors.green,
      onDayPressed: (date, events) {
        setState(() => _currentDate2 = date);
      },
      daysHaveCircularBorder: false,
      showOnlyCurrentMonthDate: false,
      weekendTextStyle: const TextStyle(
        color: Colors.red,
      ),
      thisMonthDayBorderColor: Colors.grey,
      weekFormat: false,
//      firstDayOfWeek: 4,
      markedDatesMap: _markedDateMap,
      height: 420.0,
      selectedDateTime: _currentDate2,
      targetDateTime: _targetDateTime,
      customGridViewPhysics: const NeverScrollableScrollPhysics(),
      markedDateCustomShapeBorder:
          const CircleBorder(side: BorderSide(color: Colors.red)),
      markedDateCustomTextStyle: const TextStyle(
        fontSize: 18,
        color: Colors.red,
      ),
      showHeader: true,
      todayTextStyle: const TextStyle(
        color: Colors.white,
      ),
      // markedDateShowIcon: true,
      // markedDateIconMaxShown: 2,
      // markedDateIconBuilder: (event) {
      //   return event.icon;
      // },
      // markedDateMoreShowTotal:
      //     true,
      todayButtonColor: Colors.green,
      selectedDayTextStyle: const TextStyle(
        color: Colors.yellow,
      ),
      minSelectedDate: _currentDate.subtract(const Duration(days: 360)),
      maxSelectedDate: _currentDate.add(const Duration(days: 360)),
      prevDaysTextStyle: const TextStyle(
        fontSize: 16,
        color: Colors.pinkAccent,
      ),
      inactiveDaysTextStyle: const TextStyle(
        color: Colors.tealAccent,
        fontSize: 16,
      ),
      onCalendarChanged: (DateTime date) {
        setState(() {
          _targetDateTime = date;
          _currentMonth = DateFormat.yMMM().format(_targetDateTime);
        });
      },
      onDayLongPressed: (DateTime date) {
        // print('long pressed date $date');
      },
    );

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              //custom icon without header
              Container(
                margin: const EdgeInsets.only(
                  top: 30.0,
                  bottom: 16.0,
                  left: 16.0,
                  right: 16.0,
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: Text(
                      _currentMonth,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0,
                      ),
                    )),
                    // ignore: deprecated_member_use
                    TextButton(
                      child: const Text('Sebelum'),
                      onPressed: () {
                        setState(() {
                          _targetDateTime = DateTime(
                              _targetDateTime.year, _targetDateTime.month - 1);
                          _currentMonth =
                              DateFormat.yMMM().format(_targetDateTime);
                        });
                      },
                    ),
                    // ignore: deprecated_member_use
                    TextButton(
                      child: const Text('Sesudah'),
                      onPressed: () {
                        setState(() {
                          _targetDateTime = DateTime(
                              _targetDateTime.year, _targetDateTime.month + 1);
                          _currentMonth =
                              DateFormat.yMMM().format(_targetDateTime);
                        });
                      },
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                child: calendarCarouselNoHeader,
              ), //
            ],
          ),
        ));
  }

  Future init() async {
    await ApiController().getUser().then((value) {
      // print(value);
      if (mounted) {
        setState(() {
          data = value.data;
          // print(data);
        });
      }
    });
  }
}
