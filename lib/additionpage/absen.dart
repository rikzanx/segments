import 'package:flutter/material.dart';
import 'package:segments/additionpage/kehadiran.dart';
import 'package:segments/additionpage/detail/ijin.dart';
import 'package:segments/additionpage/detail/dispensasi.dart';
import 'package:segments/additionpage/detail/sakit.dart';
import 'package:segments/additionpage/detail/cuti.dart';
import 'package:segments/constant.dart';
import 'package:segments/function/route.dart';

class Absen extends StatefulWidget {
  const Absen({super.key});

  @override
  AbsenState createState() => AbsenState();
}

class AbsenState extends State<Absen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondarycolor,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            padding: const EdgeInsets.all(20),
            child: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: primarycolor,
        elevation: 0,
        title: const Text(
          "Absen",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              CardFunction(
                asset: Image.asset(
                  "assets/ijin.png",
                  fit: BoxFit.cover,
                ),
                fungsi: () {
                  pindahPageCupertino(context, const Ijin());
                },
                judul: "Ijin",
                deskripsi: "Ini Deksripsi",
              ),
              SizedBox(
                height: tinggilayar / 80,
              ),
              CardFunction(
                asset: Image.asset(
                  "assets/absen.png",
                  fit: BoxFit.cover,
                ),
                fungsi: () {
                  pindahPageCupertino(context, const Dispensasi());
                },
                judul: "Dispensasi",
                deskripsi: "Ini Deksripsi",
              ),
              SizedBox(
                height: tinggilayar / 80,
              ),
              CardFunction(
                asset: Image.asset(
                  "assets/sakit.png",
                  fit: BoxFit.cover,
                ),
                fungsi: () {
                  pindahPageCupertino(context, const Sakit());
                },
                judul: "Sakit",
                deskripsi: "Ini Deksripsi",
              ),
              SizedBox(
                height: tinggilayar / 80,
              ),
              CardFunction(
                asset: Image.asset(
                  "assets/cuti.png",
                  fit: BoxFit.cover,
                ),
                fungsi: () {
                  pindahPageCupertino(context, const Cuti());
                },
                judul: "Cuti",
                deskripsi: "Ini Deksripsi",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
