// import 'package:flutter/foundation.dart';
// import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:segments/constant.dart';
import 'package:segments/my_function.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ResumeKpiDetail extends StatefulWidget {
  final String bulan;
  final String nik;
  final String judul;
  final String tahun;
  const ResumeKpiDetail(
      {super.key, required this.bulan, required this.nik, required this.judul, required this.tahun});

  @override
  ResumeKpiDetailState createState() => ResumeKpiDetailState();
}

class ResumeKpiDetailState extends State<ResumeKpiDetail> {
  late final WebViewController webViewController = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(Colors.transparent)
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
        'http://$baseUrl/webview/resume_kpi/$_tahun?nik=$_nik'));
  String _nik = '';
  String _bulan = '1';

  // ignore: unused_field
  String _judul = '';
  int position = 1;
  String _tahun = DateTime.now().year.toString();
  @override
  void initState() {
    // init();
    _bulan = widget.bulan;
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
            "Resume KPI",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: IndexedStack(index: position, children: <Widget>[
          WebViewWidget(controller: webViewController),
          Center(child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(primarycolor),
          ))
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
