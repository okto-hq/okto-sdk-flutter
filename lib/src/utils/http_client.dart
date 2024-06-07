import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:okto_wallet_sdk/constants/url.dart';
import 'package:okto_wallet_sdk/src/exceptions/api_exception.dart';

class HttpClient {
  final String apiKey;

  HttpClient({required this.apiKey});

  Future<dynamic> post({required String endpoint, required Map<String, dynamic> body, String? authToken, Map<String, String>? additionalHeaders}) async {
    var headersList = {
      'Accept': '/',
      'x-api-key': apiKey,
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (authToken != null) 'Authorization': 'Bearer $authToken',
      ...?additionalHeaders,
    };
    var reqBody = body;
    var url = Uri.parse('$baseUrl$endpoint');
    var req = http.Request('POST', url);
    req.headers.addAll(headersList);
    req.body = jsonEncode(reqBody);
    var res = await req.send();
    return await _processResponse(res);
  }

  // Future<dynamic> post({required String endpoint, required Map<String, dynamic> body, String? authToken, Map<String, String>? additionalHeaders}) async {
  //   final headers = {
  //     'Accept': '*/*',
  //     'Content-Type': 'application/json',
  //     'Accept': 'application/json',
  //     'x-api-key': apiKey,
  //     if (authToken != null) 'Authorization': 'Bearer $authToken',
  //     ...?additionalHeaders,
  //   };

  //   final response = await http.post(
  //     Uri.parse('$baseUrl$endpoint'),
  //     headers: headers,
  //     body: jsonEncode(body),
  //   );
  //   // return _processResponse(response);
  // }

  // Future<dynamic> get(String endpoint, {String? authToken, Map<String, String>? additionalHeaders}) async {
  //   final headers = {
  //     'accept': 'application/json',
  //     'x-api-key': apiKey,
  //     if (authToken != null) 'Authorization': 'Bearer $authToken',
  //     ...?additionalHeaders,
  //   };

  //   final response = await http.get(Uri.parse('$baseUrl$endpoint'), headers: headers);

  // }

  Future<dynamic> get({required String endpoint, String? authToken, Map<String, String>? additionalHeaders}) async {
    var headersList = {
      'Accept': '/',
      'Accept': 'application/json',
      'x-api-key': apiKey,
      if (authToken != null) 'Authorization': 'Bearer $authToken',
      ...?additionalHeaders,
    };
    var url = Uri.parse('$baseUrl$endpoint');
    var req = http.Request('GET', url);
    req.headers.addAll(headersList);
    var res = await req.send();
    return await _processResponse(res);
  }

  dynamic _processResponse(http.StreamedResponse response) async {
    final resBody = await response.stream.bytesToString();
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(resBody);
    } else {
      throw ApiException(response.statusCode, resBody);
    }
  }
}
