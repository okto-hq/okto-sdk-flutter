import 'package:example/okto.dart';
import 'package:example/screens/auth/login_page.dart';
import 'package:example/screens/home/home_page.dart';
import 'package:example/screens/init/init_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<bool> checkLoginStatus() async {
    // Simulate a network call or any async operation
    return await okto.isLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Okto Flutter example app',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: FutureBuilder<bool>(
        future: checkLoginStatus(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Show loading indicator while waiting for the login status
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (snapshot.hasError) {
            return const InitPage();
          } else {
            // Show login or home page based on login status
            bool isLoggedIn = snapshot.data ?? false;
            if (isLoggedIn) {
              return const HomePage();
            } else {
              return const InitPage();
            }
          }
        },
      ),
    );
  }
}
