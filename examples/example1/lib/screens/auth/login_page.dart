import 'package:example/screens/auth/login_with_google_page.dart';
import 'package:example/screens/auth/login_with_id_token.dart';
import 'package:example/screens/auth/login_with_userid.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  // Note
  // Okto sdk does not handle JWT generation or Google Sign in.
  // You have to implement any of those methods on your own.

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
                  'Welcome to okto',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 30),
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginWithIdToken()));
                },
                child: const Text('Login with Id Token')),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginWithGoogle()));
                },
                child: const Text('Login with Google')),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginWithUserId()));
                },
                child: const Text('Login with User Id')),
            const SizedBox(height: 20)
          ],
        ),
      ),
    );
  }
}
