import 'package:flutter/material.dart';
import 'package:segments/additionpage/detail/lembur_khusus_edit.dart';
import 'package:segments/apicontroller.dart';
import 'package:segments/constant.dart';
import 'package:segments/function/route.dart';
import 'package:segments/my_function.dart';

class ListLemburKhususDetail extends StatefulWidget {
  final String tipe;
  final String nik;
  final String judul;
  const ListLemburKhususDetail(
      {super.key, required this.tipe, required this.nik, required this.judul});

  @override
  ListLemburKhususDetailState createState() => ListLemburKhususDetailState();
}

class ListLemburKhususDetailState extends State<ListLemburKhususDetail> {
  // ignore: unused_field
  String _nik = '';
  // ignore: unused_field
  String _tipe = '0';
  String _judul = '';
  int position = 1;
  List<dynamic> _dataLemburKhusus = [];
  @override
  void initState() {
    // init();
    _getDataLemburKhusus(widget.tipe.toString(), widget.nik);
    _tipe = widget.tipe;
    _nik = widget.nik;
    _judul = widget.judul;
    super.initState();
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
        backgroundColor: primarycolor,
        elevation: 0,
        title: const Text(
          "List Lembur Khusus",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Text(_judul),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SingleChildScrollView(
                scrollDirection: Axis.horizontal, child: _createDataTable()),
          ),
        ],
      ),
    );
  }

  DataTable _createDataTable() {
    return DataTable(
      columns: _createColumns(),
      rows: _createRows(),
      showBottomBorder: true,
    );
  }

  List<DataColumn> _createColumns() {
    return [
      const DataColumn(label: Text('No')),
      const DataColumn(label: Text('Tgl LemburKhusus')),
      const DataColumn(label: Text('Jenis LemburKhusus')),
      const DataColumn(label: Text('Mulai')),
      const DataColumn(label: Text('Selesai')),
      const DataColumn(label: Text('NIK')),
      const DataColumn(label: Text('Nama')),
      const DataColumn(label: Text('Kajaga')),
      const DataColumn(label: Text('Aksi')),
    ];
  }

  List<DataRow> _createRows() {
    if (_dataLemburKhusus.isNotEmpty) {
      int num = 0;
      return _dataLemburKhusus.map((data) {
        num++;
        return DataRow(cells: [
          DataCell(Text(num.toString())),
          DataCell(Text(data['tgl_lembur_khusus'].toString())),
          DataCell(Text(data['jenis_lembur_khusus'].toString())),
          DataCell(Text(data['mulai'].toString())),
          DataCell(Text(data['selesai'].toString())),
          DataCell(Text(data['nik'])),
          DataCell(Text(data['karyawan']['nama_lengkap'])),
          const DataCell(Text("")),
          DataCell(GestureDetector(
            onTap: () {
              Navigator.pop(context);
              pindahPageCupertino(
                  context,
                  LemburKhususEdit(
                    idLemburKhusus: data['id_lembur_khusus'].toString(),
                    jenisLemburKhusus: data['jenis_lembur_khusus'].toString(),
                    tglLemburKhusus: data['tgl_lembur_khusus'].toString(),
                    mulai: data['mulai'].toString().substring(0, 5),
                    selesai: data['selesai'].toString().substring(0, 5),
                  ));
            },
            child: const Text(
              "Edit",
            ),
          ))
        ]);
      }).toList();
    } else {
      return [
        const DataRow(cells: [
          DataCell(Text('Data Tidak ada')),
          DataCell(Text('')),
          DataCell(Text('')),
          DataCell(Text('')),
          DataCell(Text('')),
          DataCell(Text('')),
          DataCell(Text('')),
          DataCell(Text('')),
          DataCell(Text(''))
        ]),
      ];
    }
  }

  init() async {
    String nik = await MyFunction().getNik();
    // print(nik);
    setState(() {
      _nik = nik;
      _tipe = widget.tipe;
    });
  }

  Future _getDataLemburKhusus(String tipe, String nik) async {
    Map<String, String> body = {'tipe': tipe, 'nik': nik};
    var response = await ApiController().getDataLemburKhusus(body);
    if (response.status) {
      if (response.data.length > 0) {
        // print(response.data.isList);
        setState(() {
          _dataLemburKhusus = response.data;
        });
      }
    }
  }
}
