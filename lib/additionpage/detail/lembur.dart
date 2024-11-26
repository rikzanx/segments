import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:segments/additionpage/detail/presensi.dart';
import 'package:segments/apicontroller.dart';
import 'package:segments/class/form_component.dart';
import 'package:segments/constant.dart';
import 'package:segments/function/route.dart';
import 'package:segments/views/laporan/pencarian_parent.dart';

Map<String, dynamic> data = {};

class Lembur extends StatefulWidget {
  const Lembur({super.key});

  @override
  LemburState createState() => LemburState();
}

class LemburState extends State<Lembur> {
  final dateController = TextEditingController();
  final deskripsiController = TextEditingController();
  final timeMulaiController = TextEditingController();
  final timeSelesaiController = TextEditingController();
  final jenisLemburController = TextEditingController();
  String totalLembur = "0";

  Future datepicker() async {
    final DateTime? tgl = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (tgl != null) {
      dateController.text = tgl.toString().substring(0, 10);
    }
  }

  Future timemulai() async {
    final TimeOfDay? timeMulai = await showTimePicker(
        context: context, initialTime: TimeOfDay.fromDateTime(DateTime.now()));
    if (!mounted) return;

    if (timeMulai != null) {
      timeMulaiController.text = timeMulai.format(context);
      // print(timeMulai.format(context));
    }
  }

  Future timeselesai() async {
    final TimeOfDay? timeSelesai = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(DateTime.now()
            .add(const Duration(hours: 1, minutes: 0, seconds: 0))));
    if (!mounted) return;

    if (timeSelesai != null) {
      timeSelesaiController.text = timeSelesai.format(context);
      // print(timeSelesai.toString());
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
          "Form Lembur SPL",
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
              "Total Lembur pada bulan ini: $totalLembur jam",
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: tinggilayar / lebarlayar * 6),
            ),
            SizedBox(
              height: tinggilayar / 40,
            ),
            const SizedBox(
              height: 25,
            ),
            myContainer(
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              label("Jenis Lembur"),
              const SizedBox(
                height: 4,
              ),
              CustomTextFormField(
                  onTap: getJenisLembur,
                  isDropdown: true,
                  isRequired: true,
                  controller: jenisLemburController,
                  placeholder: "Jenis"),
            ])),
            const SizedBox(
              height: 16,
            ),
            myContainer(Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                label("Tanggal Lembur"),
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
            myContainer(Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                label("Jam mulai lembur"),
                const SizedBox(
                  height: 4,
                ),
                CustomTextFormField(
                  controller: timeMulaiController,
                  isDatePicker: true,
                  isReadonly: true,
                  placeholder: "Pilih Jam",
                  isRequired: true,
                  onTap: timemulai,
                )
              ],
            )),
            const SizedBox(
              height: 16,
            ),
            myContainer(Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                label("Jam selesai lembur"),
                const SizedBox(
                  height: 4,
                ),
                CustomTextFormField(
                  controller: timeSelesaiController,
                  isDatePicker: true,
                  isReadonly: true,
                  placeholder: "Pilih Jam",
                  isRequired: true,
                  onTap: timeselesai,
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

  Future getJenisLembur() async {
    final result = await pindahPageCupertinoResult(
        context, const PencarianParent(tipe: "jenisLembur"));

    if (result != null) {
      if (1==1) {
        setState(() {
          jenisLemburController.text = result;
        });
      }
    }
  }

  Future save() async {
    BotToast.showLoading(clickClose: false, allowClick: false, crossPage: false);

    Map<String, String> body = {
      'nama_lengkap': data['karyawan']['nama_lengkap'].toString(),
      'user_id_penerima':
          data['karyawan']['jabatan']['atasan_1']['user']['id_user'].toString(),
      'tgl_lembur': dateController.text,
      'jenis_lembur': jenisLemburController.text,
      'mulai': timeMulaiController.text,
      'selesai': timeSelesaiController.text,
      'detail_lembur': deskripsiController.text,
    };

    // print(body);
    await ApiController().lemburSubmit(body).then((response) {
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
          totalLembur = data["total_lembur"].toString();
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
