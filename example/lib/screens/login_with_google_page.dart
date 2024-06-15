import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoginWithGoogle extends StatefulWidget {
  const LoginWithGoogle({super.key});

  @override
  State<LoginWithGoogle> createState() => _LoginWithGoogleState();
}

class _LoginWithGoogleState extends State<LoginWithGoogle> {
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
            ElevatedButton(onPressed: () async {}, child: const Text('Login with Google')),
            const SizedBox(height: 20)
          ],
        ),
      ),
    );
  }
}
