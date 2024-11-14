import 'package:example/okto.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class OtpVerificationScreen extends StatefulWidget {

  final String email;
  final String token;

  const OtpVerificationScreen(
      {super.key, required this.email, required this.token});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {

  final TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Verify the OTP"),
      ),
      body: Column(
        children: [
          Text("Enter the OTP"),
          SizedBox(height: 52,),
          Pinput(
            controller: otpController,
            length: 6,
            onChanged: (value) {
              verifyOTP(value);
            },
            focusedPinTheme: PinTheme(
              margin: EdgeInsets.symmetric(horizontal: 6),
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                    color: Colors.blueAccent),
              ),
              textStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            defaultPinTheme: PinTheme(
              margin: EdgeInsets.symmetric(horizontal: 6),
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.green.shade400,
                ),
              ),
              textStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.green.shade400,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void verifyOTP(String otp) {
    try {
      final response = okto!.verifyEmailOtp(email: widget.email, otp: otp, token: widget.token);
      debugPrint("Response: ${response}");
    } catch (e) {
      debugPrint("Error: ${e}");
    }
  }
}
