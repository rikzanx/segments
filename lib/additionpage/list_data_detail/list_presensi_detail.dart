// import 'package:flutter/foundation.dart';
// import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:segments/constant.dart';
import 'package:segments/my_function.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ListPresensiDetail extends StatefulWidget {
  final String bulan;
  final String nik;
  final String judul;
  const ListPresensiDetail(
      {super.key, required this.bulan, required this.nik, required this.judul});

  @override
  ListPresensiDetailState createState() => ListPresensiDetailState();
}

class ListPresensiDetailState extends State<ListPresensiDetail> {
  late final WebViewController webViewController = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setNavigationDelegate(NavigationDelegate(
      onProgress: (int progress) {
        // Update loading bar.
      },
      onPageStarted: (String url) {
        setState(() {
          position = 1;
        });
      },
      onPageFinished: (String url) {
        setState(() {
          position = 0;
        });
      },
    ))
    ..loadRequest(Uri.parse(
        'https://$baseUrl/webview/detail_presensi/$_bulan?nik=$_nik'));
  String _nik = '';
  String _bulan = '1';

  // ignore: unused_field
  String _judul = '';
  int position = 1;
  @override
  void initState() {
    // init();
    _bulan = widget.bulan;
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
            "List Presensi",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: IndexedStack(index: position, children: <Widget>[
          WebViewWidget(controller: webViewController),
          const Center(child: const CircularProgressIndicator()),
        ]));
  }

  init() async {
    String nik = await MyFunction().getNik();
    // print(nik);
    setState(() {
      _nik = nik;
      _bulan = widget.bulan;
    });
  }
}
