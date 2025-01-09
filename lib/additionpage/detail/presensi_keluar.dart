import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:segments/additionpage/detail/presensi.dart';
import 'package:segments/apicontroller.dart';
import 'package:segments/gpscontroller.dart';
import 'package:segments/class/form_component.dart';
import 'package:segments/constant.dart';
import 'package:webview_flutter/webview_flutter.dart';

Map<String, dynamic> data = {};

class PresensiKeluar extends StatefulWidget {
  const PresensiKeluar({super.key});

  @override
  PresensiKeluarState createState() => PresensiKeluarState();
}

class PresensiKeluarState extends State<PresensiKeluar> {
  late final WebViewController webViewController = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(Colors.transparent)
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
    Future<void> showResponseDialog(BuildContext context, bool success, String message) async {
      await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            title: Text(success ? 'Success' : 'Error'),
            content: Text(message),
            actions: <Widget>[
              TextButton(
                child: const Text('Ok'),
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                  if (success) Navigator.of(dialogContext).pop(true);
                },
              ),
            ],
          );
        },
      );
    }

    Future save() async {
      BotToast.showLoading();
      try{
        final response = await ApiController().checkout(id_presensi: id_presensi);
        if (!mounted) return;

        BotToast.closeAllLoading();
        final value = response.data;
        if(!mounted) return;
        // ignore: use_build_context_synchronously
        await showResponseDialog(context, value['success'], value['message']);
      }catch (e) {
        BotToast.closeAllLoading();
        if (mounted) {
          BotToast.showText(
            text: "Something went wrong: $e",
            contentColor: Colors.red,
          );
        }
      }
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
            InfoUser(dataUser: data,),
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
                  ? Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(primarycolor),
                      ),
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
      if (1==1) {
        setState(() {
          data = value;
          // print("data=$data");
        });
      }
    });
    await ApiController().getJamMasuk().then((response) {
      var value = response.data;
      if (1==1) {
        setState(() {
          jammasuk = value["check_in"];
          id_presensi = value["id_presensi"].toString();
        });
      }
    });
    await GpsController().getCurrentLocation().then((value) {
      if (1==1) {
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
