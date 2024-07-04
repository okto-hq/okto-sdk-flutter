import 'package:example/okto.dart';
import 'package:example/screens/home/home_page.dart';
import 'package:example/utils/global_mode.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:okto_flutter_sdk/okto_flutter_sdk.dart';

class LoginWithGoogle extends StatefulWidget {
  const LoginWithGoogle({super.key});

  @override
  State<LoginWithGoogle> createState() => _LoginWithGoogleState();
}

class _LoginWithGoogleState extends State<LoginWithGoogle> {
  Globals globals1 = Globals.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/userinfo.profile',
      'openid',
    ],
    forceCodeForRefreshToken: true,
  );
  String error = '';
  @override
  void initState() {
    super.initState();
    print(globals1.getApiKey());
  }

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
                  'Login with google',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 30),
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  try {
                    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
                    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
                    if (googleAuth != null) {
                      final String? idToken = googleAuth.idToken;

                      final res = await okto!.authenticate(idToken: idToken!);
                      if (res is AuthenticationResponse) {
                        final res1 = await okto!.setPin(pin: '123456');
                      }
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage()));
                    }
                    // ignore: use_build_context_synchronously
                  } catch (e) {
                    print(e.toString());
                    setState(() {
                      error = e.toString();
                    });
                  }
                },
                child: const Text('Login with Google')),
            Text(error),
            const SizedBox(height: 20)
          ],
        ),
      ),
    );
  }
}
