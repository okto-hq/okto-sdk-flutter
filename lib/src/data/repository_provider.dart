import 'dart:io';

import 'package:dcx_network_client/env_config.dart';
import 'package:dcx_network_client/network/base_api_service.dart';
import 'package:dcx_network_client/repository/base_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:okto_flutter_sdk/src/data/sdk_api_service.dart';
import 'package:okto_flutter_sdk/src/data/sdk_repository.dart';
import 'package:okto_flutter_sdk/src/utils/token_manager.dart';

import '../network/build_config.dart';

class RepositoryProvider extends IRepositoryProvider {

  final String apiKey;
  final TokenManager tokenManager;

  RepositoryProvider({required this.apiKey, required this.tokenManager}) {
    setAuthorizationDetail();
  }

  late final SdkRepository sdkRepository = SdkRepository(services: {
    SdkApiService(apiKey: apiKey, envConfig: BuildConfig.instance.config),
  });

  @override
  String get deviceType  {
    if (kIsWeb) return "web";
    return Platform.isIOS ? "ios" : "android";
  }

  void setAuthorizationDetail() async {
    String? authToken = await tokenManager.getAuthToken();
    String? deviceToken = await tokenManager.getDeviceToken();
    String? refreshAuthToken = await tokenManager.getRefreshAuthToken();
    final headers = {
      if (authToken != null && authToken.isNotEmpty == true)
        IApiService.headerAuthorization: "Bearer $authToken",
      if (refreshAuthToken != null && refreshAuthToken.isNotEmpty == true)
        IApiService.headerRefreshToken: refreshAuthToken,
      if (deviceToken != null && deviceToken.isNotEmpty == true)
        IApiService.headerDeviceToken: deviceToken
    };
    sdkRepository.setHeaders(headers);
  }

  void onEnvironmentChange(EnvConfig type) {
    sdkRepository.onEnvironmentChange(type);
  }

  @override
  Future<void> initialize() async {
    // implement initialize
  }

  @override
  Future<void> close() async {
    // implement close
  }

}