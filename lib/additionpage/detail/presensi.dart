import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:segments/class/form_component.dart';
import 'package:segments/constant.dart';
import 'package:segments/gpscontroller.dart';
// import 'package:safe_device/safe_device.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:segments/apicontroller.dart';
import 'package:bot_toast/bot_toast.dart';

Map<String, dynamic> data = {};

class PresensiMasuk extends StatefulWidget {
  const PresensiMasuk({super.key});

  @override
  PresensiMasukState createState() => PresensiMasukState();
}


class PresensiMasukState extends State<PresensiMasuk> {
  late final WebViewController webViewController = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(Colors.transparent)
    ..loadRequest(
        Uri.parse('$protokol$baseUrl/maps/android?lat=$lat&lng=$lng'));
  final lokasiController = TextEditingController();
  double lat = 0.0, lng = 0.0;

  String action = "";
  bool canMockLocation = false;
  bool isMockLocation = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  cek() async {}

  @override
  Widget build(BuildContext context) {
    Future<void> save() async {
      if (!mounted) return;

      if (isMockLocation) {
        await showDialog(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Gagal Absen'),
              content: const Text(
                  "HP anda terdeteksi mengaktifkan mock gps (fake gps) mohon untuk mematikan perijinan dan tidak memakai aplikasi fake gps"),
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
      } else {
        BotToast.showLoading();

        var body = {
          'nama_lengkap': data['karyawan']['nama_lengkap'].toString(),
          'user_id_penerima': data['karyawan']['jabatan']['atasan_1']['user']
                  ['id_user']
              .toString(),
          'niknik': data['karyawan']['user']['nik'].toString(),
          'lat': lat.toString(),
          'lng': lng.toString(),
          'id_zona': data['karyawan']['zona']['id_zona'].toString(),
          'id_regu': data['karyawan']['regu']['id_regu'].toString(),
          'id_jabatan': data['karyawan']['jabatan']['id_jabatan'].toString(),
          'version' : '22'
        };

        if (action == "OFF") {
          body['jadwal_kerja'] = "OFF";
        } else {
          body['jadwal_kerja'] =
              "|${data['jadwal']['action']}|  ${data['jadwal']['jam_masuk']} - ${data['jadwal']['jam_keluar']}";
        }

        try {
          final response = await ApiController().checkin(body);

          if (!mounted) return;

          var value = response.data;
          BotToast.closeAllLoading();

          if (value['success'] == true) {
            await showDialog(
              // ignore: use_build_context_synchronously
              context: context,
              barrierDismissible: false, // user must tap button!
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Success'),
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
            await showDialog(
              // ignore: use_build_context_synchronously
              context: context,
              barrierDismissible: false, // user must tap button!
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Error'),
                  content: const Text('Gagal checkin'),
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
        } catch (e) {
          BotToast.closeAllLoading();
          // Handle the error or show an error dialog
          await showDialog(
            // ignore: use_build_context_synchronously
            context: context,
            barrierDismissible: false, // user must tap button!
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Error'),
                content: Text('Gagal melakukan checkin: $e'),
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
      }
    }

    return Scaffold(
      bottomSheet: PrimaryButton(
        warna: secondarycolor,
        onClick: () {
          save();
        },
        teksnya: "Kirim",
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
          "Presensi Masuk",
          style: TextStyle(color: primarycolor, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: tinggilayar * 1.1,
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
                    horizontal: marginhorizontal, vertical: tinggilayar / 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Jadwal Masuk",
                      style: TextStyle(fontSize: tinggilayar / lebarlayar * 7),
                    ),
                    SizedBox(
                      height: tinggilayar / 100,
                    ),
                    TextFormField(
                      readOnly: true,
                      decoration: InputDecoration(
                        fillColor: Colors.grey[200],
                        suffixIcon: const Icon(Icons.calendar_today),
                        hintText:
                        (data['jadwal'] != null && data['jadwal']['action'] != null)
                        ? "|${data['jadwal']['action']}|  ${data['jadwal']['jam_masuk']} - ${data['jadwal']['jam_keluar']}"
                        : '-',
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
                height: 210,
                child: lat == 0.0
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : WebViewWidget(controller: webViewController),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future init() async {
    await ApiController().getUser().then((value) {
      if (1==1) {
        setState(() {
          data = value.data;
          action = value.data["jadwal"]["action"];
          // print("data=$action");
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
    bool hasil = false;
    setState(() {
      isMockLocation = hasil;
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

class InfoUser extends StatelessWidget {
  final Map<String, dynamic> dataUser;
  const InfoUser({
    super.key,
    required this.dataUser
  });

  @override
  Widget build(BuildContext context) {
    final foto = dataUser['karyawan']?['user']?['foto'] ?? 'default.png';
    final nik = dataUser['karyawan']?['user']?['nik'] ?? '';
    final nama = dataUser['karyawan']?['nama_lengkap'] ?? '';
    final zona = dataUser['karyawan']?['zona']?['nama_zona'] ?? '';
    final regu = dataUser['karyawan']?['regu']?['nama_regu'] ?? '';
    final jabatan = dataUser['karyawan']?['jabatan']?['nama_jabatan'] ?? '';
    return Container(
      padding: EdgeInsets.symmetric(horizontal: marginhorizontal),
      width: lebarlayar,
      height: tinggilayar / 2.5,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              offset: const Offset(0, 1),
              spreadRadius: 0,
              blurRadius: 5,
              color: Colors.grey.shade400)
        ],
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: SizedBox(
              width: lebarlayar / 3,
              height: tinggilayar / 4,
              child: Image.network(
                '$protokol$baseUrl/assets/foto_profil/$foto',
                loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              (loadingProgress.expectedTotalBytes ?? 1)
                          : null,
                    ),
                  );
                },
                errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                  return Image.asset(
                    'assets/images/default.png',
                    fit: BoxFit.cover,
                  );
                },
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: marginhorizontal, vertical: tinggilayar / 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                            text: "NIK : ",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(
                          text: nik.toString(),
                        )
                      ],
                      style: TextStyle(
                          fontFamily: "Poppins",
                          color: Colors.black,
                          fontSize: tinggilayar / lebarlayar * 7),
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                            text: "Nama : ",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(
                          text: nama.toString(),
                        )
                      ],
                      style: TextStyle(
                          fontFamily: "Poppins",
                          color: Colors.black,
                          fontSize: tinggilayar / lebarlayar * 7),
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                            text: "Zona : ",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: zona.toString(),
                            style: const TextStyle(
                              fontSize: 12,
                            ))
                      ],
                      style: TextStyle(
                          fontFamily: "Poppins",
                          color: Colors.black,
                          fontSize: tinggilayar / lebarlayar * 7),
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                            text: "Regu : ",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(
                          text: regu.toString(),
                        )
                      ],
                      style: TextStyle(
                          fontFamily: "Poppins",
                          color: Colors.black,
                          fontSize: tinggilayar / lebarlayar * 7),
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                            text: "Jabatan : ",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: jabatan.toString(),
                            style: const TextStyle(
                              fontSize: 12,
                            )),
                      ],
                      style: TextStyle(
                          fontFamily: "Poppins",
                          color: Colors.black,
                          fontSize: tinggilayar / lebarlayar * 7),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
