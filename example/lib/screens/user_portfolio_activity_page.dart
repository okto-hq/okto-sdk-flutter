import 'package:flutter/material.dart';

class UserPortfolioActivityPage extends StatefulWidget {
  const UserPortfolioActivityPage({super.key});

  @override
  State<UserPortfolioActivityPage> createState() => _UserPortfolioActivityPageState();
}

class _UserPortfolioActivityPageState extends State<UserPortfolioActivityPage> {
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
                'User Portfolio Activity',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 30),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
