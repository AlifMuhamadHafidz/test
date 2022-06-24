import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:projek_fiinal/constants.dart';
import 'package:projek_fiinal/register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  static String route = "login_screen";

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: [
            SafeArea(
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Login',
                  style: titleText20,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Image.asset('assets/login_image.png'),
            SizedBox(
              height: 35,
            ),
            Text(
              'Selamat Datang',
              style: titleText22,
            ),
            Text(
              'Selamat Datang di Aplikasi Widya Edu Aplikasi Latihan dan Konsultasi Soal',
              textAlign: TextAlign.center,
              style: subtitleText14,
            ),
            Spacer(),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                          side: BorderSide(
                            color: Color(0xFF01B1AF),
                          )),
                      fixedSize: Size(double.infinity, 50)),
                  onPressed: () async {
                    await signInWithGoogle();

                    final user = FirebaseAuth.instance.currentUser;
                    if (user != null) {
                      Navigator.pushNamed(context, RegisterPage.route);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Gagal Masuk'),
                        duration: Duration(seconds: 2),
                      ));
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/google_icon.png'),
                      SizedBox(
                        width: 12,
                      ),
                      Text(
                        'Masuk dengan Google',
                        style: googleText,
                      ),
                    ],
                  )),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      fixedSize: Size(double.infinity, 50)),
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/apple_icon.png'),
                      SizedBox(
                        width: 12,
                      ),
                      Text(
                        'Masuk dengan Apple ID',
                        style: appleText,
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
