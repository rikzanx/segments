import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:segments/constant.dart';
import 'package:segments/models/laporan.dart';

class DetailLaporan extends StatefulWidget {
  final int index;
  final Laporan laporan;
  const DetailLaporan({super.key, required this.index, required this.laporan});

  @override
  DetailLaporanState createState() => DetailLaporanState();
}

class DetailLaporanState extends State<DetailLaporan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new),
          color: primarycolor,
        ),
        elevation: 0,
        backgroundColor: secondarycolor,
        title: Text(
          "Laporan",
          style: TextStyle(color: primarycolor, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        height: tinggilayar / 1,
        width: lebarlayar,
        padding: EdgeInsets.symmetric(vertical: marginhorizontal),
        child: Stack(
          children: [
            Positioned(
              child: Container(
                height: tinggilayar / 15,
                padding: EdgeInsets.symmetric(horizontal: marginhorizontal),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      foregroundImage:
                          NetworkImage(widget.laporan.link_foto_profil),
                    ),
                    SizedBox(
                      width: lebarlayar / 30,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.laporan.nama_publisher,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: tinggilayar / lebarlayar * 8),
                        ),
                        Text(
                          Jiffy.parse(widget.laporan.created_at.toString())
                              .fromNow()
                              .toString(),
                          style:
                              TextStyle(fontSize: tinggilayar / lebarlayar * 5),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox.expand(
              child: DraggableScrollableSheet(
                initialChildSize: 0.87,
                minChildSize: 0.87,
                maxChildSize: 1,
                builder: (BuildContext context, listController) {
                  return Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    child: ListView(
                      padding: const EdgeInsets.symmetric(),
                      controller: listController,
                      children: [
                        SizedBox(
                          width: lebarlayar,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(40),
                                topLeft: Radius.circular(40)),
                            child: Hero(
                              tag: "gmbr${widget.index}",
                              child: Image.network(
                                widget.laporan.link_foto,
                                loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) {
                                    return child;
                                  }
                                  return Center(
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(primarycolor),
                                      value: loadingProgress.expectedTotalBytes != null
                                          ? loadingProgress.cumulativeBytesLoaded /
                                              (loadingProgress.expectedTotalBytes ?? 1)
                                          : null,
                                    ),
                                  );
                                },
                                errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                                  return Image.asset(
                                    'assets/images/default.png',
                                    fit: BoxFit.cover,
                                  );
                                },
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: marginhorizontal,
                              vertical: marginhorizontal),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.laporan.judul_laporan,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: tinggilayar / lebarlayar * 10),
                              ),
                              SizedBox(
                                height: tinggilayar / 30,
                              ),
                              Text(
                                "Kronologi:",
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: tinggilayar / lebarlayar * 8),
                              ),
                              SizedBox(
                                height: tinggilayar / 100,
                              ),
                              Text(
                                widget.laporan.kronologi_kejadian,
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                    fontSize: tinggilayar / lebarlayar * 8),
                              ),
                              SizedBox(
                                height: tinggilayar / 30,
                              ),
                              Text(
                                "Akibat Kejadian:",
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: tinggilayar / lebarlayar * 8),
                              ),
                              SizedBox(
                                height: tinggilayar / 100,
                              ),
                              Text(
                                widget.laporan.akibat_kejadian,
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                    fontSize: tinggilayar / lebarlayar * 8),
                              ),
                              SizedBox(
                                height: tinggilayar / 30,
                              ),
                              Text(
                                "Bantuan Pengamanan:",
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: tinggilayar / lebarlayar * 8),
                              ),
                              SizedBox(
                                height: tinggilayar / 100,
                              ),
                              Text(
                                widget.laporan.bantuan_pengamanan,
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                    fontSize: tinggilayar / lebarlayar * 8),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
