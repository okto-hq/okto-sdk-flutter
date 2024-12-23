import 'dart:io';

import 'package:dcx_network_client/env_config.dart';
import 'package:dcx_network_client/network/base_api_service.dart';
import 'package:dcx_network_client/repository/base_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:okto_flutter_sdk/okto_flutter_sdk.dart';
import 'package:okto_flutter_sdk/src/data/sdk_api_service.dart';
import 'package:okto_flutter_sdk/src/data/sdk_repository.dart';

import '../network/build_config.dart';

class RepositoryProvider extends IRepositoryProvider {

  String? _apiKey;

  late final SdkRepository sdkRepository = SdkRepository(services: {
    SdkApiService(apiKey: _apiKey, envConfig: BuildConfig.instance.config),
  });

  @override
  String get deviceType  {
    if (kIsWeb) return "web";
    return Platform.isIOS ? "ios" : "android";
  }

  void setAuthorizationDetail(AuthTokenData authDetails) {
    final headers = {
      if (authDetails.authToken.isNotEmpty == true)
        IApiService.headerAuthorization: "Bearer ${authDetails.authToken}",
      if (authDetails.refreshAuthToken.isNotEmpty == true)
        IApiService.headerRefreshToken: authDetails.refreshAuthToken,
      if (authDetails.deviceToken.isNotEmpty == true)
        IApiService.headerDeviceToken: authDetails.deviceToken
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