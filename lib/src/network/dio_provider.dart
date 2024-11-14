import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:okto_flutter_sdk/src/network/request_headers.dart';

class DioProvider {

  static Dio? _instance;

  static String baseURL = "https://3p-bff.oktostage.com";

  static final _headerInterceptor = RequestHeaderInterceptor();
  // static final _requestRetrier = DioRequestRetrier();
  // static final _curlInterceptor = CurlInterceptor();
  static final BaseOptions _options = BaseOptions(
    baseUrl: baseURL,
    connectTimeout: const Duration(seconds: 60),
    receiveTimeout: const Duration(seconds: 60),
  );

  static Dio get httpDio {
    if (_instance == null) {
      _instance = Dio(_options);
      // _instance!.interceptors.add(_curlInterceptor);

      return _instance!;
    } else {
      _instance!.interceptors.clear();
      // _instance!.interceptors.add(_curlInterceptor);

      return _instance!;
    }
  }

  ///returns a Dio client with Access token in header
  static Dio get tokenClient {
    _addInterceptors();

    return _instance!;
  }

  ///returns a Dio client with Access token in header
  ///Also adds a token refresh interceptor which retry the request when it's unauthorized
  static Dio get dioWithHeaderToken {
    _addInterceptors();

    return _instance!;
  }

  static _addInterceptors() {
    _instance ??= httpDio;
    _instance!.interceptors.clear();
    // _instance!.interceptors.add(_curlInterceptor);
    // _instance!.interceptors.add(_requestRetrier);
    _instance!.interceptors.add(_headerInterceptor);
  }

  DioProvider.setContentTypeApplicationJson() {
    _instance?.options.contentType = "application/json";
  }
}
