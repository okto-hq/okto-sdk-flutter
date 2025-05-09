import 'dart:async';

import 'package:example/screens/auth/otp_verification_screen.dart';
import 'package:example/screens/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:okto_sdk/okto_flutter_sdk.dart';

import '../../okto.dart';

class LoginWithWhatsApp extends StatefulWidget {
  const LoginWithWhatsApp({super.key});

  @override
  State<LoginWithWhatsApp> createState() => _LoginWithWhatsAppState();
}

class _LoginWithWhatsAppState extends State<LoginWithWhatsApp> {
  final phoneController = TextEditingController();
  final otpController = TextEditingController();
  Completer<String>? _otpCompleter;

  bool _isLoading = false;
  String? _token;

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
                'Login with Whatsapp',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 30),
              ),
            ),
            TextField(
                controller: phoneController,
                decoration: const InputDecoration(label: Text('Phone No.'))),
            const SizedBox(
              height: 20,
            ),
            TextField(
                controller: otpController,
                decoration: const InputDecoration(label: Text('OTP'))),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
                onPressed: () async {
                  try {
                    final auth = await OktoSdk().authenticateViaWhatsApp(
                      phone: phoneController.text.trim(),
                      onOtpSent: (token) {
                        _token = token;
                      },
                    );
                    print("AUTH SUCCESS :: $auth");
                  } catch (e) {
                    print("AUTH ERROR : $e");
                  }
                },
                child: const Text('SEND OTP')
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () async {
                  try {
                    if (_token == null) {
                      throw "Token is null";
                    }
                    final auth = await OktoSdk().verifyWhatsAppOtp(
                      otp: otpController.text,
                      token: _token ?? ''
                    );
                    final response = await OktoSdk().loginWithIdTokenV2(idToken: auth, authProvider: "okto");
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage()));
                  } catch (e) {
                    print(e);
                  }
                },
                child: const Text('VERIFY OTP')
            ),

            _isLoading ? const CircularProgressIndicator() : const SizedBox.shrink()
          ],
        )));
  }
}
