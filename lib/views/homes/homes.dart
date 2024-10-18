// ignore_for_file: non_constant_identifier_names

import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:segments/apicontroller.dart';
import 'package:segments/constant.dart';
import 'package:segments/function/route.dart';
import 'package:segments/models/berita.dart';
import 'package:segments/models/laporan.dart';
import 'package:segments/views/home/detail_laporan/detail_laporan.dart';
import 'package:segments/views/home/detail_pengumuman/detail_pengumuman.dart';
import 'package:segments/views/notifikasi/notifikasi.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:segments/views/schedule/utils.dart';

class Homes extends StatefulWidget {
  const Homes({super.key});

  @override
  HomesState createState() => HomesState();
}

class HomesState extends State<Homes> {
  @override
  void initState() {
    super.initState();
    // getDataBerita();
    setkEvents();
  }

  @override
  Widget build(BuildContext context) {
    late final WebViewController webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse('https://$baseUrl/maps/android/absen'));
    return Scaffold(
      appBar: AppBar(
          backgroundColor: secondarycolor,
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                textAlign: TextAlign.left,
                text: TextSpan(
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: tinggilayar / lebarlayar * 9),
                    children: [
                      const TextSpan(
                          text: 'Hi ', style: TextStyle(color: Colors.orange)),
                      TextSpan(
                          text: dataUser['karyawan']['nama_lengkap'],
                          style: TextStyle(
                              color: primarycolor, fontWeight: FontWeight.bold))
                    ]),
              ),
              IconButton(
                onPressed: () {
                  //action coe when button is pressed
                  pindahPageCupertino(context, const Notifikasi());
                },
                icon: Icon(
                  Icons.notifications,
                  color: primarycolor,
                ),
              )
            ],
          )),
      body: SingleChildScrollView(
        child: Flex(
          mainAxisAlignment: MainAxisAlignment.start,
          direction: Axis.vertical,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: lebarlayar / 20),
              width: lebarlayar,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Berita",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: tinggilayar / lebarlayar * 9),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: tinggilayar / 50,
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: tinggilayar / 50),
              height: tinggilayar / 3.8,
              width: lebarlayar,
              child: FutureBuilder<List<Berita>>(
                future: fetchDataBerita(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Berita>? data = snapshot.data;
                    return ListView.builder(
                      itemCount: data!.length,
                      itemBuilder: (context, i) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (BuildContext) => DetailPengumuman(
                                          index: i,
                                          berita: data[i],
                                        )));
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: lebarlayar / 20),
                            width: lebarlayar / 1.35,
                            height: tinggilayar / 4,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                    offset: const Offset(0, 1),
                                    blurRadius: 3,
                                    spreadRadius: 1,
                                    color: Colors.grey.shade300)
                              ],
                            ),
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15),
                                  ),
                                  child: SizedBox(
                                    width: double.infinity,
                                    height: tinggilayar / 6,
                                    child: Hero(
                                      tag: "gambar$i",
                                      child: Image.network(
                                        data[i].link_gambar,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.only(
                                      top: lebarlayar / 50,
                                      left: lebarlayar / 30,
                                      right: lebarlayar / 30),
                                  child: Text(
                                    listBerita[i].judul,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            tinggilayar / lebarlayar * 6.5),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                      left: lebarlayar / 30,
                                      top: lebarlayar / 50,
                                      right: lebarlayar / 30),
                                  child: Text(
                                    data[i].deskripsi,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize:
                                            tinggilayar / lebarlayar * 5.5),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.only(
                          left: lebarlayar / 20, bottom: tinggilayar / 50),
                    );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  return SizedBox(
                    height: tinggilayar / 10,
                    width: tinggilayar / 10,
                  );
                },
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: lebarlayar / 20),
              width: lebarlayar,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Lokasi RealTime",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: tinggilayar / lebarlayar * 9),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: tinggilayar / 50,
            ),
            SizedBox(
              height: 300,
              child: WebViewWidget(controller: webViewController),
            ),
            SizedBox(
              height: tinggilayar / 50,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: lebarlayar / 20),
              width: lebarlayar,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Laporan Terbaru",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: tinggilayar / lebarlayar * 9),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: tinggilayar / 50,
            ),
            SizedBox(
              height: tinggilayar / 2,
              child: FutureBuilder<List<Laporan>>(
                  future: fetchAllLaporan(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<Laporan> data = snapshot.data!;
                      return ListView.builder(
                          // scrollDirection: Axis.vertical,
                          padding: EdgeInsets.only(bottom: tinggilayar / 15),
                          itemCount: data.length,
                          itemBuilder: (context, i) {
                            return GestureDetector(
                              onTap: () {
                                pindahPageCupertino(context,
                                    DetailLaporan(index: i, laporan: data[i]));
                              },
                              child: CardWithImage(
                                index: i.toString(),
                                title: data[i].judul_laporan,
                                deskripsi: data[i].kronologi_kejadian,
                                publisher: "Admin",
                                image: data[i].link_foto,
                              ),
                            );
                          });
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    return SizedBox(
                      height: tinggilayar / 10,
                      width: tinggilayar / 10,
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

Future<List<Berita>> fetchDataBerita() async {
  var response = await ApiController().getDataBerita();
  List<Berita> beritaList = List.empty(growable: true);
  var jsonlist = response.data as List;
  for (var element in jsonlist) {
    beritaList.add(Berita.fromJson(element));
  }
  listBerita = beritaList;
  return beritaList;
  // return notifikasiList;
}

Future<List<Laporan>> fetchAllLaporan() async {
  var response = await ApiController().getDataAllLaporan();
  List<Laporan> beritaList = List.empty(growable: true);
  var jsonlist = response.data as List;
  for (var element in jsonlist) {
    beritaList.add(Laporan.fromJson(element));
  }
  return beritaList;
  // return notifikasiList;
}

class CardWithImage extends StatelessWidget {
  final String? title;
  final String? deskripsi;
  final String? publisher;
  final String? image;
  final String? index;
  final VoidCallback? onTap;

  const CardWithImage(
      {super.key,
      this.index,
      this.onTap,
      this.title,
      this.deskripsi,
      this.publisher,
      this.image});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 1),
                spreadRadius: 1,
                blurRadius: 3,
                color: Colors.grey.shade300),
          ],
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        margin: EdgeInsets.only(
            bottom: tinggilayar / 50,
            left: lebarlayar / 20,
            right: lebarlayar / 20),
        height: tinggilayar / 5,
        width: lebarlayar,
        child: Row(
          children: [
            SizedBox(
              height: tinggilayar / 5,
              width: lebarlayar / 3,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Hero(
                  tag: "gmbr${index!}",
                  child: Image.network(
                    image!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: lebarlayar / 50,
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.all(lebarlayar / 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title!,
                      style: TextStyle(
                          color: primarycolor,
                          fontSize: tinggilayar / lebarlayar * 7,
                          fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      deskripsi!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      style: TextStyle(fontSize: tinggilayar / lebarlayar * 5),
                    ),
                    Text(
                      "Publisher by: ${publisher!}",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: tinggilayar / lebarlayar * 4,
                          color: Colors.grey[500]),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
