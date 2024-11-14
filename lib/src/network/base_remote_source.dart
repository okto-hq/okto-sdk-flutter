import 'package:dio/dio.dart';

import '../exceptions/api_exception.dart';
import 'dio_provider.dart';

class BaseRemoteSource {

  static Future<Response<T>> callApiWithErrorParser<T>(Future<Response<T>> api,
      {bool throwError = true}) async {
    try {
      Response<T> response = await api;
      return response;
    } on DioError catch (e) {
      if (e.response != null) {
        // The server responded with an error
        throw ApiException(
            e.response!.statusCode ?? 500, e.response!.data.toString());
      } else {
        // Something went wrong in setting up the request
        throw ApiException(500, e.message ?? 'Unknown error occurred');
      }
    }
  }
}
