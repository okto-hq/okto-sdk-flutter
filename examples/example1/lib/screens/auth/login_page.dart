import 'package:example/screens/auth/login_with_email.dart';
import 'package:example/screens/auth/login_with_id_token.dart';
import 'package:example/screens/auth/login_with_userid.dart';
import 'package:example/screens/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../okto.dart';
import 'login_with_phone.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Note
  // Okto sdk does not handle JWT generation or Google Sign in.
  // You have to implement any of those methods on your own.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff5166EE),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.all(40),
              child: const Text(
                'Welcome to okto',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 30),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginWithIdToken()));
                },
                child: const Text('Login with Id Token')),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginWithUserId()));
                },
                child: const Text('Login with User Id')),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginWithEmail()));
                },
                child: const Text('Login with Email')),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginWithPhone()));
                },
                child: const Text('Login with Phone')),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () async {
                  await okto!.openOnboarding(
                      context: context,
                      gAuthCallback: _loginWithGoogle,
                      onLoginSuccess: () {
                        Future.delayed(const Duration(seconds: 5), () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomePage()));
                        });
                      });
                },
                child: const Text('Onboarding')),
            const SizedBox(
              height: 52,
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> checkLoginStatus() async {
    return okto!.isLoggedIn();
  }

  Future<String> _loginWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/userinfo.profile',
        'openid',
      ],
      forceCodeForRefreshToken: true,
    );
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
      if (googleAuth == null) return "";
      return googleAuth.idToken ?? "";
    } catch (e) {
      debugPrint("GAuth Error occurred: $e");
      return "";
    }
  }
}
