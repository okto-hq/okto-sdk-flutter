import 'package:flutter/material.dart';

class SupportedTokensPage extends StatefulWidget {
  const SupportedTokensPage({super.key});

  @override
  State<SupportedTokensPage> createState() => _SupportedTokensPageState();
}

class _SupportedTokensPageState extends State<SupportedTokensPage> {
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
                'Supported Tokens',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 30),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
