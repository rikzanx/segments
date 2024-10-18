import 'package:flutter/material.dart';
import 'package:segments/constant.dart';
import 'package:segments/home.dart';

class Cari extends StatefulWidget {
  const Cari({super.key});

  @override
  CariState createState() => CariState();
}

class CariState extends State<Cari> {
  final TextEditingController _cariController = TextEditingController();
  bool cari = false;

  bool hasilkategori = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<Map> kategori = List.generate(
        10, (index) => {"id": index, "kategori": "Kategori $index"});

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.only(top: tinggilayar / 50),
            height: tinggilayar,
            width: lebarlayar,
            child: Column(
              children: [
                Center(
                  child: Text(
                    "Pencarian",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: primarycolor,
                        fontSize: tinggilayar / lebarlayar * 12),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(marginhorizontal),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white),
                  padding: const EdgeInsets.all(0.5),
                  child: TextField(
                    onChanged: (val) {
                      if (val == "") {
                        setState(() {
                          cari = false;
                          hasilkategori = false;
                        });
                      } else {
                        setState(() {
                          cari = true;
                          hasilkategori = false;
                        });
                      }
                    },
                    controller: _cariController,
                    decoration: InputDecoration(
                      hintText: "Cari Laporan",
                      suffixIcon: Icon(
                        Icons.search,
                        color: primarycolor,
                      ),
                      border:
                          const OutlineInputBorder(borderSide: BorderSide.none),
                    ),
                  ),
                ),
                hasilkategori == false
                    ? SizedBox(
                        height: tinggilayar / 1.54,
                        child: cari == false
                            ? GridView.builder(
                                padding: EdgeInsets.symmetric(
                                  vertical: marginhorizontal,
                                  horizontal: marginhorizontal,
                                ),
                                itemCount: kategori.length,
                                gridDelegate:
                                    const SliverGridDelegateWithMaxCrossAxisExtent(
                                        maxCrossAxisExtent: 200,
                                        childAspectRatio: 2 / 2,
                                        crossAxisSpacing: 20,
                                        mainAxisSpacing: 20),
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      // print(hasilkategori);
                                      setState(() {
                                        hasilkategori = true;
                                      });
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                "https://hsepedia.com/wp-content/uploads/2020/03/ICON_HSE_SOLID.png",
                                              ),
                                              fit: BoxFit.cover),
                                        ),
                                        child: Stack(
                                          alignment: Alignment.bottomCenter,
                                          children: [
                                            SizedBox(
                                              width: double.infinity,
                                              child: Text(
                                                kategori[index]["kategori"],
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                })
                            : Container(),
                      )
                    : Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: lebarlayar / 30),
                        height: tinggilayar / 1.54,
                        child: ListView.builder(
                          itemBuilder: (context, i) {
                            return GestureDetector(
                              onTap: () {
                                // pindahPageCupertino(
                                //     context, DetailLaporan(index: i));
                              },
                              child: CardWithImage(
                                index: i.toString(),
                                title: "Buat Judul Laporan",
                                deskripsi:
                                    "Deskripsi dari laporan penjelas dari kegiatan atau hasil approval dari beberapa stakeholder",
                                publisher: "Admin",
                                image:
                                    "https://img.okezone.com/content/2019/07/28/320/2084629/petrokimia-gresik-buka-lowongan-kerja-sebagai-pahlawan-solusi-agroindustri-TVETDvYDBK.png",
                              ),
                            );
                          },
                          itemCount: 10,
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
