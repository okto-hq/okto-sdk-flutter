import 'package:flutter/material.dart';

class OrderDetailsNftPage extends StatefulWidget {
  const OrderDetailsNftPage({super.key});

  @override
  State<OrderDetailsNftPage> createState() => _OrderDetailsNftPageState();
}

class _OrderDetailsNftPageState extends State<OrderDetailsNftPage> {
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
                'Order Details NFT',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 30),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
