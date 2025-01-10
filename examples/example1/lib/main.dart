import 'package:example/okto.dart';
import 'package:example/screens/auth/login_page.dart';
import 'package:example/screens/home/home_page.dart';
import 'package:example/screens/init/init_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:okto_flutter_sdk/okto_flutter_sdk.dart';
import 'package:okto_sdk/core/sdk_client/sdk_core.dart';
import 'package:okto_sdk/okto_flutter_sdk.dart';
import 'package:okto_network_manager/service_config.dart';

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
  await OktoSdk().init(
    OktoCore(
      id: "0x5d7E7666f4657bcB60d1F7F1C579738Bec994851",
      privateKey:
          "2aaa089f7e26ad3d2da3518e1e945d76804372b6bdd044c7f059598c31fa7dcc",
      apiKey: "b7a36ee9-80e3-4063-b2a1-f9f482a8db51",
      maxPriorityFeePerGas: "0x2E90EDD000",
      maxFeePerGas: "0x2E90EDD000"
    ),
    oktoServiceConfig: ServiceConfig(
      appName: "okto_sdk",
      baseUrls: {
        "bff" : "https://sandbox-api.okto.tech",
        "auth" : "https://sandbox-api.okto.tech",
        "portfolio" : "https://sandbox-api.okto.tech"
      },
      rpcBaseUrl: "https://okto-gateway.oktostage.com/rpc"
    )
  );
  okto = Okto(globals.getApiKey(), globals.getBuildType());
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
            print(snapshot.error.toString());
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
