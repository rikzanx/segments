import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:segments/additionpage/detail/presensi.dart';
import 'package:segments/apicontroller.dart';
import 'package:segments/class/form_component.dart';
import 'package:segments/constant.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PresensiKeluar extends StatefulWidget {
  const PresensiKeluar({super.key});

  @override
  PresensiKeluarState createState() => PresensiKeluarState();
}

class PresensiKeluarState extends State<PresensiKeluar> {
  late final WebViewController webViewController = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..loadRequest(Uri.parse('https://$baseUrl/maps/android?lat=$lat&lng=$lng'));
  final lokasiController = TextEditingController();
  double lat = 0.0, lng = 0.0;

  String jammasuk = "";

  // ignore: non_constant_identifier_names
  String id_presensi = "";

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    Future save() async {
      BotToast.showLoading();

      await ApiController().checkout(id_presensi: id_presensi).then((response) {
        var value = response.data;
        if (!mounted) return;
        if (value['success'] == true) {
          BotToast.closeAllLoading();
          showDialog(
            context: context,
            barrierDismissible: false, // user must tap button!
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Succes'),
                content: Text(value['message']),
                actions: <Widget>[
                  TextButton(
                    child: const Text('Ok'),
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop(true);
                    },
                  ),
                ],
              );
            },
          );
        } else {
          BotToast.closeAllLoading();
          showDialog(
            context: context,
            barrierDismissible: false, // user must tap button!
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Error'),
                content: Text(value['message']),
                actions: <Widget>[
                  TextButton(
                    child: const Text('Ok'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        }
      });
    }

    return Scaffold(
      bottomSheet: PrimaryButton(
        warna: secondarycolor,
        onClick: () {
          save();
        },
        teksnya: "Check Out",
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Icon(
              Icons.arrow_back_ios_new,
              color: primarycolor,
            ),
          ),
        ),
        title: Text(
          "Presensi Keluar",
          style: TextStyle(color: primarycolor, fontWeight: FontWeight.bold),
        ),
      ),
      body: SizedBox(
        height: tinggilayar,
        width: lebarlayar,
        child: Column(
          children: [
            const InfoUser(),
            SizedBox(
              height: tinggilayar / 40,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      offset: const Offset(0, 1),
                      spreadRadius: 0,
                      blurRadius: 5,
                      color: Colors.grey.shade400)
                ],
              ),
              width: lebarlayar,
              padding: EdgeInsets.symmetric(
                  horizontal: marginhorizontal, vertical: tinggilayar / 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Jam Check In"),
                  SizedBox(
                    height: tinggilayar / 50,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      fillColor: Colors.grey[200],
                      suffixIcon: const Icon(Icons.calendar_today),
                      hintText: jammasuk,
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: tinggilayar / 40,
            ),
            SizedBox(
              height: 200,
              child: lat == 0.0
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : WebViewWidget(controller: webViewController),
            )
          ],
        ),
      ),
    );
  }

  Future init() async {
    await ApiController().getUser().then((response) {
      var value = response.data;
      if (mounted) {
        setState(() {
          data = value;
          // print("data=$data");
        });
      }
    });
    await ApiController().getJamMasuk().then((response) {
      var value = response.data;
      if (mounted) {
        setState(() {
          jammasuk = value["check_in"];
          id_presensi = value["id_presensi"].toString();
        });
      }
    });
    await ApiController().getCurrentLocation().then((value) {
      if (mounted) {
        setState(() {
          lat = value.latitude;
          lng = value.longitude;
          lokasiController.text = "$lat, $lng";
        });
      }
    });
  }
}

class BoxDeskripsi extends StatelessWidget {
  const BoxDeskripsi({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              offset: const Offset(0, 1),
              spreadRadius: 0,
              blurRadius: 5,
              color: Colors.grey.shade400)
        ],
      ),
      width: lebarlayar,
      padding: EdgeInsets.symmetric(
          horizontal: marginhorizontal, vertical: tinggilayar / 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Deskripsi"),
          SizedBox(
            height: tinggilayar / 50,
          ),
          TextFormField(
            maxLines: 6,
            decoration: InputDecoration(
              fillColor: Colors.grey[200],
              hintText: "Deskripsi Disini...",
              filled: true,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none),
            ),
          ),
        ],
      ),
    );
  }
}
