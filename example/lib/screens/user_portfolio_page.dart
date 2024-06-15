import 'package:flutter/material.dart';

class UserPortfolioPage extends StatefulWidget {
  const UserPortfolioPage({super.key});

  @override
  State<UserPortfolioPage> createState() => _UserPortfolioPageState();
}

class _UserPortfolioPageState extends State<UserPortfolioPage> {
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
                'User Portfolio',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 30),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
