import 'dart:async';
import 'dart:convert';

import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okto_flutter_sdk/src/utils/app_constants.dart';
import 'package:okto_sdk/network/models/client/auth_token_model.dart';
import 'package:webview_flutter/webview_flutter.dart';

class OnboardingScreen extends StatefulWidget {
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
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final RxBool _isLoading = true.obs;
  final WebViewController _controller = WebViewController();

  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel("Print",
          onMessageReceived: (JavaScriptMessage data) async {
        Map<String, dynamic>? response = jsonDecode(data.message);
        if (response == null) return;
        final String type = response['type'];
        switch (type) {
          case WebEvent.AUTH_SUCCESS: {
              final authDetail = AuthTokenData.fromMap(response['data']);
              widget.loginCallback?.call(authDetail);
            }
          case WebEvent.G_AUTH: {
              String tokenId = await widget.gAuthCallback();
              final data =
                  jsonEncode({"type": WebEvent.G_AUTH, "data": tokenId});
              _controller.runJavaScript('''
                window.postMessage('$data', '*');
              ''');
            }
          case WebEvent.GO_BACK: {
              Navigator.of(context).pop();
            }
          case WebEvent.COPY_TEXT: {
              String pastedOTP = await FlutterClipboard.paste();
              pastedOTP = pastedOTP.trim();
              final data =
                  jsonEncode({"type": WebEvent.COPY_TEXT, "data": pastedOTP});
              _controller.runJavaScript('''
                window.postMessage('$data', '*');
              ''');
            }
        }
      })
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {},
          onPageStarted: (String url) {
            _controller.runJavaScript(widget.javaScript);
          },
          onPageFinished: (String url) {
            hideLoader();
          },
          onHttpError: (HttpResponseError error) {},
          onWebResourceError: (WebResourceError error) {},
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            WebViewWidget(
              controller: _controller
                ..clearCache()
                ..clearLocalStorage(),
            ),
            Obx(() => _isLoading.value
                ? const Center(child: CircularProgressIndicator())
                : const SizedBox.shrink())
          ],
        ),
      ),
    );
  }

  void showLoader() {
    _isLoading.value = true;
  }

  void hideLoader() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(seconds: 1), () {
      fixme: // we get page finished callback multiple times
      _isLoading.value = false;
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _isLoading.close();
    super.dispose();
  }
}
