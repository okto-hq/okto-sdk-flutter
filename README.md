
# okto_flutter_sdk

![Okto Image](https://docs.okto.tech/assets/brand_kit/partnership_logo/logo.png)

## Description

The `okto_flutter_sdk` is a Flutter SDK for integrating Okto services into mobile applications. This SDK provides functionalities to interact with Okto's features and services within your Flutter projects.

## Installation

Install the package in your Flutter project:

```bash
flutter pub add okto_flutter_sdk
```

### Prerequisites

Ensure you have the `google_sign_in` dependency in your project:

```bash
flutter pub add google_sign_in
```

## Android Setup

1. Go to [Google Cloud Console](https://console.cloud.google.com/).
2. Create a new project or select an existing one.
3. Enable the **Google Sign-In API** for your project.
4. Create a **Web Client ID**:
   - Navigate to **APIs & Services > Credentials**.
   - Click **Create Credentials > OAuth 2.0 Client IDs**.
   - Select **Web Application** as the application type.
   - Copy the generated Web Client ID and paste it into `android/app/src/main/res/values/strings.xml`:
     ```xml
     <resources>
         <string name="default_web_client_id">YOUR_WEB_CLIENT_ID</string>
     </resources>
     ```
5. Create an **Android Client ID** in the same credentials section:
   - Select **Android** as the application type.
   - Add your app's package name and SHA-1 signing certificate.
6. Sync your project and rebuild.

## iOS Setup

1. Go to [Google Cloud Console](https://console.cloud.google.com/) and create an iOS Client ID:
   - Navigate to **APIs & Services > Credentials**.
   - Click **Create Credentials > OAuth 2.0 Client IDs**.
   - Select **iOS** as the application type.
   - Add your app's Bundle ID.
2. Download the `GoogleService-Info.plist` file.
3. Place the `GoogleService-Info.plist` file inside `ios/Runner/`.
4. Configure `info.plist` to include your iOS Client ID and URL Scheme:
   ```xml
   <key>CFBundleURLTypes</key>
   <array>
       <dict>
           <key>CFBundleURLSchemes</key>
           <array>
               <string>com.googleusercontent.apps.YOUR_IOS_CLIENT_ID</string>
           </array>
       </dict>
   </array>
   ```
5. Run the following command to ensure your iOS project is correctly set up:
   ```bash
   flutter build ios
   ```

## API Key

- The `YOUR_CLIENT_API_KEY` is required to authenticate your application with Okto's services.
- Obtain the API key from the Okto Developer Portal:
  1. Log in to [Okto Developer Portal](https://sdk-docs.okto.tech/).
  2. Navigate to your project settings.
  3. Copy the API key for either **Sandbox** or **Production** environment.
- Replace `YOUR_CLIENT_API_KEY` in the example code with your actual key.

## Usage

To utilize the SDK within your application, follow these steps:

### Initialize the SDK

Initialize the SDK anywhere in your codebase:
```dart
final okto = Okto('YOUR_CLIENT_API_KEY', BuildType.sandbox);
```

### Access SDK Functionalities

Here is an example of how to integrate Google Sign-In with Okto:

```dart
import 'package:google_sign_in/google_sign_in.dart';
import 'package:okto_flutter_sdk/okto_flutter_sdk.dart';
import 'package:flutter/material.dart';

final GoogleSignIn googleSignIn = GoogleSignIn();
final Okto okto = Okto('YOUR_CLIENT_API_KEY', BuildType.sandbox);

ElevatedButton(
    onPressed: () async {
        try {
            final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
            final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
            if (googleAuth != null) {
                final String? idToken = googleAuth.idToken;
                await okto.authenticate(idToken: idToken!);
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => const HomePage()));
            }
        } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${e.toString()}')),
            );
        }
    },
    child: const Text('Login with Google, powered by Okto.'),
);
```

### Additional Resources

- For detailed documentation, visit the [Okto Wallet SDK Documentation](https://sdk-docs.okto.tech/).

---

With these steps, you can easily integrate `okto_flutter_sdk` into your Flutter project and start leveraging its powerful features!
