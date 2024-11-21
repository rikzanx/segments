// import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:segments/additionpage/absen.dart';
// import 'package:segments/additionpage/pengajuan.dart';
import 'package:segments/constant.dart';
// import 'package:segments/function/route.dart';
import 'package:segments/views/homes/homekah.dart';
// import 'package:segments/additionpage/kehadiran.dart';
// import 'package:segments/views/laporan/tambah.dart';
import 'package:segments/views/list_data/list_data.dart';
import 'package:segments/views/profile/profile.dart';
import 'package:segments/views/schedule/schedule.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
// import 'package:segments/views/schedule/utils.dart';

// import '../../my_function.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  MainScreenState createState() => MainScreenState();
}

final tabs = ['Home', 'Jadwal', 'Data', 'Profile'];

class MainScreenState extends State<MainScreen> {
  bool exit2 = false;
  int selectedPosition = 0;
  List<Widget> listWidget = [
    const Homekah(),
    const Schedule(
      title: 'Jadwal Kerja',
    ),
    // Cari(),
    const ListData(),
    const Profile(),
  ];
  @override
  late BuildContext context;
  bool opened = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () {
          if (exit2 == false) {
            setState(() {
              exit2 = true;
              Future.delayed(const Duration(seconds: 2))
                  .then((value) => exit2 = false);
            });
            Fluttertoast.showToast(msg: "Ketuk 2 kali untuk keluar");
            return Future.value(false);
          } else {
            Fluttertoast.showToast(msg: "Keluar");
            return Future.value(true);
          }
        },
        child: Builder(
          builder: (BuildContext context) {
            this.context = context;
            return listWidget[selectedPosition];
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _buildBottomTab(),
    );
  }

  _buildBottomTab() {
    return Container(
      width: lebarlayar,
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 0),
            spreadRadius: 0,
            blurRadius: 1,
            color: Color.fromARGB(255, 255, 255, 255),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: GNav(
          rippleColor: const Color.fromARGB(255, 255, 255, 255),
          hoverColor: const Color.fromARGB(255, 238, 236, 236),
          haptic: true,
          tabBorderRadius: 15,
          tabActiveBorder: Border.all(color: primarycolor, width: 1),
          tabBorder: Border.all(color: Colors.grey, width: 1),
          tabShadow: const [
            BoxShadow(color: Color.fromARGB(255, 255, 255, 255), blurRadius: 4)
          ],
          curve: Curves.easeOutExpo,
          duration: const Duration(milliseconds: 200),
          gap: 4,
          color: const Color.fromARGB(255, 160, 160, 160),
          activeColor: primarycolor,
          iconSize: 24,
          tabBackgroundColor: primarycolor.withOpacity(0.1),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          tabs: const [
            GButton(
              icon: LineIcons.home,
              text: 'Home',
            ),
            GButton(
              icon: LineIcons.calendar,
              text: 'Jadwal',
            ),
            GButton(
              icon: LineIcons.file,
              text: 'Data',
            ),
            GButton(
              icon: LineIcons.user,
              text: 'Profil',
            ),
          ],
          selectedIndex: selectedPosition,
          onTabChange: (index) {
            setState(() {
              selectedPosition = index;
            });
          },
        ),
      ),
    );
  }
}
