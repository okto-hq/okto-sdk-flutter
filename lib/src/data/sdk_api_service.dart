import 'package:dcx_network_client/env_config.dart';
import 'package:dcx_network_client/network/base_api_service.dart';
import 'package:dcx_network_client/network/http/api.dart';
import 'package:dio/src/options.dart';

class SdkApiService extends IApiService {
  SdkApiService({required super.apiKey, required super.envConfig});

  @override
  BaseOptions get baseOptions => BaseOptions(
      baseUrl: envConfig?.baseUrl.toString() ?? '',
      connectTimeout: const Duration(seconds: 2 * 60),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        "Content-Type": "application/json",
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Methods": "POST, OPTIONS, GET",
        "Accept": "*/*",
        if (apiKey?.isNotEmpty == true) "x-api-key": apiKey
      });

  @override
  void onEnvironmentChanged(EnvConfig envConfig) {
    super.onEnvironmentChanged(envConfig);
    baseOptions.baseUrl = envConfig.baseUrl;
  }

  IApi get allTokens {
    return Api(
        client: apiClient,
        name: "/supported/tokens",
        method: ApiMethod.get,
        suffix: "/api",
        version: "/v2"
    );
  }

  IApi get cryptoPortfolio {
    return Api(
        client: apiClient,
        name: "/aggregated-portfolio",
        method: ApiMethod.get,
        suffix: "/api",
        version: "/v2"
    );
  }

  IApi get ntfPortfolio {
    return Api(
        client: apiClient,
        name: "/portfolio/nft",
        method: ApiMethod.get,
        suffix: "/api",
        version: "/v2");
  }

  IApi get supportedNetworks {
    return Api(
      client: apiClient,
      name: "/supported/networks",
      method: ApiMethod.get,
      suffix: "/api",
      version: "/v2",
    );
  }

  IApi get userActivity {
    return Api(
        client: apiClient,
        name: "/portfolio/activity",
        method: ApiMethod.get,
        suffix: "/api",
        version: "/v2"
    );
  }

  IApi get nftDetails {
    return Api(
        client: apiClient,
        name: "/nft/order-details",
        method: ApiMethod.get,
        suffix: "/api",
        version: "/v2"
    );
  }

  IApi get wallets {
    return Api(
        client: apiClient,
        name: "/wallet",
        method: ApiMethod.get,
        suffix: "/api",
        version: "/v2");
  }

  IApi get executeTransaction {
    return Api(
        client: apiClient,
        name: "/transfer/tokens/execute",
        method: ApiMethod.post,
        suffix: "/api",
        version: "/v1");
  }

  IApi get estimate {
    return Api(
        client: apiClient,
        name: "/estimate",
        method: ApiMethod.post,
        suffix: "/api",
        version: "/v2");
  }
}