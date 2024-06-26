import 'package:example/okto.dart';
import 'package:example/screens/home/home_page.dart';
import 'package:flutter/material.dart';

class LoginWithUserId extends StatefulWidget {
  const LoginWithUserId({super.key});

  @override
  State<LoginWithUserId> createState() => _LoginWithUserIdState();
}

class _LoginWithUserIdState extends State<LoginWithUserId> {
  final userId = 'YOUR_USER_ID'; // Replace this with your user_id
  final jwtToken = 'YOUR_JWT_TOKEN';

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
            ElevatedButton(
                onPressed: () async {
                  try {
                    await okto.authenticateWithUserId(userId: userId, jwtToken: jwtToken);
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage()));
                  } catch (e) {
                    print(e);
                  }
                },
                child: const Text('Login with userId')),
            const SizedBox(height: 20)
          ],
        ),
      ),
    );
  }
}
