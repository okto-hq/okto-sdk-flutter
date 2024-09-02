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
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 30),
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
                  try {
                    await okto!.authenticate(idToken: authIdController.text);
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage()));
                    // ignore: use_build_context_synchronously
                  } catch (e) {
                    print(e.toString());
                    setState(() {
                      error = e.toString();
                    });
                  }
                },
                child: const Text('Login with Id Token')),
            Text(error),
            const SizedBox(height: 20)
          ],
        ),
      ),
    );
  }
}
