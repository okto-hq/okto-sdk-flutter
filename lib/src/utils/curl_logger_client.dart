import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class CurlLoggerClient extends http.BaseClient {
  final http.Client _inner;

  CurlLoggerClient(this._inner);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    // Print the cURL command before sending the request
    _printCurlCommand(request);

    // Proceed with the request
    return _inner.send(request);
  }

  void _printCurlCommand(http.BaseRequest request) {
    final method = request.method;
    final url = request.url;
    final headers = request.headers;

    // Start building the cURL command
    String curlCommand = "curl -X $method '${url.toString()}'";

    // Add headers
    headers.forEach((key, value) {
      curlCommand += " -H '$key: $value'";
    });

    // If it's a POST or PUT, and there's a body, add it
    if (request is http.Request && request.body.isNotEmpty) {
      // Handle string or JSON body
      curlCommand += " -d '${request.body}'";
    }

    // Print the generated cURL command
    debugPrint('---------- cURL Command ----------');
    debugPrint(curlCommand);
    debugPrint('-----------------------------------');
  }
}
