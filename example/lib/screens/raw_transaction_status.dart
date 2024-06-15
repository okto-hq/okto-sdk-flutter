import 'package:flutter/material.dart';

class RawTransactionStatusPage extends StatefulWidget {
  const RawTransactionStatusPage({super.key});

  @override
  State<RawTransactionStatusPage> createState() => _RawTransactionStatusPageState();
}

class _RawTransactionStatusPageState extends State<RawTransactionStatusPage> {
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
                'Raw Transaction Status',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 30),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
