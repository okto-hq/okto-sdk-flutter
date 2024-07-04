import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:okto_flutter_sdk/src/models/client/auth_token_model.dart';
import 'package:okto_flutter_sdk/src/utils/check_auth_token.dart';
import 'package:okto_flutter_sdk/src/utils/http_client.dart';

class TokenManager {
  final FlutterSecureStorage secureStorage;
  final HttpClient httpClient;

  TokenManager(this.httpClient) : secureStorage = const FlutterSecureStorage();

  Future<String?> getAuthToken() async {
    String? authToken = await secureStorage.read(key: 'auth_token');
    if (authToken == null) {
      throw Exception('Auth token does not exist. Please authenticate first.');
    }
    if (AuthToken.checkExpiry(authToken)) {
      await refreshToken();
      authToken = await secureStorage.read(key: 'auth_token');
      if (authToken == null) {
        throw Exception('Failed to refresh auth token. Please authenticate again.');
      }
    }
    return authToken;
  }

  Future<void> storeTokens(String authToken, String refreshToken, String deviceToken) async {
    await secureStorage.write(key: 'auth_token', value: authToken);
    await secureStorage.write(key: 'refresh_auth_token', value: refreshToken);
    await secureStorage.write(key: 'device_token', value: deviceToken);
  }

  Future<AuthTokenResponse> refreshToken() async {
    final oldRefreshToken = await secureStorage.read(key: 'refresh_auth_token');
    final oldDeviceToken = await secureStorage.read(key: 'device_token');
    final oldAuthToken = await secureStorage.read(key: 'auth_token');

    if (oldRefreshToken == null || oldDeviceToken == null || oldAuthToken == null) {
      throw Exception('Missing tokens required for refreshing. Please authenticate again.');
    }


    final response = await httpClient.post(
        endpoint: '/api/v1/refresh_token',
        body: {},
        authToken: oldAuthToken,
        additionalHeaders: {
          'x-refresh-authorization': 'Bearer $oldRefreshToken',
          'x-device-token': oldDeviceToken,
        });

    final authTokenResponse = AuthTokenResponse.fromMap(response);
    await storeTokens(authTokenResponse.data.authToken, authTokenResponse.data.refreshAuthToken, authTokenResponse.data.deviceToken);
    return authTokenResponse;
  }

  Future<bool> deleteToken() async {
    try {
      await secureStorage.deleteAll();
      return true;
    } catch (e) {
      return false;
    }
  }
}
