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
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: primarycolor,
      //   onPressed: _showBottomSheet,
      //   child: Icon(opened == false ? Icons.add : Icons.close),
      //   elevation: 0,
      // ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _buildBottomTab(),
    );
  }

  // _showBottomSheet() {
  //   setState(
  //     () {
  //       if (opened == false) {
  //         opened = true;
  //         Scaffold.of(context).showBottomSheet((BuildContext context) {
  //           return GestureDetector(
  //             onHorizontalDragStart: (_) {},
  //             onVerticalDragUpdate: (_) {},
  //             onVerticalDragStart: (_) {},
  //             onHorizontalDragCancel: () {},
  //             onVerticalDragCancel: () {},
  //             onVerticalDragEnd: (_) {},
  //             onVerticalDragDown: (_) {},
  //             behavior: HitTestBehavior.opaque,
  //             child: BackdropFilter(
  //               filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
  //               child: Container(
  //                 padding: EdgeInsets.symmetric(
  //                     horizontal: lebarlayar / 7, vertical: tinggilayar / 20),
  //                 height: tinggilayar / 3,
  //                 decoration: const BoxDecoration(
  //                   borderRadius: BorderRadius.only(
  //                     topLeft: Radius.circular(20),
  //                     topRight: Radius.circular(20),
  //                   ),
  //                   color: Color(0xFFEFEFEF),
  //                 ),
  //                 child: Center(
  //                     child: Column(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   crossAxisAlignment: CrossAxisAlignment.center,
  //                   children: [
  //                     Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       children: [
  //                         GestureDetector(
  //                           onTap: () {
  //                             _showBottomSheet();
  //                             pindahPageCupertino(context, const Kehadiran());
  //                           },
  //                           child: Container(
  //                             height: tinggilayar / 9,
  //                             width: lebarlayar / 3.5,
  //                             decoration: BoxDecoration(
  //                               color: Colors.white,
  //                               borderRadius: BorderRadius.circular(10),
  //                             ),
  //                             child: Center(
  //                               child: Column(
  //                                 mainAxisAlignment: MainAxisAlignment.center,
  //                                 children: [
  //                                   SizedBox(
  //                                       height: tinggilayar / 20,
  //                                       width: lebarlayar / 5,
  //                                       child: Image.asset("assets/hadir.png")),
  //                                   Text(
  //                                     "Kehadiran",
  //                                     style: TextStyle(
  //                                         color: Colors.black,
  //                                         fontWeight: FontWeight.bold,
  //                                         fontSize:
  //                                             tinggilayar / lebarlayar * 5),
  //                                   ),
  //                                 ],
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                         GestureDetector(
  //                           onTap: () {
  //                             _showBottomSheet();
  //                             pindahPageCupertino(context, const Absen());
  //                           },
  //                           child: Container(
  //                             height: tinggilayar / 9,
  //                             width: lebarlayar / 3.5,
  //                             decoration: BoxDecoration(
  //                               color: Colors.white,
  //                               borderRadius: BorderRadius.circular(10),
  //                             ),
  //                             child: Center(
  //                               child: Column(
  //                                 mainAxisAlignment: MainAxisAlignment.center,
  //                                 children: [
  //                                   SizedBox(
  //                                       height: tinggilayar / 20,
  //                                       width: lebarlayar / 5,
  //                                       child: Image.asset("assets/absen.png")),
  //                                   Text(
  //                                     "Absen",
  //                                     style: TextStyle(
  //                                         color: Colors.black,
  //                                         fontWeight: FontWeight.bold,
  //                                         fontSize:
  //                                             tinggilayar / lebarlayar * 5),
  //                                   ),
  //                                 ],
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                     Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       children: [
  //                         GestureDetector(
  //                           onTap: () {
  //                             _showBottomSheet();
  //                             pindahPageCupertino(context, const Pengajuan());
  //                           },
  //                           child: Container(
  //                             height: tinggilayar / 9,
  //                             width: lebarlayar / 3.5,
  //                             decoration: BoxDecoration(
  //                               color: Colors.white,
  //                               borderRadius: BorderRadius.circular(10),
  //                             ),
  //                             child: Center(
  //                               child: Column(
  //                                 mainAxisAlignment: MainAxisAlignment.center,
  //                                 children: [
  //                                   SizedBox(
  //                                     height: tinggilayar / 20,
  //                                     width: lebarlayar / 5,
  //                                     child: Image.asset(
  //                                       "assets/pengajuan.png",
  //                                       fit: BoxFit.fitHeight,
  //                                     ),
  //                                   ),
  //                                   Text(
  //                                     "Pengajuan",
  //                                     style: TextStyle(
  //                                         color: Colors.black,
  //                                         fontWeight: FontWeight.bold,
  //                                         fontSize:
  //                                             tinggilayar / lebarlayar * 5),
  //                                   ),
  //                                 ],
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                         GestureDetector(
  //                           onTap: () {
  //                             _showBottomSheet();
  //                             pindahPageCupertino(
  //                                 context, const TambahLaporan());
  //                             // MyFunction().belumTersedia();
  //                           },
  //                           child: Container(
  //                             height: tinggilayar / 9,
  //                             width: lebarlayar / 3.5,
  //                             decoration: BoxDecoration(
  //                               color: Colors.white,
  //                               borderRadius: BorderRadius.circular(10),
  //                             ),
  //                             child: Center(
  //                               child: Column(
  //                                 mainAxisAlignment: MainAxisAlignment.center,
  //                                 children: [
  //                                   SizedBox(
  //                                     height: tinggilayar / 20,
  //                                     width: lebarlayar / 5,
  //                                     child: Image.asset(
  //                                       "assets/laporan.png",
  //                                     ),
  //                                   ),
  //                                   Text(
  //                                     "Pelaporan",
  //                                     style: TextStyle(
  //                                         color: Colors.black,
  //                                         fontWeight: FontWeight.bold,
  //                                         fontSize:
  //                                             tinggilayar / lebarlayar * 5),
  //                                   ),
  //                                 ],
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ],
  //                 )),
  //               ),
  //             ),
  //           );
  //         }, backgroundColor: Colors.black.withOpacity(0.2));
  //       } else {
  //         opened = false;
  //         Navigator.pop(context);
  //       }
  //     },
  //   );
  // }

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
