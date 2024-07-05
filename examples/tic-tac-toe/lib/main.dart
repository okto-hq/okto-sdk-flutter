import 'package:flutter/material.dart';
import 'package:okto_flutter_sdk/okto_flutter_sdk.dart';
import 'package:tictactoe/constants/globals.dart';
import 'package:tictactoe/core/game.dart';
import 'package:tictactoe/init_screen.dart';
import 'package:tictactoe/utils/okto.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Globals globals = Globals.instance;
  okto = Okto(globals.getApiKey(), globals.getBuildType());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  Future<bool> checkLoginStatus() async {
    // Simulate a network call or any async operation
    return await okto!.isLoggedIn();
  }

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Game',
      debugShowCheckedModeBanner: false,
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
              return const GamePage();
            } else {
              return const InitPage();
            }
          }
        },
      ),
    );
  }
}
//My name is Ahsan
