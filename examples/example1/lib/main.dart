import 'package:example/okto.dart';
import 'package:example/screens/home/home_page.dart';
import 'package:example/screens/init/init_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:okto_flutter_sdk/okto_flutter_sdk.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      name: "Okto-3p-example",
      options: const FirebaseOptions(
        apiKey: 'AIzaSyCdRjCVZlhrq72RuEklEyyxYlBRCYhI2Sw',
        appId: '1:406099696497:android:21d5142deea38dda3574d0',
        messagingSenderId: '406099696497',
        projectId: 'flutterfire-e2e-tests',
        databaseURL:
            'https://flutterfire-e2e-tests-default-rtdb.europe-west1.firebasedatabase.app',
        storageBucket: 'flutterfire-e2e-tests.appspot.com',
      ));
  if(okto == null && globals.getClientSwa().isNotEmpty && globals.getClientPrivateKey().isNotEmpty) {
    okto = Okto();
    await okto?.initializeSdk(
        swa: globals.getClientSwa(),
        privateKey: globals.getClientPrivateKey(),
        env: globals.getBuildType());
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<bool> checkLoginStatus() async {
    // Simulate a network call or any async operation
    return await okto!.isLoggedIn();
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
