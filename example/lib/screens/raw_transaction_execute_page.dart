import 'package:flutter/material.dart';

class RawTransactioneExecutePage extends StatefulWidget {
  const RawTransactioneExecutePage({super.key});

  @override
  State<RawTransactioneExecutePage> createState() => _RawTransactioneExecutePageState();
}

class _RawTransactioneExecutePageState extends State<RawTransactioneExecutePage> {
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
                'Raw Transaction Execute',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 30),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
