import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:segments/additionpage/detail/presensi.dart';
import 'package:segments/apicontroller.dart';
import 'package:segments/class/form_component.dart';
import 'package:segments/constant.dart';

Map<String, dynamic> data = {};

class EditDataDiri extends StatefulWidget {
  const EditDataDiri({super.key});

  @override
  EditDataDiriState createState() => EditDataDiriState();
}

class EditDataDiriState extends State<EditDataDiri> {
  final dateController = TextEditingController();
  final deskripsiController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final noKontrakController = TextEditingController();
  final namaLengkapController = TextEditingController();
  final ptController = TextEditingController();
  final noKibController = TextEditingController();
  final tglLahirController = TextEditingController();
  final kompetensiGadaController = TextEditingController();
  final noRegController = TextEditingController();
  final noKtaController = TextEditingController();
  final noIjazahController = TextEditingController();
  final tglJatuhTempoGadaController = TextEditingController();
  final mulaiBekerjaController = TextEditingController();


  final noKtpController = TextEditingController();
  final noHpController = TextEditingController();
  final kabupatenController = TextEditingController();
  final kecamatanController = TextEditingController();
  final desaController = TextEditingController();
  final rtRwController = TextEditingController();
  final alamatController = TextEditingController();

  Future datepicker() async {
    final DateTime? tanggalLahir = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
    );
    if (tanggalLahir != null) {
      tglLahirController.text = tanggalLahir.toString().substring(0, 10);
    }
  }

  Future datepickerJatuhTempoGada() async {
    final DateTime? tanggalJatuhTempoGada = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
    );
    if (tanggalJatuhTempoGada != null) {
      tglJatuhTempoGadaController.text = tanggalJatuhTempoGada.toString().substring(0, 10);
    }
  }

  Future datepickerMulaiBekerja() async {
    final DateTime? tanggalMulaiBekerja = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
    );
    if (tanggalMulaiBekerja != null) {
      mulaiBekerjaController.text = tanggalMulaiBekerja.toString().substring(0, 10);
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
          "Edit Data Diri",
          style: TextStyle(color: primarycolor, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            InfoUser(dataUser: data,),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Edit Data Diri",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: primarycolor,
                  fontSize: tinggilayar / lebarlayar * 8),
            ),
            const SizedBox(
              height: 10,
            ),
            myContainer(Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                label("No Kontrak"),
                const SizedBox(
                  height: 4,
                ),
                CustomTextFormField(
                  isObsecureText: true,
                  controller: noKontrakController,
                  placeholder: "Masukkan No Kontrak",
                  isRequired: true,
                )
              ],
            )),
            const SizedBox(
              height: 16,
            ),
            myContainer(Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                label("Nama Lengkap"),
                const SizedBox(
                  height: 4,
                ),
                CustomTextFormField(
                  isObsecureText: true,
                  controller: namaLengkapController,
                  placeholder: "Masukkan Nama Lengkap",
                  isRequired: true,
                )
              ],
            )),
            const SizedBox(
              height: 16,
            ),
            myContainer(Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                label("PT"),
                const SizedBox(
                  height: 4,
                ),
                CustomTextFormField(
                  isObsecureText: true,
                  controller: ptController,
                  placeholder: "Masukkan PT",
                  isRequired: true,
                )
              ],
            )),
            const SizedBox(
              height: 16,
            ),
            myContainer(Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                label("No KIB"),
                const SizedBox(
                  height: 4,
                ),
                CustomTextFormField(
                  isObsecureText: true,
                  controller: noKibController,
                  placeholder: "Masukkan No KIB",
                  isRequired: true,
                )
              ],
            )),
            const SizedBox(
              height: 16,
            ),
            myContainer(Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                label("Tanggal Lahir"),
                const SizedBox(
                  height: 4,
                ),
                CustomTextFormField(
                  controller: tglLahirController,
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
                label("Kompetensi Gada"),
                const SizedBox(
                  height: 4,
                ),
                CustomTextFormField(
                  isObsecureText: true,
                  controller: kompetensiGadaController,
                  placeholder: "Masukkan Kompetensi Gada",
                  isRequired: true,
                )
              ],
            )),
            const SizedBox(
              height: 16,
            ),
            myContainer(Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                label("No Reg"),
                const SizedBox(
                  height: 4,
                ),
                CustomTextFormField(
                  isObsecureText: true,
                  controller: noRegController,
                  placeholder: "Masukkan No Reg",
                  isRequired: true,
                )
              ],
            )),
            const SizedBox(
              height: 16,
            ),
            myContainer(Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                label("No KTA"),
                const SizedBox(
                  height: 4,
                ),
                CustomTextFormField(
                  isObsecureText: true,
                  controller: noKtaController,
                  placeholder: "Masukkan No KTA",
                  isRequired: true,
                )
              ],
            )),
            const SizedBox(
              height: 16,
            ),
            myContainer(Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                label("No Ijazah"),
                const SizedBox(
                  height: 4,
                ),
                CustomTextFormField(
                  isObsecureText: true,
                  controller: noIjazahController,
                  placeholder: "Masukkan No Ijazah",
                  isRequired: true,
                )
              ],
            )),
            const SizedBox(
              height: 16,
            ),
            myContainer(Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                label("Tanggal Jatuh Tempo gada"),
                const SizedBox(
                  height: 4,
                ),
                CustomTextFormField(
                  controller: tglJatuhTempoGadaController,
                  isDatePicker: true,
                  isReadonly: true,
                  placeholder: "Pilih Tanggal",
                  isRequired: true,
                  onTap: datepickerJatuhTempoGada,
                )
              ],
            )),
            const SizedBox(
              height: 16,
            ),
            myContainer(Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                label("Mulai Bekerja"),
                const SizedBox(
                  height: 4,
                ),
                CustomTextFormField(
                  controller: mulaiBekerjaController,
                  isDatePicker: true,
                  isReadonly: true,
                  placeholder: "Pilih Tanggal",
                  isRequired: true,
                  onTap: datepickerMulaiBekerja,
                )
              ],
            )),
            const SizedBox(
              height: 16,
            ),




            myContainer(Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                label("No KTP"),
                const SizedBox(
                  height: 4,
                ),
                CustomTextFormField(
                  isObsecureText: true,
                  controller: noKtpController,
                  placeholder: "Masukkan No KTP",
                  isRequired: true,
                )
              ],
            )),
            const SizedBox(
              height: 16,
            ),
            myContainer(Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                label("No HP"),
                const SizedBox(
                  height: 4,
                ),
                CustomTextFormField(
                  isObsecureText: true,
                  controller: noHpController,
                  placeholder: "Masukkan No HP",
                  isRequired: true,
                )
              ],
            )),
            const SizedBox(
              height: 16,
            ),
            myContainer(Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                label("Kabupaten"),
                const SizedBox(
                  height: 4,
                ),
                CustomTextFormField(
                  isObsecureText: true,
                  controller: kabupatenController,
                  placeholder: "Masukkan Kabupaten",
                  isRequired: true,
                )
              ],
            )),
            const SizedBox(
              height: 16,
            ),
            myContainer(Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                label("Kecamatan"),
                const SizedBox(
                  height: 4,
                ),
                CustomTextFormField(
                  isObsecureText: true,
                  controller: kecamatanController,
                  placeholder: "Masukkan Kecamatan",
                  isRequired: true,
                )
              ],
            )),
            const SizedBox(
              height: 16,
            ),
            myContainer(Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                label("Kelurahan / Desa"),
                const SizedBox(
                  height: 4,
                ),
                CustomTextFormField(
                  isObsecureText: true,
                  controller: desaController,
                  placeholder: "Masukkan Kecamatan/Desa",
                  isRequired: true,
                )
              ],
            )),
            const SizedBox(
              height: 16,
            ),
            myContainer(Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                label("RT/RW"),
                const SizedBox(
                  height: 4,
                ),
                CustomTextFormField(
                  isObsecureText: true,
                  controller: rtRwController,
                  placeholder: "Masukkan RT/RW",
                  isRequired: true,
                )
              ],
            )),
            const SizedBox(
              height: 16,
            ),
            myContainer(Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                label("Alamat"),
                const SizedBox(
                  height: 4,
                ),
                CustomTextFormField(
                  isObsecureText: true,
                  controller: alamatController,
                  placeholder: "Masukkan Alamat",
                  isRequired: true,
                )
              ],
            )),
            const SizedBox(
              height: 16,
            ),
            PrimaryButton(
              warna: Colors.white,
              onClick: () {
                // // ignore: unrelated_type_equality_checks
                // if(oldPasswordController == ""){
                //   // print("ok");
                // }
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
    BotToast.showLoading(clickClose: false, allowClick: false, crossPage: false);

    Map<String, String> body = {
      'no_kontrak' : noKontrakController.text,
      'nama_lengkap' : namaLengkapController.text,
      'pt' : ptController.text,
      'no_kib' : noKibController.text,
      'tgl_lahir' : tglLahirController.text.toString(),
      'kompetensi_gada' : kompetensiGadaController.text,
      'no_reg' : noRegController.text,
      'no_kta' : noKtaController.text,
      'no_ijazah' : noIjazahController.text,
      'tgl_jatuhtempo_gada' : tglJatuhTempoGadaController.text.toString(),
      'mulai_bekerja' : mulaiBekerjaController.text.toString(),
      'no_ktp' : noKtpController.text,
      'no_hp' : noHpController.text,
      'kabupaten' : kabupatenController.text,
      'kecamatan' : kecamatanController.text,
      'desa' : desaController.text,
      'rtrw' : rtRwController.text,
      'alamat' : alamatController.text,
    };

    // print(body);
    await ApiController().changeDataDiri(body).then((response) {
      if (!mounted) return;
      if(response == null || response.data == null){
        BotToast.closeAllLoading();
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error'),
              content: Text("Terjadi Kesalahan"),
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
      else if (response.data['success']) {
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
          noKontrakController.text = value.data['karyawan']['no_kontrak'] ?? '';
          namaLengkapController.text = value.data['karyawan']['nama_lengkap'] ?? '';
          ptController.text = value.data['karyawan']['pt'] ?? '';
          noKibController.text = value.data['karyawan']['no_kib'] ?? '';
          kompetensiGadaController.text = value.data['karyawan']['kompetensi_gada'] ?? '';
          noRegController.text = value.data['karyawan']['no_reg'] ?? '';
          noKtaController.text = value.data['karyawan']['no_kta'] ?? '';
          noIjazahController.text = value.data['karyawan']['no_ijazah'] ?? '';
          if(value.data != null && value.data['karyawan']['tgl_lahir'] != null)
          {
            tglLahirController.text = value.data['karyawan']['tgl_lahir'];
          }
          if(value.data != null && value.data['karyawan']['tgl_jatuhtempo_gada'] != null)
          {
            tglJatuhTempoGadaController.text = value.data['karyawan']['tgl_jatuhtempo_gada'];
          }
          if(value.data != null && value.data['karyawan']['mulai_bekerja'] != null)
          {
            mulaiBekerjaController.text = value.data['karyawan']['mulai_bekerja'];
          }



          noKtpController.text = value.data['karyawan']['no_ktp'] ?? '';
          noHpController.text = value.data['karyawan']['no_hp'] ?? '';
          kabupatenController.text = value.data['karyawan']['kabupaten'] ?? '';
          kecamatanController.text = value.data['karyawan']['kecamatan'] ?? '';
          desaController.text = value.data['karyawan']['desa'] ?? '';
          rtRwController.text = value.data['karyawan']['rtrw'] ?? '';
          alamatController.text = value.data['karyawan']['alamat'] ?? '';
          data = value.data;
          print(data);
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
