import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:segments/apicontroller.dart';
import 'package:segments/constant.dart';
import 'package:segments/models/notifikasis.dart';

class Notifikasi extends StatefulWidget {
  const Notifikasi({super.key});

  @override
  NotifikasiState createState() => NotifikasiState();
}

class NotifikasiState extends State<Notifikasi> {
  Map<String, dynamic> data = {};
  @override
  void initState() {
    getDataNotifikasi();
    super.initState();
  }

  final List<Map> notifikasi = List.generate(
      10,
      (index) => {
            "id": index,
            "notif": "Notifikasi Laporan Approv $index",
            "gambar": "assets/absen.png"
          });
  List<Notifikasis> listNotifikasis = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Notifikasi"),
      ),
      body: SizedBox(
        height: tinggilayar / 1.25,
        child: (listNotifikasis.isNotEmpty)
            ? ListView.builder(
                itemCount: listNotifikasis.length,
                itemBuilder: (context, index) {
                  var a =
                      Jiffy.parse(listNotifikasis[index].created_at.toString())
                          .fromNow();
                  return ListTile(
                    contentPadding: EdgeInsets.symmetric(
                        vertical: lebarlayar / 40,
                        horizontal: marginhorizontal),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          listNotifikasis[index].judul_notifikasi,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(
                              fontSize: tinggilayar / lebarlayar * 6,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          a,
                          overflow: TextOverflow.ellipsis,
                          style:
                              TextStyle(fontSize: tinggilayar / lebarlayar * 6),
                        ),
                      ],
                    ),
                    leading: Image.asset(notifikasi[index]["gambar"]),
                  );
                })
            : const Center(
                child: Text(
                  "Tidak ada Notifikasi",
                  textAlign: TextAlign.center,
                  style: TextStyle(),
                ),
              ),
      ),
    );
  }

  Future getDataNotifikasi() async {
    var response1 = await ApiController().getUser();

    Map<String, String> body = {
      'nik': response1.data['karyawan']['nik'].toString()
    };
    var response = await ApiController().getDataNotifikasi(body);
    List<Notifikasis> notifikasiList = List.empty(growable: true);
    var jsonlist = response.data['notifikasi'] as List;
    for (var element in jsonlist) {
      notifikasiList.add(Notifikasis.fromJson(element));
    }
    setState(() {
      listNotifikasis = notifikasiList;
    });
    // return notifikasiList;
  }
}
