import 'dart:io';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:segments/class/form_component.dart';
import 'package:segments/constant.dart';
import 'package:segments/views/home/home.dart';
import 'package:segments/views/schedule/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:device_info_plus/device_info_plus.dart';

import '../../apicontroller.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _nikcontroller = TextEditingController();
  final _formkey = GlobalKey<FormFieldState>();
  bool _showpassword = false;

  @override
  void initState() {
    super.initState();
    getDataBerita();
    _showpassword = false;
  }

  @override
  Widget build(BuildContext context) {
    saveToken(token) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);
    }

    saveId(idRegu, idKaryawan, nik, password) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      await prefs.setString('id_regu', idRegu);
      await prefs.setString('id_karyawan', idKaryawan);
      await prefs.setString('nik', nik);
      await prefs.setString('password', password);
    }

    Future initUser() async {
      if (!mounted) return;
      await ApiController().getUser().then((value) {
        if (!mounted) return;
        if (mounted) {
          setState(() {
            dataUser = value.data;
            // print("ok");
            // print(dataUser);
            Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (context) {
              return const MainScreen();
            }), (route) => false);

            BotToast.showText(
                text: "Login Sukses",
                crossPage: true,
                textStyle: const TextStyle(fontSize: 14, color: Colors.white),
                contentColor: Colors.green);
          });
        }
      });
    }

    // print(body);\
    Future<String?> getId() async {
      var deviceInfo = DeviceInfoPlugin();
      if (Platform.isIOS) {
        // import 'dart:io'
        var iosDeviceInfo = await deviceInfo.iosInfo;
        return iosDeviceInfo.identifierForVendor; // unique ID on iOS
      } else if (Platform.isAndroid) {
        var androidDeviceInfo = await deviceInfo.androidInfo;
        return androidDeviceInfo.id; // unique ID on Android
      }
      return null;
    }

    Future save() async {
      if (!mounted) return;
      String? idDevice = "unknown";

      idDevice = await getId();
      // print(idDevice);

      if (idDevice != "unknown") {
        BotToast.showLoading();
        Map<String, String> body = {
          'nik': _nikcontroller.text,
          'password': _passwordcontroller.text,
        };
        
        await ApiController().login(body).then(
          (response) {
            var value = response.data;
            // print(response.status);
            // print(response.data);
            // print(value);
            if (response.status == false) {
              if (!mounted) return;
              BotToast.closeAllLoading();
              showDialog(
                context: context,
                barrierDismissible: false,
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
            } else if (response.status == true) {
              BotToast.closeAllLoading();
              saveToken(value['token']);
              saveId(
                      value['id_regu'].toString(),
                      value['id_karyawan'].toString(),
                      value['nik'].toString(),
                      _passwordcontroller.text)
                  .then((value) {
                initUser();
              });
            } else {
              if (!mounted) return;
              BotToast.closeAllLoading();
              showDialog(
                context: context,
                barrierDismissible: false, // user must tap button!
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Error'),
                    content: const Text('Pastikan mengisi dengan benar'),
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
          },
        );
      } else {
        if (!mounted) return;
        showDialog(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error'),
              content: const Text('Device tidak diketahui'),
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

    return Scaffold(
      backgroundColor: secondarycolor,
      body: SingleChildScrollView(
        child: SizedBox(
          height: tinggilayar,
          width: lebarlayar,
          child: SafeArea(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  top: tinggilayar / 40,
                  child: Image.asset('assets/logowarna.png', scale: 2.5),
                ),
                Positioned(
                  top: tinggilayar / 6,
                  child: Container(
                    padding: EdgeInsets.only(bottom: tinggilayar / 18),
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(28),
                            topRight: Radius.circular(28)),
                        color: primarycolor),
                    width: lebarlayar,
                    height: tinggilayar / 8,
                    child: Center(
                      child: Text(
                        'LOGIN',
                        style: TextStyle(
                            fontSize: tinggilayar / lebarlayar * 8,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: tinggilayar / 4,
                  child: Form(
                    key: _formkey,
                    child: Container(
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(24),
                              topRight: Radius.circular(24)),
                          color: Colors.white),
                      height: tinggilayar / 1.48,
                      width: lebarlayar,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: marginhorizontal,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: marginhorizontal),
                            child: Text(
                              'Selamat Datang',
                              style: TextStyle(
                                fontSize: tinggilayar / lebarlayar * 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: tinggilayar / 50,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: marginhorizontal),
                            child: Text(
                              'Masuk dengan menggunakan akunmu',
                              style: TextStyle(
                                  fontSize: tinggilayar / lebarlayar * 7),
                            ),
                          ),
                          SizedBox(
                            height: tinggilayar / 40,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: marginhorizontal),
                            child: TextFormField(
                              controller: _nikcontroller,
                              decoration:
                                  const InputDecoration(labelText: 'NIK'),
                            ),
                          ),
                          SizedBox(
                            height: tinggilayar / 40,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: marginhorizontal),
                            child: TextFormField(
                              controller: _passwordcontroller,
                              obscureText: !_showpassword,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _showpassword = !_showpassword;
                                      });
                                    },
                                    child: Icon(_showpassword
                                        ? Icons.visibility
                                        : Icons.visibility_off)),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: tinggilayar / 15,
                          ),
                          PrimaryButton(
                            warna: Colors.white,
                            onClick: () {
                              save();
                            },
                            teksnya: 'M A S U K',
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
