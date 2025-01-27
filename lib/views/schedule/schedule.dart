import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'utils.dart';
import 'package:intl/intl.dart';
import 'package:segments/constant.dart';

class Schedule extends StatefulWidget {
  final String title;
  const Schedule({super.key, required this.title});

  @override
  ScheduleState createState() => ScheduleState();
}

class ScheduleState extends State<Schedule> {
  late final ValueNotifier<List<Event>> _selectedEvents;
  // CalendarFormat _calendarFormat = CalendarFormat.month;
  // RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOff; 
  // Can be toggled on/off by longpressing a date
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  // DateTime? _rangeStart;
  // DateTime? _rangeEnd;

  @override
  void initState() {
    super.initState();
    // setkEvents();
    _selectedEvents = ValueNotifier([]);
    _selectedDay = _focusedDay;

    
    setkEvents().then((e){
      fetchEvents().then((events) {
        setState(() {
          _selectedEvents.value = _getEventsForDay(_selectedDay!);
        });
        // print("ini ------------------");
        // print(events);
        _selectedEvents.value = events;
      });
    });
    init();
    _getEventsForDay(DateTime.now());
    _selectedDay = _focusedDay;
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<Event> _getEventsForDay(DateTime day) {
    return kEvents[day] ?? [];
  }

  // List<Event> _getEventsForRange(DateTime start, DateTime end) {
  //   final days = daysInRange(start, end);

  //   return [
  //     for (final d in days) ..._getEventsForDay(d),
  //   ];
  // }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
    
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });
      _selectedEvents.value = _getEventsForDay(selectedDay);
      // print(_selectedEvents);
    }else{
      // print("selected day gak oke");
    }
  }

  // void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
  //   setState(() {
  //     _selectedDay = null;
  //     _focusedDay = focusedDay;
  //     // _rangeStart = start;
  //     // _rangeEnd = end;
  //     // _rangeSelectionMode = RangeSelectionMode.toggledOn;
  //   });
  //   if (start != null && end != null) {
  //     _selectedEvents.value = _getEventsForRange(start, end);
  //   } else if (start != null) {
  //     _selectedEvents.value = _getEventsForDay(start);
  //   } else if (end != null) {
  //     _selectedEvents.value = _getEventsForDay(end);
  //   }
  // }
  Future<List<Event>> fetchEvents() async {
    // print("loading fetchEvents");
    // Tunggu hingga kEvents selesai diinisialisasi (misalnya dari API atau database)
    // await setkEvents();  // Misalnya, panggil fungsi asinkron untuk inisialisasi data
    return kEvents[DateTime.now()] ?? []; // Mengambil data event untuk hari ini
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      backgroundColor: primarycolor,
      title: const Text(
        'Jadwal Kerja - Karyawan',
        style: TextStyle(
          color: Colors.white,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    body: FutureBuilder<List<Event>>(
      future: fetchEvents(),  // Ambil data event
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(primarycolor),
          ));
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          // ignore: prefer_const_constructors
          return Center(child: Text('Tidak ada jadwal.'));
        }

        // Setelah data siap, tampilkan kalender dan daftar event
        // _selectedEvents.value = snapshot.data!;

        return Column(
          children: [
            TableCalendar<Event>(
              firstDay: kFirstDay,
              lastDay: kLastDay,
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              eventLoader: _getEventsForDay,
              onDaySelected: _onDaySelected,
              calendarStyle: CalendarStyle(
                // Use `CalendarStyle` to customize the UI
                todayTextStyle : TextStyle(color: primarycolor, fontSize: 16.0),
                selectedTextStyle : TextStyle(color: primarycolor, fontSize: 16.0),
                markerDecoration : BoxDecoration(color: primarycolor, shape: BoxShape.circle),
                todayDecoration : BoxDecoration(color: Colors.yellow.shade100, shape: BoxShape.circle),
                selectedDecoration : BoxDecoration(color: Colors.yellow, shape: BoxShape.circle),
              ),
            ),
            const SizedBox(height: 8.0),
            Expanded(
              child: ValueListenableBuilder<List<Event>>(
                valueListenable: _selectedEvents,
                builder: (context, value, _) {
                  if(value.length > 0){
                    return ListView.builder(
                      itemCount: value.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                          decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: ListTile(
                            title: Text('${value[index]}'),
                          ),
                        );
                      },
                    );
                  }else{
                    return ListView(
                      children :[
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                          decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: ListTile(
                            title: Text('|OFF| 00:00:00 - 00:00:00'),
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ),
          ],
        );
      },
    ),
  );
  }

  Future init() async {}
}
