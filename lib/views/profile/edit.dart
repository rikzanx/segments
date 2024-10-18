import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:segments/additionpage/detail/presensi.dart';
import 'package:segments/apicontroller.dart';
import 'package:segments/class/form_component.dart';
import 'package:segments/constant.dart';

class Edit extends StatefulWidget {
  const Edit({super.key});

  @override
  EditState createState() => EditState();
}

class EditState extends State<Edit> {
  final dateController = TextEditingController();
  final deskripsiController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final passwordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final newConfirmPasswordController = TextEditingController();

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
          "Edit Profil",
          style: TextStyle(color: primarycolor, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const InfoUser(),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Ganti Password Akun",
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
                label("Password Lama"),
                const SizedBox(
                  height: 4,
                ),
                CustomTextFormField(
                  isObsecureText: true,
                  controller: passwordController,
                  placeholder: "Masukkan Password lama",
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
                label("Password Baru"),
                const SizedBox(
                  height: 4,
                ),
                CustomTextFormField(
                  isObsecureText: true,
                  controller: newPasswordController,
                  placeholder: "Masukkan Password baru",
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
                label("Konfirmasi Password Baru"),
                const SizedBox(
                  height: 4,
                ),
                CustomTextFormField(
                  isObsecureText: true,
                  controller: newConfirmPasswordController,
                  placeholder: "Masukkan Password baru",
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
    BotToast.showLoading(
        clickClose: false, allowClick: false, crossPage: false);

    Map<String, String> body = {
      'password': passwordController.text,
      'newpassword': newPasswordController.text,
      'confirmpassword': newConfirmPasswordController.text
    };

    // print(body);
    await ApiController().changePassword(body).then((response) {
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
      if (mounted) {
        setState(() {
          data = value.data;
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
