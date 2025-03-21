import 'dart:convert';

import 'package:example/okto.dart';
import 'package:example/screens/home/home_page.dart';
import 'package:example/utils/global_mode.dart';
import 'package:flutter/material.dart';

class LoginWithIdToken extends StatefulWidget {
  const LoginWithIdToken({super.key});

  @override
  State<LoginWithIdToken> createState() => _LoginWithIdTokenState();
}

class _LoginWithIdTokenState extends State<LoginWithIdToken> {
  final authIdController = TextEditingController();
  Globals globals1 = Globals.instance;
  String error = '';
  String responseData = '';
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    print(globals1.getApiKey());
  }

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
                  'Login with Id Token',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 30),
                ),
              ),
            ),
            TextField(
              controller: authIdController,
              decoration: const InputDecoration(label: Text('Id Token')),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
                onPressed: () async {
                  setState(() {
                    isLoading = true;
                  });
                  try {
                    okto!
                        .authenticateV2(
                            idToken: authIdController.text,
                            authProvider: "google")
                        .then((response) {
                      debugPrint(
                          "Authentication response: ${response.toJson()}");
                      isLoading = false;
                      responseData = jsonEncode(response.toJson());
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomePage()));
                    });
                    // ignore: use_build_context_synchronously
                  } catch (e) {
                    isLoading = false;
                    print(e.toString());
                    setState(() {
                      error = e.toString();
                    });
                  }
                },
                child: const Text('Login with Id Token')),
            isLoading
                ? const CircularProgressIndicator(color: Colors.white)
                : Text(error.isNotEmpty ? error : responseData),
            const SizedBox(height: 20)
          ],
        ),
      ),
    );
  }
}
