import 'package:flutter/material.dart';

class SupportedNetworksPage extends StatefulWidget {
  const SupportedNetworksPage({super.key});

  @override
  State<SupportedNetworksPage> createState() => _SupportedNetworksPageState();
}

class _SupportedNetworksPageState extends State<SupportedNetworksPage> {
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
                'Supported Networks',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 30),
              ),
            ),
          ],
        ),
      ),
    );
  }
}