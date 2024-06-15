import 'package:flutter/material.dart';

class LoginWithUserId extends StatefulWidget {
  const LoginWithUserId({super.key});

  @override
  State<LoginWithUserId> createState() => _LoginWithUserIdState();
}

class _LoginWithUserIdState extends State<LoginWithUserId> {
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
                  'Login with userId',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 30),
                ),
              ),
            ),
            ElevatedButton(onPressed: () async {}, child: const Text('Login with userId')),
            const SizedBox(height: 20)
          ],
        ),
      ),
    );
  }
}