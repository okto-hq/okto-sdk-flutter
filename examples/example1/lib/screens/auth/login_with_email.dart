import 'package:example/screens/auth/otp_verification_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../okto.dart';

class LoginWithEmail extends StatefulWidget {
  const LoginWithEmail({super.key});

  @override
  State<LoginWithEmail> createState() => _LoginWithEmailState();
}

class _LoginWithEmailState extends State<LoginWithEmail> {
  final emailIdController = TextEditingController();

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
                'Login with userId',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 30),
              ),
            ),
            TextField(
                controller: emailIdController,
                decoration: const InputDecoration(label: Text('Email Id'))),
            SizedBox(
              height: 50,
            ),
            ElevatedButton(
                onPressed: () async {
                  try {
                    final response =
                        await okto!.sendEmailOtp(email: emailIdController.text);
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OtpVerificationScreen(
                              phoneOrEmail: emailIdController.text,
                              token: response.token ?? "",
                              authType: "EMAIL",
                            )));
                  } catch (e) {
                    print(e);
                  }
                },
                child: const Text('Submit')
            ),
          ],
        )));
  }
}
