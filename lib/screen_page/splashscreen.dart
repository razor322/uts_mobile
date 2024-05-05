import 'package:flutter/material.dart';
import 'dart:async';

import 'package:uts_mobile2_app/screen_page/login.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => LoginScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("./assets/bg.png"),
            fit: BoxFit.cover,
            alignment: Alignment.bottomCenter, // Menentukan posisi gambar latar
          ),
        ),
        child: Center(
          child: Image.asset("./assets/logo1.png"),
        ),
      ),
    );
  }
}
