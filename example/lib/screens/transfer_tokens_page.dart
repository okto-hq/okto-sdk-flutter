import 'package:flutter/material.dart';

class TransferTokensPage extends StatefulWidget {
  const TransferTokensPage({super.key});

  @override
  State<TransferTokensPage> createState() => _TransferTokensPageState();
}

class _TransferTokensPageState extends State<TransferTokensPage> {
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
                'Transfer Tokens',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 30),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
