import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:segments/apicontroller.dart';
import 'package:segments/constant.dart';
import 'package:segments/introslider.dart';
import 'package:segments/my_function.dart';
import 'package:segments/views/home/home.dart';
import 'package:bot_toast/bot_toast.dart';

// bool _login = false;
void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
      title: 'Segments SecurityPG',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        bottomSheetTheme:
            BottomSheetThemeData(backgroundColor: Colors.black.withOpacity(0)),
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: secondarycolor,
        primarySwatch: primarySwatchColor,
      ),
      home: const SplashScreen(title: 'Flutter Demo Home Page'),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key, required this.title});

  final String title;

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  // int _counter = 0;

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 2500)).then((value) {
      init();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    tinggilayar = MediaQuery.of(context).size.height;
    lebarlayar = MediaQuery.of(context).size.width;
    marginhorizontal = lebarlayar / 12;

    return Scaffold(
      backgroundColor: primarycolor,
      body: SizedBox(
        height: tinggilayar,
        width: lebarlayar,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Hero(
              tag: "logo",
              child: Image.asset('assets/logoputih.png', scale: 2.5)
            ),
            Positioned(
              bottom: 0,
              child: Container(
                padding: EdgeInsets.only(bottom: tinggilayar / 15),
                child: Image.asset('assets/pgputih.png', scale: 5.5),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future init() async {
    var value = await MyFunction().checkNik();
  
    if (value) {
      await ApiController().getUser().then((value) {
        if (1==1) {
          setState(() {
            if (value.status) {
              dataUser = value.data;
              Navigator.pushAndRemoveUntil(context,
                  MaterialPageRoute(builder: (context) {
                return const MainScreen();
              }), (route) => false);

              BotToast.showText(
                  text: "Login Sukses",
                  crossPage: true,
                  textStyle: const TextStyle(fontSize: 14, color: Colors.white),
                  contentColor: Colors.green);
            }
          });
        }
      });
    } else {
      Navigator.push(
          context,
          CupertinoPageRoute(
              builder: (BuildContext builder) => const IntroSlider()));
    }
  }
}
