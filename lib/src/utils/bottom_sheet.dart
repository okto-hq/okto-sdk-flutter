import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
class WebViewBottomSheet extends StatefulWidget {
  final String url;
  final String buildtype;
  final String textPrimaryColor;
  final String textSecondaryColor;
  final String textTertiaryColor;
  final String accentColor;
  final String accent2Color;
  final String strokBorderColor;
  final String strokDividerColor;
  final String surfaceColor;
  final String backgroundColor;
  final String? authToken;

  const WebViewBottomSheet({
    super.key,
    required this.url,
    required this.buildtype,
    required this.textPrimaryColor,
    required this.textSecondaryColor,
    required this.textTertiaryColor,
    required this.accentColor,
    required this.accent2Color,
    required this.strokBorderColor,
    required this.strokDividerColor,
    required this.surfaceColor,
    required this.backgroundColor,
    this.authToken,
  });

  @override
  State<WebViewBottomSheet> createState() => _WebViewBottomSheetState();
}

class _WebViewBottomSheetState extends State<WebViewBottomSheet> {
  late WebViewController _controller;
  double _sheetHeight = 300.0;
  final double _minHeight = 300.0;
  final double _maxHeight = 700.0;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (String url) {
            _injectJavaScript();
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  void _injectJavaScript() {
    _controller.runJavaScript(getInjectedJs());
  }

  String getInjectedJs() {
    String injectJs = '''
    window.localStorage.setItem('ENVIRONMENT', '${widget.buildtype}');
    window.localStorage.setItem('textPrimaryColor', '${widget.textPrimaryColor}');
    window.localStorage.setItem('textSecondaryColor', '${widget.textSecondaryColor}');
    window.localStorage.setItem('textTertiaryColor', '${widget.textTertiaryColor}');
    window.localStorage.setItem('accentColor', '${widget.accentColor}');
    window.localStorage.setItem('accent2Color', '${widget.accent2Color}');
    window.localStorage.setItem('strokBorderColor', '${widget.strokBorderColor}');
    window.localStorage.setItem('strokDividerColor', '${widget.strokDividerColor}');
    window.localStorage.setItem('surfaceColor', '${widget.surfaceColor}');
    window.localStorage.setItem('backgroundColor', '${widget.backgroundColor}');
    ''';
    if (widget.authToken != null) {
      injectJs += "window.localStorage.setItem('authToken', '${widget.authToken}');";
    }
    return injectJs;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragUpdate: (details) {
        setState(() {
          _sheetHeight -= details.delta.dy;
          _sheetHeight = _sheetHeight.clamp(_minHeight, _maxHeight);
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: _sheetHeight,
        child: Column(
          children: [
            _buildDragger(),
            Expanded(
              child: WebViewWidget(controller: _controller),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDragger() {
    return Container(
      width: double.infinity,
      height: 25,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
      ),
      child: Center(
        child: Container(
          width: 40,
          height: 5,
          decoration: BoxDecoration(
            color: Colors.grey[600],
            borderRadius: BorderRadius.circular(2.5),
          ),
        ),
      ),
    );
  }
}