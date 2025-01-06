import 'package:flutter/material.dart';
import 'package:segments/additionpage/list_data_detail/list_lembur.dart';
import 'package:segments/additionpage/list_data_detail/list_lembur_bulan.dart';
import 'package:segments/constant.dart';
import 'package:segments/function/route.dart';

class ListLemburTahun extends StatefulWidget {
  const ListLemburTahun({super.key});

  @override
  ListLemburTahunState createState() => ListLemburTahunState();
}

class ListLemburTahunState extends State<ListLemburTahun> {
  int currentYear = DateTime.now().year;
  Map<int, String> bulan = {
    1: 'Januari',
    2: 'Februari',
    3: 'Maret',
    4: 'April',
    5: 'Mei',
    6: 'Juni',
    7: 'Juli',
    8: 'Agustus',
    9: 'September',
    10: 'Oktober',
    11: 'November',
    12: 'Desember'
  };
  Map<int, String> tipe = {
    0: 'Belum Validasi',
    1: 'Sudah Validasi',
    2: 'Ditolak',
  };
  @override
  void initState() {
    super.initState();

    init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: secondarycolor,
        appBar: AppBar(
          leading: GestureDetector(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: primarycolor, // Set the desired green color
          elevation: 0,
          title: const Text(
            "List Lembur",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
          child: Flex(
            mainAxisAlignment: MainAxisAlignment.start,
            direction: Axis.vertical,
            children: [
              for (int i = 0; i <= 5; i++)
                LitleCardFunction(
                    fungsi: () {
                      pindahPageCupertino(
                          context,
                          ListLemburBulan(
                            tahun: (currentYear - i).toString(),
                          ));
                    },
                    judul: (currentYear - i).toString()),
            ],
          ),
        ));
  }

  init() async {
    // String nik = await MyFunction().getNik();
  }
}

class LitleCardFunction extends StatelessWidget {
  final String judul;
  final VoidCallback fungsi;
  final bool disable;
  const LitleCardFunction({
    super.key,
    required this.fungsi,
    required this.judul,
    this.disable = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: fungsi,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10.0),
        padding: EdgeInsets.symmetric(horizontal: marginhorizontal),
        height: tinggilayar / 12,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              offset: Offset(0, 0),
              spreadRadius: 3,
              blurRadius: 10,
              color: Color(0xffEFEFEF),
            ),
          ],
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                judul,
                style: TextStyle(
                    color: disable ? Colors.grey : primarycolor,
                    fontSize: tinggilayar / lebarlayar * 9,
                    fontWeight: FontWeight.bold),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
