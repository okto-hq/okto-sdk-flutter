import 'package:example/okto.dart';
import 'package:example/screens/home/home_page.dart';
import 'package:flutter/material.dart';

class LoginWithUserId extends StatefulWidget {
  const LoginWithUserId({super.key});

  @override
  State<LoginWithUserId> createState() => _LoginWithUserIdState();
}

class _LoginWithUserIdState extends State<LoginWithUserId> {
  final userIdController = TextEditingController();
  final jwtTokenController = TextEditingController();

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
            TextField(
              controller: userIdController,
              decoration: const InputDecoration(label: Text('User Id')),
            ),
            TextField(
              controller: jwtTokenController,
              decoration: const InputDecoration(label: Text('Enter JWT')),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
                onPressed: () async {
                  try {
                    await okto!.authenticateWithUserId(userId: userIdController.text, jwtToken: jwtTokenController.text);
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
