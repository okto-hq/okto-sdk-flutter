import 'package:flutter/material.dart';

class ViewWalletPage extends StatefulWidget {
  const ViewWalletPage({super.key});

  @override
  State<ViewWalletPage> createState() => _ViewWalletPageState();
}

class _ViewWalletPageState extends State<ViewWalletPage> {
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
                'View Wallet',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 30),
              ),
            ),
          ],
        ),
      ),
    );
  }
}