import 'package:flutter/material.dart';

class TransferNftPage extends StatefulWidget {
  const TransferNftPage({super.key});

  @override
  State<TransferNftPage> createState() => _TransferNftPageState();
}

class _TransferNftPageState extends State<TransferNftPage> {
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
                'Transfer NFT',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 30),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
