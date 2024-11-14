import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../okto.dart';
import 'otp_verification_screen.dart';

class LoginWithPhone extends StatefulWidget {
  const LoginWithPhone({super.key});

  @override
  State<LoginWithPhone> createState() => _LoginWithPhoneState();
}

class _LoginWithPhoneState extends State<LoginWithPhone> {
  final phoneController = TextEditingController();

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
              'Login with phone number',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 30),
            ),
          ),
          TextFormField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(label: Text('Phone number'))),
          SizedBox(
            height: 50,
          ),
          ElevatedButton(
              onPressed: () async {
                try {
                  final response =
                      await okto!.sendPhoneOtp(phoneNumber: phoneController.text, countryCode: "IN");
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => OtpVerificationScreen(
                                email: phoneController.text,
                                token: response.token ?? "",
                              )));
                } catch (e) {
                  print(e);
                }
              },
              child: const Text('Submit')),
        ],
      )),
    );
  }
}
