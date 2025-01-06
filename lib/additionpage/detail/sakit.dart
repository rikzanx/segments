import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:segments/additionpage/detail/presensi.dart';
import 'package:segments/class/public_function.dart';
import 'package:segments/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:segments/class/form_component.dart';
import 'package:image_picker/image_picker.dart';
import 'package:segments/apicontroller.dart';

Map<String, dynamic> data = {};

class Sakit extends StatefulWidget {
  const Sakit({super.key});

  @override
  SakitState createState() => SakitState();
}

class SakitState extends State<Sakit> {
  final deskripsiController = TextEditingController();
  final dateController = TextEditingController();
  String sisaCuti = "0";

  List dataFoto = [];
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFileList;
  // ignore: unused_field
  dynamic _pickImageError;

  Future datepicker() async {
    final DateTime? tgl = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
    );
    if (tgl != null) {
      dateController.text = tgl.toString().substring(0, 10);
    }
  }

  Future getImage() async {
    try {
      final pickedFileList = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 20,
      );
      setState(() {
        _imageFileList = pickedFileList;
      });

      // print(_imageFileList);
    } catch (e) {
      setState(() {
        _pickImageError = e;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          "Form Sakit",
          style: TextStyle(color: primarycolor, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            InfoUser(dataUser: data,),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Sisa absen pada bulan ini: $sisaCuti",
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: tinggilayar / lebarlayar * 6),
            ),
            SizedBox(
              height: tinggilayar / 40,
            ),
            myContainer(Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                label("Tanggal Absen"),
                const SizedBox(
                  height: 4,
                ),
                CustomTextFormField(
                  controller: dateController,
                  isDatePicker: true,
                  isReadonly: true,
                  placeholder: "Pilih Tanggal",
                  isRequired: true,
                  onTap: datepicker,
                )
              ],
            )),
            const SizedBox(
              height: 16,
            ),
            myContainer(
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  label("Deskripsi"),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextFormField(
                    isLongText: true,
                    controller: deskripsiController,
                    placeholder: "Masukkan Deskripsi",
                    isRequired: true,
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            myContainer(
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  label("Foto Bukti Sakit"),
                  IconButton(
                      onPressed: () {
                        getImage();
                      },
                      icon: const Icon(CupertinoIcons.photo_camera))
                ],
              ),
              const SizedBox(
                height: 4,
              ),
              _imageFileList != null
                  ? Image.file(File(_imageFileList!.path))
                  : Container()
            ])),
            const SizedBox(
              height: 32,
            ),
            PrimaryButton(
              warna: Colors.white,
              onClick: () {
                save();
              },
              teksnya: 'K I R I M',
            ),
          ],
        ),
      ),
    );
  }

  Widget label(String label) {
    return Text(
      label,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
    );
  }

  Widget myContainer(Widget append) {
    return Material(
      borderRadius: BorderRadius.circular(16),
      color: Colors.white,
      child: Padding(padding: const EdgeInsets.all(16), child: append),
    );
  }

  Future save() async {
    String base64 =
        await PublicFunction().convertImageToBase64(File(_imageFileList!.path));

    BotToast.showLoading(clickClose: false, allowClick: false, crossPage: false);

    Map<String, String> body = {
      'nama_lengkap': data['karyawan']['nama_lengkap'].toString(),
      'user_id_penerima':
          data['karyawan']['jabatan']['atasan_1']['user']['id_user'].toString(),
      'tgl_absen': dateController.text,
      'tipe_absen': "Sakit",
      'detail_absen': deskripsiController.text,
      'foto': base64
    };

    // print(body);
    await ApiController().sakitSubmit(body).then((response) {
      if (!mounted) return;
      if (response.data['success']) {
        BotToast.closeAllLoading();
        Navigator.pop(context);
        BotToast.showText(
            text: response.data['message'].toString(),
            crossPage: true,
            textStyle: const TextStyle(fontSize: 14, color: Colors.white),
            contentColor: Colors.green);
      } else {
        BotToast.closeAllLoading();
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error'),
              content: Text(response.data['message'].toString()),
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

  Future init() async {
    await ApiController().getUser().then((value) {
      if (1==1) {
        setState(() {
          data = value.data;
          sisaCuti = data["sisa_cuti"].toString();
          // print("data=$data");
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
