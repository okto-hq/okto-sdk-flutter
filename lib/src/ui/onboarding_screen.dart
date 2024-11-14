import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:okto_flutter_sdk/okto_flutter_sdk.dart';
import 'package:webview_flutter/webview_flutter.dart';

class OnboardingScreen extends StatelessWidget {
  final String javaScript;
  final String url;
  final Future<String> Function() gAuthCallback;
  final Function(AuthTokenData authTokeData)? loginCallback;

  const OnboardingScreen(
      {super.key,
      required this.javaScript,
      required this.url,
      required this.loginCallback,
      required this.gAuthCallback});

  @override
  Widget build(BuildContext context) {
    WebViewController controller = WebViewController();
    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel("Print",
          onMessageReceived: (JavaScriptMessage data) async {
        Map<String, dynamic>? response = jsonDecode(data.message);
        if (response != null) {
          final String type = response['type'];
          if (type == "auth_success") {
            loginCallback?.call(AuthTokenData.fromMap(response['data']));
            Future.delayed(Duration(seconds: 2), () {
              Navigator.of(context).pop();
            });
          } else if (type == "g_auth") {
            String tokenId = await gAuthCallback();
            controller.runJavaScript('''
                window.postMessage('$tokenId', '*');
              ''');
          }
        }
      })
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {},
          onPageStarted: (String url) {
            controller.runJavaScript(javaScript);
          },
          onPageFinished: (String url) {},
          onHttpError: (HttpResponseError error) {},
          onWebResourceError: (WebResourceError error) {},
        ),
      )
      ..loadRequest(Uri.parse(url));
    return SafeArea(
      child: WebViewWidget(
        controller: controller
          ..clearCache()
          ..clearLocalStorage(),
      ),
    );
  }
}
