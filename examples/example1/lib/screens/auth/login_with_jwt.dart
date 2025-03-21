import 'package:example/okto.dart';
import 'package:example/screens/home/home_page.dart';
import 'package:flutter/material.dart';

class LoginWithJwt extends StatefulWidget {
  const LoginWithJwt({super.key});

  @override
  State<LoginWithJwt> createState() => _LoginWithJwtState();
}

class _LoginWithJwtState extends State<LoginWithJwt> {
  final userIdController = TextEditingController();
  final jwtTokenController = TextEditingController();
  bool _isLoading = false;

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
                  'Login with JWT token',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 30),
                ),
              ),
            ),
            // TextField(
            //   controller: userIdController,
            //   decoration: const InputDecoration(label: Text('User Id')),
            // ),
            TextField(
              controller: jwtTokenController,
              decoration: const InputDecoration(label: Text('Enter JWT')),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
                onPressed: () async {
                  setState(() {
                    _isLoading = true;
                  });
                  try {
                    await okto!.authenticateWithJwt(jwtToken: jwtTokenController.text);
                    setState(() {
                      _isLoading = false;
                    });
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage()));
                  } catch (e) {
                    print(e);
                    setState(() {
                      _isLoading = false;
                    });
                  }
                },
                child: const Text('Login with JWT')),
            _isLoading ? const CircularProgressIndicator() : const SizedBox(),
            const SizedBox(height: 20)
          ],
        ),
      ),
    );
  }
}
