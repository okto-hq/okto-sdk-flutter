import 'package:example/okto.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:okto_sdk/network/models/client/auth_token_model.dart';
import 'package:pinput/pinput.dart';

import '../home/home_page.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String phoneOrEmail;
  final String token;
  final String authType;

  const OtpVerificationScreen(
      {super.key,
      required this.phoneOrEmail,
      required this.token,
      required this.authType});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final TextEditingController otpController = TextEditingController();

  String _message = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Verify the OTP",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 32,
          ),
          const Text(
            "Enter the OTP",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          const SizedBox(
            height: 52,
          ),
          Pinput(
            controller: otpController,
            length: 6,
            onChanged: (value) {
              verifyOTP(value);
            },
            focusedPinTheme: PinTheme(
              margin: const EdgeInsets.symmetric(horizontal: 6),
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blueAccent),
              ),
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            defaultPinTheme: PinTheme(
              margin: const EdgeInsets.symmetric(horizontal: 6),
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.blueAccent.shade400,
                ),
              ),
              textStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.blueAccent.shade400,
              ),
            ),
          ),
          const SizedBox(
            height: 52,
          ),
          Text(
            _message,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          )
        ],
      ),
    );
  }

  Future<void> verifyOTP(String otp) async {
    if (otp.length != 6) return;
    try {
      if(widget.authType == "PHONE") {
        AuthTokenData? response = await okto!
            .verifyPhoneOtp(phoneNumber: widget.phoneOrEmail, otp: otp, token: widget.token);
      } else if(widget.authType == "EMAIL") {
        AuthTokenData? response = await okto!
            .verifyEmailOtp(emailId: widget.phoneOrEmail, otp: otp, token: widget.token);
      }
      setState(() {
        _message = "Verified successfully";
      });
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage()));
    } catch (e) {
      debugPrint("Error: ${e}");
      setState(() {
        _message = "Error: ${e}";
      });
    }
  }
}
