import 'package:example/okto.dart';
import 'package:example/screens/home/home_page.dart';
import 'package:flutter/material.dart';

class LoginWithGoogle extends StatefulWidget {
  const LoginWithGoogle({super.key});

  @override
  State<LoginWithGoogle> createState() => _LoginWithGoogleState();
}

class _LoginWithGoogleState extends State<LoginWithGoogle> {
  final googleIdToken = 'ID_TOKEN_RECEIVED_FROM_GOOGLE_SIGN_IN'; // Replace this with your goggle OAuth2 id_token

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
                    await okto.authenticate(idToken: googleIdToken);
                    await okto.setPin(pin: 'USER_PIN'); // The user is required to set a pin after the first login
                    // ignore: use_build_context_synchronously
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage()));
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
