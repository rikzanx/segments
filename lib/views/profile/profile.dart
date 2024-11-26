import 'package:flutter/material.dart';
import 'package:segments/apicontroller.dart';
import 'package:segments/constant.dart';
import 'package:segments/function/route.dart';
import 'package:segments/models/laporan.dart';
import 'package:segments/my_function.dart';
import 'package:segments/views/login/login_new.dart';
// import 'package:segments/views/notifikasi/notifikasi.dart';
import 'package:segments/views/profile/edit.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  ProfileState createState() => ProfileState();
}

class ProfileState extends State<Profile> {
  bool buttongridclicked = false;
  bool buttonlistclicked = true;
  Map<String, dynamic> data = {};

  List<Laporan> myLaporan = [];
  int menunggu = 0;
  int proses = 0;
  int selesai = 0;

  @override
  void initState() {
    getDataMyLaporan(dataUser['karyawan']['nik']);
    getStatusLaporan(dataUser['karyawan']['nik']);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.only(top: tinggilayar / 50),
            height: tinggilayar / 1.1,
            width: lebarlayar,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Positioned(
                  child: Text(
                    "Profil",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: primarycolor,
                        fontSize: tinggilayar / lebarlayar * 12),
                  ),
                ),
                Positioned(
                  child: Container(
                    padding: EdgeInsets.all(marginhorizontal),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              offset: const Offset(0, 2),
                              blurRadius: 2,
                              color: Colors.grey.shade400),
                        ]),
                    height: tinggilayar / 3.4,
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(
                        vertical: tinggilayar / 15,
                        horizontal: marginhorizontal),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 35,
                              foregroundImage: NetworkImage(
                                "$protokol$baseUrl/assets/foto_profil/${dataUser['karyawan']['user']['foto']}",
                              ),
                            ),
                            SizedBox(
                              width: lebarlayar / 20,
                            ),
                            SizedBox(
                              width: lebarlayar / 3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    dataUser['karyawan']['pt'],
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: tinggilayar / lebarlayar * 6),
                                  ),
                                  Text(
                                    dataUser['karyawan']['nama_lengkap'],
                                    style: TextStyle(
                                        fontSize: tinggilayar / lebarlayar * 6,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    dataUser['karyawan']['zona']['nama_zona'],
                                    style: TextStyle(
                                        color: primarycolor,
                                        fontSize: tinggilayar / lebarlayar * 5),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: tinggilayar / 60,
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                  text: "NIK : ",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(
                                  text: dataUser['karyawan']['nik'].toString())
                            ],
                            style: TextStyle(
                                fontFamily: "Poppins",
                                color: Colors.black,
                                fontSize: tinggilayar / lebarlayar * 6),
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                  text: "Zona : ",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(
                                  text: dataUser['karyawan']['zona']
                                          ['nama_zona']
                                      .toString(),
                                  style: const TextStyle(
                                    fontSize: 12,
                                  ))
                            ],
                            style: TextStyle(
                                fontFamily: "Poppins",
                                color: Colors.black,
                                fontSize: tinggilayar / lebarlayar * 6),
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                  text: "Regu : ",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(
                                  text: dataUser['karyawan']['regu']
                                          ['nama_regu']
                                      .toString())
                            ],
                            style: TextStyle(
                                fontFamily: "Poppins",
                                color: Colors.black,
                                fontSize: tinggilayar / lebarlayar * 6),
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                  text: "Jabatan : ",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(
                                  text: dataUser['karyawan']['jabatan']
                                          ['nama_jabatan']
                                      .toString(),
                                  style: const TextStyle(
                                    fontSize: 12,
                                  )),
                            ],
                            style: TextStyle(
                                fontFamily: "Poppins",
                                color: Colors.black,
                                fontSize: tinggilayar / lebarlayar * 6),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  child: Container(
                    height: tinggilayar / 12,
                    width: lebarlayar / 1.7,
                    margin: EdgeInsets.symmetric(vertical: tinggilayar / 3.1),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: primarycolor),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                menunggu.toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: tinggilayar / lebarlayar * 7),
                              ),
                              Text(
                                "Menunggu",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: tinggilayar / lebarlayar * 5),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                proses.toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: tinggilayar / lebarlayar * 7),
                              ),
                              Text(
                                "Proses",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: tinggilayar / lebarlayar * 5),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                selesai.toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: tinggilayar / lebarlayar * 7),
                              ),
                              Text(
                                "Selesai",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: tinggilayar / lebarlayar * 5),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                //LOGOUT
                Positioned(
                  right: 32,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent, shadowColor: Colors.transparent),
                      onPressed: () async {
                        await MyFunction().logout();
                        Navigator.pushAndRemoveUntil(context,
                            MaterialPageRoute(builder: (context) {
                          return const LoginNew();
                        }), (route) => false);
                      },
                      child: Icon(
                          Icons.logout,
                          color: primarycolor,
                        )
                      ),
                ),
                //EDIT
                Positioned(
                    left: 32,
                    child: IconButton(
                      onPressed: () {
                        //action coe when button is pressed
                        pindahPageCupertino(context, const Edit());
                      },
                      icon: Icon(
                        Icons.edit,
                        color: primarycolor,
                      ),
                    )),
                SizedBox.expand(
                  child: DraggableScrollableSheet(
                    initialChildSize: 0.5,
                    minChildSize: 0.5,
                    maxChildSize: 1,
                    builder: (BuildContext context, listController) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 2,
                              offset: const Offset(0, 0),
                            ),
                          ],
                        ),
                        child: ListView(
                          padding: EdgeInsets.only(bottom: tinggilayar / 15),
                          controller: listController,
                          children: [
                            SizedBox(
                              height: tinggilayar / 80,
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: lebarlayar / 3),
                              color: Colors.grey,
                              height: 5,
                            ),
                            SizedBox(
                              height: tinggilayar / 30,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: lebarlayar / 30),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: lebarlayar / 3,
                                    child: Text(
                                      "Laporan Saya",
                                      style: TextStyle(
                                          fontSize:
                                              tinggilayar / lebarlayar * 6),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              buttongridclicked = true;
                                              buttonlistclicked = false;
                                            });
                                          },
                                          child: const Icon(Icons.grid_view)),
                                      SizedBox(
                                        width: lebarlayar / 50,
                                      ),
                                      GestureDetector(
                                          onTap: () {
                                            setState(
                                              () {
                                                buttongridclicked = false;
                                                buttonlistclicked = true;
                                              },
                                            );
                                          },
                                          child:
                                              const Icon(Icons.list_rounded)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: tinggilayar / 40,
                            ),
                            // ... rest of your code
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future getDataMyLaporan(String nik) async {
    Map<String, String> body = {'nik': nik};
    var response = await ApiController().getDataMyLaporan(body);
    List<Laporan> laporanList = List.empty(growable: true);
    var jsonlist = response.data as List;
    // print(jsonlist);
    for (var element in jsonlist) {
      laporanList.add(Laporan.fromJson(element));
    }
    // print(laporanList);
    setState(() {
      myLaporan = laporanList;
    });
  }

  Future getStatusLaporan(String nik) async {
    Map<String, String> body = {'nik': nik};
    var response = await ApiController().getStatusLaporan(body);
    if (response.status) {
      setState(() {
        menunggu = response.data['menunggu'];
        proses = response.data['proses'];
        selesai = response.data['selesai'];
      });
    }
  }
}
