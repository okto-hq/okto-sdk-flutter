# okto_flutter_sdk

![Okto Image](https://docs.okto.tech/assets/brand_kit/partnership_logo/logo.png)

## Description

The `okto_flutter_sdk` is a Flutter SDK for integrating Okto services into mobile applications. This SDK provides functionalities to interact with Okto's features and services within your Flutter projects.

## Installation

Install the package in your Flutter project:

`flutter pub add okto_flutter_sdk`

## Usage

To utilize the SDK within your application, follow these steps:

- Initialize the SDK, anywhere in your codebase.

  `final okto = Okto('YOUR_CLIENT_API_KEY', BuildType.sandbox);`

- Access SDK functionalities within your widgets:


  ```dart
            ElevatedButton(
                onPressed: () async {
                  try {
                    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
                    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
                    if (googleAuth != null) {
                      final String? idToken = googleAuth.idToken;
                      await okto!.authenticate(idToken: idToken!);
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage()));
                    }
                  } catch (e) {
                    print(e.toString());
                  }
                },
                child: const Text('Login with Google, powered by Okto.')),

  ```

- For a much detailed documentation visit [Okto Wallet SDK Docs](https://sdk-docs.okto.tech/)
