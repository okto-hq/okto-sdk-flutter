import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:okto_flutter_sdk/src/exceptions/api_exception.dart';
import 'package:okto_flutter_sdk/src/utils/enums.dart';

class HttpClient {
  final String apiKey;
  final BuildType buildType;

  HttpClient({required this.apiKey, required this.buildType});

  Future<dynamic> post({required String endpoint, required Map<String, dynamic> body, String? authToken, Map<String, String>? additionalHeaders}) async {
    final baseUrl = _getBaseUrl(buildType);
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

  Future<dynamic> defaultPost({required String endpoint, required Map<String, dynamic> body, String? authToken, Map<String, String>? additionalHeaders}) async {
    final baseUrl = _getBaseUrl(buildType);
    final headers = {
      'Accept': '/',
      'x-api-key': apiKey,
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      if (authToken != null) 'Authorization': 'Bearer $authToken',
      ...?additionalHeaders,
    };
    final requestBody = jsonEncode(body);
    final response = await http.post(Uri.parse('$baseUrl$endpoint'), headers: headers, body: requestBody);
    return await _defaultProcessResponse(response);
  }

  Future<dynamic> get({required String endpoint, String? authToken, Map<String, String>? additionalHeaders}) async {
    final baseUrl = _getBaseUrl(buildType);
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

    dynamic _defaultProcessResponse(Response response) async {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body);
    } else {
      throw ApiException(response.statusCode, response.body);
    }
  }

  String _getBaseUrl(BuildType buildType) {
    switch (buildType) {
      case BuildType.staging:
        return 'https://3p-bff.oktostage.com';
      case BuildType.sandbox:
        return 'https://sandbox-api.okto.tech';
      case BuildType.production:
        return 'https://apigw.okto.tech';
      default:
        throw ArgumentError('Invalid BuildType: $buildType');
    }
  }
}
