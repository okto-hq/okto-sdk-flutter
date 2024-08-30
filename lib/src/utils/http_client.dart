import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:okto_flutter_sdk/src/exceptions/api_exception.dart';
import 'package:okto_flutter_sdk/src/utils/enums.dart';

class HttpClient {
  final String apiKey;
  final BuildType buildType;
  final http.Client httpClient;

  HttpClient({required this.apiKey, required this.buildType, http.Client? client}) : httpClient = client ?? http.Client();

  Future<dynamic> post({required String endpoint, required Map<String, dynamic> body, String? authToken, Map<String, String>? additionalHeaders}) async {
    final dio = Dio();
    final baseUrl = _getBaseUrl(buildType);
    dio.options = BaseOptions(
      baseUrl: baseUrl
    );
    try {
      final response = await dio.post(
        endpoint,
        options: Options(
          headers: {
            'accept': '*/*',
            'x-api-key': apiKey,
            'Content-Type': 'application/json',
            if (authToken != null) 'Authorization': 'Bearer $authToken',
            ...?additionalHeaders,
          },
        ),
        data: body,
      );
      return response.data;
    } on DioError catch (e) {
      if (e.response != null) {
        // The server responded with an error
        throw ApiException(e.response!.statusCode ?? 500, e.response!.data.toString());
      } else {
        // Something went wrong in setting up the request
        throw ApiException(500, e.message ?? 'Unknown error occurred');
      }
    }
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
