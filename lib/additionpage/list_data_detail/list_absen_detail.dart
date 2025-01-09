import 'package:flutter/material.dart';
import 'package:segments/apicontroller.dart';
import 'package:segments/constant.dart';
import 'package:segments/my_function.dart';

class ListAbsenDetail extends StatefulWidget {
  final String tipe;
  final String nik;
  final String judul;
  final String tahun;
  const ListAbsenDetail(
      {super.key, required this.tipe, required this.nik, required this.judul, required this.tahun});

  @override
  ListAbsenDetailState createState() => ListAbsenDetailState();
}

class ListAbsenDetailState extends State<ListAbsenDetail> {
  // ignore: unused_field
  String _nik = '';
  // ignore: unused_field
  String _tipe = '0';
  String _judul = '';
  int position = 1;
  String _tahun = DateTime.now().year.toString();
  List<dynamic> _dataAbsen = [];
  @override
  void initState() {
    // init();
    _getDataAbsen(widget.tipe.toString(), widget.nik, widget.tahun);
    _tipe = widget.tipe;
    _nik = widget.nik;
    _judul = widget.judul;
    _tahun = widget.tahun;
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
          "List Absen",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Text(_judul),
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
      const DataColumn(label: Text('Tgl Absen')),
      const DataColumn(label: Text('NIK')),
      const DataColumn(label: Text('Nama')),
      const DataColumn(label: Text('Tipe Absen')),
      const DataColumn(label: Text('Detail')),
      const DataColumn(label: Text('Validasi')),
      const DataColumn(label: Text('Mengetahui')),
      const DataColumn(label: Text('Reject')),
    ];
  }

  List<DataRow> _createRows() {
    if (_dataAbsen.isNotEmpty) {
      int num = 0;
      return _dataAbsen.map((data) {
        num++;
        final isEvenRow = num % 2 == 0;
        return DataRow(
          color: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
              return isEvenRow ? Colors.grey[200] : null;
            },
          ),
          cells: [
            DataCell(Text(num.toString())),
            DataCell(Text(data['tgl_absen'].toString())),
            DataCell(Text(data['nik'])),
            DataCell(Text(data['karyawan']['nama_lengkap'])),
            DataCell(Text(data['tipe_absen'])),
            DataCell(Text(data['detail'])),
            DataCell(Text(data['validasi']?.toString() ?? "")),
            DataCell(Text(data['mengetahui']?.toString() ?? "")),
            DataCell(Text(data['reject_by']?.toString() ?? "")),
          ]
        );
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
      _tahun = widget.tahun;
    });
  }

  Future _getDataAbsen(String tipe, String nik, String tahun) async {
    Map<String, String> body = {'tipe': tipe, 'nik': nik, 'tahun': tahun};
    var response = await ApiController().getDataAbsen(body);
    if (response.status) {
      if (response.data.length > 0) {
        // print(response.data.isList);
        setState(() {
          _dataAbsen = response.data;
        });
      }
    }
  }
}
