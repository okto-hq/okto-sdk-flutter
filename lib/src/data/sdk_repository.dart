import 'package:dcx_network_client/network/http/api.dart';
import 'package:dcx_network_client/network/http/network_manager.dart';
import 'package:dcx_network_client/repository/base_repository.dart';
import 'package:okto_flutter_sdk/src/data/sdk_api_service.dart';
import 'package:okto_flutter_sdk/src/models/wallet_data_v2.dart';
import 'package:okto_flutter_sdk/src/models/whitelisted_network_data_v2.dart';
import 'package:okto_flutter_sdk/src/models/whitelisted_token_data_v2.dart';

import '../models/activity_data_v2.dart';
import '../models/nft_order_details_v2.dart';
import '../models/portfolio_data_v2.dart';

class SdkRepository extends IRepository {
  SdkRepository({required super.services});

  late final SdkApiService _apiService = getService<SdkApiService>();

  Future<ApiResponse<WhitelistedTokenDataV2>> getAllTokens(
      {required int limit, required int offset}) async {
    return NetworkManager().fetch(
        api: _apiService.allTokens,
        converter: (json) => WhitelistedTokenDataV2.fromJson(json),
        body: {
          "limit": limit,
          "offset": offset,
        },
        resultKey: "data");
  }

  Future<WhitelistedNetworkDataV2?> getSupportedNetworks() async {
    final response = await NetworkManager().fetch(
        api: _apiService.supportedNetworks,
        converter: (json) => WhitelistedNetworkDataV2.fromJson(json),
        resultKey: "data"
    );
    return response.data;
  }

  Future<ApiResponse<ActivityDataV2>> getUserActivity({
    required int size, required int page}) async {
    return NetworkManager().fetch(
        api: _apiService.userActivity,
        converter: (json) => ActivityDataV2.fromJson(json),
        body: {
          "size": size,
          "page": page,
        },
        resultKey: "data");
  }

  Future<ApiResponse<PortfolioDataV2>> getCryptoPortfolio() {
    return NetworkManager().fetch(
        api: _apiService.cryptoPortfolio,
        converter: (json) => PortfolioDataV2.fromJson(json));
  }

  Future<ApiResponse<NftOrderDetailsV2>> getNftDetails(Map<String, dynamic> queryParams) {
    return NetworkManager().fetch(
        api: _apiService.nftDetails,
        converter: (json) => NftOrderDetailsV2.fromJson(json),
        body: queryParams
    );
  }

  Future<ApiResponse<WalletDataV2>> getWallets() {
    return NetworkManager().fetch(
        api: _apiService.wallets,
        converter: (json) => WalletDataV2.fromJson(json),
        resultKey: "data");
  }
}
