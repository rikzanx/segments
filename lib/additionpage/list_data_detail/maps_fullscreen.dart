// import 'package:flutter/foundation.dart';
// import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:segments/constant.dart';
import 'package:segments/my_function.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MapsFullscreen extends StatefulWidget {
  const MapsFullscreen({super.key});

  @override
  MapsFullscreenState createState() => MapsFullscreenState();
}

class MapsFullscreenState extends State<MapsFullscreen> {
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
        'https://$baseUrl/maps/android/absen'));
  String _nik = '';
  String _bulan = '1';
  String _tahun = DateTime.now().year.toString();

  // ignore: unused_field
  String _judul = '';
  int position = 1;
  @override
  void initState() {
    // init();
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
            "Lokasi saat ini",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: IndexedStack(index: position, children: <Widget>[
          WebViewWidget(controller: webViewController),
          Center(child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(primarycolor),
          )),
        ]));
  }

  init() async {
    String nik = await MyFunction().getNik();
    // print(nik);
    setState(() {
      _nik = nik;
    });
  }
}
