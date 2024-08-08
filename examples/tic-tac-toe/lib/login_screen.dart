import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tictactoe/core/game.dart';
import 'package:tictactoe/utils/okto.dart';

class LoginWithGoogle extends StatefulWidget {
  const LoginWithGoogle({super.key});

  @override
  State<LoginWithGoogle> createState() => _LoginWithGoogleState();
}

class _LoginWithGoogleState extends State<LoginWithGoogle> {
  final GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/userinfo.profile',
      'openid',
    ],
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff5166EE),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.all(40),
                child: const Text(
                  'Welcome to\nTic Tac Toe\nPowered by Okto',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 30),
                ),
              ),
            ),
            const Text(
              'To continue, please login with your google account',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 12),
            ),
            ElevatedButton(
                onPressed: () async {
                  try {
                    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
                    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
                    if (googleAuth != null) {
                      final String? idToken = googleAuth.idToken;
                      await okto!.authenticate(idToken: idToken!);
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const GamePage()));
                    }
                    // ignore: use_build_context_synchronously
                  } catch (e) {
                    print(e);
                  }
                },
                child: const Text('Login with Google')),
            const SizedBox(height: 20)
          ],
        ),
      ),
    );
  }
}

class HomePage {
  const HomePage();
}
