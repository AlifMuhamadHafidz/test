import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projek_fiinal/constants.dart';
import 'package:projek_fiinal/login_page.dart';
import 'package:projek_fiinal/main/latihan_soal/home_page.dart';
import 'package:projek_fiinal/main_page.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);
  static String route = "splash_screen";

  @override
  Widget build(BuildContext context) {
    Timer(
      const Duration(seconds: 5),
      () {
        final user = FirebaseAuth.instance.currentUser;

        if (user != null) {
          // TODO redirect to register or home
          Navigator.of(context).pushReplacementNamed(MainPage.route);
        }
        Navigator.of(context).pushReplacementNamed(LoginPage.route);
      },
    );

    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: Container(
          width: 159,
          height: 30,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/splash_image.png',
              ),
            ),
          ),
        ),
      ),
    );
  }
}
