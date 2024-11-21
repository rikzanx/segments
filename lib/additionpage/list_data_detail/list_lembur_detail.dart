import 'package:flutter/material.dart';
import 'package:segments/additionpage/detail/lembur_edit.dart';
import 'package:segments/apicontroller.dart';
import 'package:segments/constant.dart';
import 'package:segments/function/route.dart';
import 'package:segments/my_function.dart';

class ListLemburDetail extends StatefulWidget {
  final String tipe;
  final String nik;
  final String judul;
  const ListLemburDetail(
      {super.key, required this.tipe, required this.nik, required this.judul});

  @override
  ListLemburDetailState createState() => ListLemburDetailState();
}

class ListLemburDetailState extends State<ListLemburDetail> {
  // ignore: unused_field
  String _nik = '';
  // ignore: unused_field
  String _tipe = '0';
  String _judul = '';
  int position = 1;
  int sumtotaljamlembur = 0;
  List<dynamic> _dataLembur = [];
  @override
  void initState() {
    // init();
    _getDataLembur(widget.tipe.toString(), widget.nik);
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
        title: Text(
          "List Lembur",
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Text(_judul),
          Text("Total $_judul : $sumtotaljamlembur"),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: MediaQuery.of(context).size.width,
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: _createDataTable(),
                ),
              ),
            ),
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
      const DataColumn(label: Text('Tgl Lembur')),
      const DataColumn(label: Text('Total Jam')),
      const DataColumn(label: Text('Jenis Lembur')),
      const DataColumn(label: Text('Detail Lembur')),
      const DataColumn(label: Text('Mulai')),
      const DataColumn(label: Text('Selesai')),
      const DataColumn(label: Text('NIK')),
      const DataColumn(label: Text('Nama')),
      const DataColumn(label: Text('Kajaga')),
      const DataColumn(label: Text('Aksi')),
    ];
  }

  List<DataRow> _createRows() {
    if (_dataLembur.isNotEmpty) {
      int num = 0;
      return _dataLembur.map((data) {
        num++;
        return DataRow(cells: [
          DataCell(Text(num.toString())),
          DataCell(Text(data['tgl_lembur'].toString())),
          DataCell(Text(data['total_jam_lembur'].toString())),
          DataCell(Text(data['jenis_lembur'].toString())),
          DataCell(Text(data['detail_lembur'].toString())),
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
                  LemburEdit(
                    idLembur: data['id_lembur'].toString(),
                    jenisLembur: data['jenis_lembur'].toString(),
                    tglLembur: data['tgl_lembur'].toString(),
                    mulai: data['mulai'].toString().substring(0, 5),
                    selesai: data['selesai'].toString().substring(0, 5),
                  ));
            },
            child: const Text(
              "Edit",
              style: TextStyle(color: Colors.red),
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

  Future _getDataLembur(String tipe, String nik) async {
    Map<String, String> body = {'tipe': tipe, 'nik': nik};
    var response = await ApiController().getDataLembur(body);
    if (response.status) {
      if (response.data.length > 0) {
        // print(response.data.isList);
        setState(() {
          _dataLembur = response.data;
          sumtotaljamlembur = _dataLembur.fold(
            0,
            (sum, data) => sum + int.parse(data['total_jam_lembur']),
          );
        });
      }
    }
  }
}
