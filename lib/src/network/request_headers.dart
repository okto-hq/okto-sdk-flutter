import 'package:dio/dio.dart';

class RequestHeaderInterceptor extends InterceptorsWrapper {
  // final AuthRepository _authRepository = Get.find<AuthRepository>();
  RequestHeaderInterceptor();
  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    Map<String, dynamic> headers = await getCustomHeaders();
    options.headers.addAll(headers);
    super.onRequest(options, handler);
  }

  Future<Map<String, String>> getCustomHeaders() async {
    var customHeaders = {'content-type': 'application/json'};
    // var authHeaders = await _authRepository.getAuthHeaders();
    // customHeaders.addAll(authHeaders);
    return customHeaders;
  }
}
