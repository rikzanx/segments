// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

import 'dart:collection';

// ignore: unused_import
import 'package:segments/apiresponse.dart';
import 'package:segments/models/berita.dart';
import 'package:segments/models/jadwal.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../apicontroller.dart';

/// Example event class.
class Event {
  final String title;

  const Event(this.title);

  @override
  String toString() => title;
}

/// Example events.
///
/// Using a [LinkedHashMap] is highly recommended if you decide to use a map.
// var kEvents = LinkedHashMap<DateTime, List<Event>>(
//   equals: isSameDay,
//   hashCode: getHashCode,
// )..addAll(_kEventSource);
Map<String, dynamic> data = {};
var kEvents = <DateTime, List<Event>>{};

setkEvents() async {
  var events = await getListJadwal();
  if (events != null) {
    kEvents = events;
  }
}

// Map<DateTime,List<Event>> _kEventSource = {};

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

Future<LinkedHashMap<DateTime, List<Event>>?> getListJadwal() async {
  await ApiController().getUser().then((value) {
    if (value.status) {
      data = value.data;
    }
  });
  Map<String, String> body = {
    'bulan': kToday.month.toString(),
    'tahun': kToday.year.toString(),
    'id_regu': data['karyawan']['id_regu'].toString(),
    'nik': data['karyawan']['nik']
  };
  LinkedHashMap<DateTime, List<Event>>? kEvents;
  await ApiController().getJadwal(body).then((value) {
    if (value.status) {
      List<Jadwal> listJadwal = List.empty(growable: true);
      var jsonlist = value.data as List;
      for (var element in jsonlist) {
        listJadwal.add(Jadwal.fromJson(element));
      }

      final source = {
        for (var item in listJadwal)
          DateTime.utc(int.parse(item.tahun), int.parse(item.bulan),
                  int.parse(item.tanggal)):
              List.generate(
                  1,
                  (index) => Event(
                      "|${item.action}| ${item.jam_masuk}-${item.jam_keluar}"))
      };
      // print(source);
      kEvents = LinkedHashMap<DateTime, List<Event>>(
        equals: isSameDay,
        hashCode: getHashCode,
      )..addAll(source);
      // print(listJadwal[0]);
    }
  });
  return kEvents;
}

/// Returns a list of [DateTime] objects from [first] to [last], inclusive.
List<DateTime> daysInRange(DateTime first, DateTime last) {
  final dayCount = last.difference(first).inDays + 1;
  return List.generate(
    dayCount,
    (index) => DateTime.utc(first.year, first.month, first.day + index),
  );
}

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);

List<Berita> listBerita = [];
Future getDataBerita() async {
  var response = await ApiController().getDataBerita();
  List<Berita> beritaList = List.empty(growable: true);
  var jsonlist = response.data as List;
  for (var element in jsonlist) {
    beritaList.add(Berita.fromJson(element));
  }
  listBerita = beritaList;
  // return notifikasiList;
}
