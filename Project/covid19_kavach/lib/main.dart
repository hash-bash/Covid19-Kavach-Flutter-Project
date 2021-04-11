import 'dart:async';

import 'package:covid19_kavach/pages/home_navigation/HomePage.dart';
import 'package:covid19_kavach/pages/login_user/LoginUser.dart';
import 'package:covid19_kavach/utilities/SizeConfig.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            SizeConfig().init(constraints, orientation);
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Covid19 Kavach',
              home: SplashPage(),
            );
          },
        );
      },
    );
  }
}

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration(seconds: 3),
      () {
        decideWhichPageToGo();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 150,
          child: Hero(
            tag: "ic_covid",
            child: Image.asset('images/main_icon.png'),
          ),
        ),
      ),
    );
  }

  void decideWhichPageToGo() async {
    // SharedPreferences preferences = await SharedPreferences.getInstance();
    // if (preferences.containsKey('userCountry')) {}
    FirebaseAuth.instance.authStateChanges().listen((User user) {
      if (user == null) {
        gotoLoginPage();
      } else {
        gotoHomePage();
      }
    });
  }

  void gotoHomePage() {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 800),
        pageBuilder: (
          _,
          __,
          ___,
        ) =>
            HomePage(),
      ),
    );
  }

  void gotoLoginPage() {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 800),
          pageBuilder: (
            _,
            __,
            ___,
          ) =>
              LoginScreen()),
      // OneMoreStep("nameText", "ageText", "phoneText", "emailText", "genderText", "addressText", "passwordText")),
    );
  }
}
