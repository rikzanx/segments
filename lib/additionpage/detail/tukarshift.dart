import 'package:flutter/material.dart';
import 'package:segments/additionpage/detail/presensi.dart';
import 'package:segments/apicontroller.dart';
import 'package:segments/class/form_component.dart';
import 'package:segments/constant.dart';

class TukarShift extends StatefulWidget {
  const TukarShift({super.key});

  @override
  TukarShiftState createState() => TukarShiftState();
}

class TukarShiftState extends State<TukarShift> {
  final deskripsiController = TextEditingController();

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
          "Form Tukar Shift",
          style: TextStyle(color: primarycolor, fontWeight: FontWeight.bold),
        ),
      ),
      body: SizedBox(
        height: tinggilayar,
        width: lebarlayar,
        child: Column(
          children: [
            InfoUser(),
            const SizedBox(
              height: 20,
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
            const Spacer(),
            PrimaryButton(
              warna: Colors.white,
              onClick: () {},
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

  Future init() async {
    await ApiController().getUser().then((value) {
      if (1==1) {
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
