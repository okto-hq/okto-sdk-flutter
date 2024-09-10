// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:okto_flutter_sdk/src/models/client/auth_token_model.dart';
import 'package:okto_flutter_sdk/src/models/client/network_model.dart';
import 'package:okto_flutter_sdk/src/models/client/order_details_nft_model.dart';
import 'package:okto_flutter_sdk/src/models/client/order_history_model.dart';
import 'package:okto_flutter_sdk/src/models/client/raw_transaction_execute_model.dart';
import 'package:okto_flutter_sdk/src/models/client/raw_transaction_status_model.dart';
import 'package:okto_flutter_sdk/src/models/client/token_model.dart';
import 'package:okto_flutter_sdk/src/models/client/transfer_nft_model.dart';
import 'package:okto_flutter_sdk/src/models/client/transfer_token_model.dart';
import 'package:okto_flutter_sdk/src/models/client/user_portfilio_activity_model.dart';
import 'package:okto_flutter_sdk/src/models/client/user_portfolio_model.dart';
import 'package:okto_flutter_sdk/src/models/client/wallet_model.dart';
import 'package:okto_flutter_sdk/src/utils/enums.dart';
import 'package:okto_flutter_sdk/src/utils/http_client.dart';
import 'package:okto_flutter_sdk/src/utils/token_manager.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'models/client/user_model.dart';

class Okto {
  /// Client Side Api Key received from OKto
  final String apiKey;
  final HttpClient httpClient;
  final TokenManager tokenManager;
  final BuildType buildType;
  String? _oktoToken;
  String? _idToken;

  Okto(this.apiKey, this.buildType)
      : httpClient = HttpClient(apiKey: apiKey, buildType: buildType),
        tokenManager =
            TokenManager(HttpClient(apiKey: apiKey, buildType: buildType));

  // Factory constructor for testing
  @visibleForTesting
  factory Okto.test(String apiKey, BuildType buildType, HttpClient httpClient,
      TokenManager tokenManager) {
    return Okto._test(apiKey, buildType, httpClient, tokenManager);
  }

  // Private constructor for testing
  Okto._test(this.apiKey, this.buildType, this.httpClient, this.tokenManager);

  /// Method to authenticate a new user using the id token received from google_sign_in
  /// Pass the idToken received from google_sign_in to authenticate the user
  Future<dynamic> authenticate({required String idToken}) async {
    _idToken = idToken;
    final response = await httpClient
        .post(endpoint: '/api/v1/authenticate', body: {'id_token': idToken});
    print(response.toString());
    final authTokenResponse = AuthTokenResponse.fromMap(response);
    await tokenManager.storeTokens(
        authTokenResponse.data.authToken,
        authTokenResponse.data.refreshAuthToken,
        authTokenResponse.data.deviceToken);
    return authTokenResponse;
  }

  /// Method to authenticate a user using the user id and JWT token
  /// This method gives an AUTH_TOKEN, REFRESH_AUTH_TOKEN and DEVICE_TOKEN
  Future<AuthTokenResponse> authenticateWithUserId(
      {required String userId, required String jwtToken}) async {
    _idToken = jwtToken;
    final response = await httpClient.post(
        endpoint: '/api/v1/jwt-authenticate',
        body: {'user_id': userId, 'auth_token': jwtToken});
    final authTokenResponse = AuthTokenResponse.fromMap(response);
    await tokenManager.storeTokens(
        authTokenResponse.data.authToken,
        authTokenResponse.data.refreshAuthToken,
        authTokenResponse.data.deviceToken);
    return authTokenResponse;
  }

  /// Use to check if the current session in the app is logged in or not.
  /// Use this method to show login page or home page for an user.
  Future<bool> isLoggedIn() async {
    try {
      await tokenManager.getAuthToken();
      return true;
    } catch (e) {
      return false;
    }
  }

  /// POST
  /// Method to refresh the user token
  Future<AuthTokenResponse> refreshToken() async {
    final refreshToken = await tokenManager.refreshToken();
    return refreshToken;
  }

  /// Method to get the user details
  /// Returns an [UserDetails] object
  Future<UserDetails> userDetails() async {
    final authToken = await tokenManager.getAuthToken();
    final response = await httpClient.get(
        endpoint: '/api/v1/user_from_token', authToken: authToken);
    return UserDetails.fromMap(response);
  }

  /// Method to create a new wallet for the user
  /// Returns a [WalletResponse] object
  Future<WalletResponse> createWallet() async {
    final authToken = await tokenManager.getAuthToken();
    final response = await httpClient.post(
        endpoint: '/api/v1/wallet', body: {}, authToken: authToken);
    return WalletResponse.fromMap(response);
  }

  /// Method to get the user wallets
  /// Returns a [WalletResponse] object
  Future<WalletResponse> getWallets() async {
    final authToken = await tokenManager.getAuthToken();
    final response =
        await httpClient.get(endpoint: '/api/v1/wallet', authToken: authToken);
    return WalletResponse.fromMap(response);
  }

  /// Method to get supported networks
  /// Returns a [NetworkDetails] object
  Future<NetworkDetails> supportedNetworks() async {
    final authToken = await tokenManager.getAuthToken();
    final response = await httpClient.get(
        endpoint: '/api/v1/supported/networks', authToken: authToken);
    return NetworkDetails.fromMap(response);
  }

  /// Method to get supported tokens with pagination
  /// Returns a [TokenResponse] object
  /// Default value of page is 1 and size is 10
  Future<TokenResponse> supportedTokens({int page = 1, int size = 10}) async {
    final authToken = await tokenManager.getAuthToken();
    final response = await httpClient.get(
        endpoint: '/api/v1/supported/tokens?page=$page&size=$size',
        authToken: authToken);
    return TokenResponse.fromMap(response);
  }

  /// Method to get the user portfolio
  /// Returns a [UserPortfolioResponse] object
  Future<UserPortfolioResponse> userPortfolio() async {
    final authToken = await tokenManager.getAuthToken();
    final response = await httpClient.get(
        endpoint: '/api/v1/portfolio', authToken: authToken);
    return UserPortfolioResponse.fromMap(response);
  }

  /// Method to get the user portfolio activity
  /// Returns a [UserPortfolioActivityResponse] object
  /// Default value of limit is 10 and offset is 1
  Future<UserPortfolioActivityResponse> getUserPortfolioActivity(
      {int limit = 10, int offset = 1}) async {
    final authToken = await tokenManager.getAuthToken();
    final response = await httpClient.get(
        endpoint: '/api/v1/portfolio/activity?limit=$limit&offset=$offset',
        authToken: authToken);
    return UserPortfolioActivityResponse.fromMap(response);
  }

  /// Method to transfer tokens from one wallet to another
  /// Returns a [TransferTokenResponse] object
  /// Network Names: "APTOS", "BASE", "POLYGON", "POLYGON_TESTNET_AMOY", "SOLANA", "SOLANA_DEVNET",
  Future<TransferTokenResponse> transferTokens(
      {required String networkName,
      String? tokenAddress,
      required String quantity,
      required String recipientAddress}) async {
    final authToken = await tokenManager.getAuthToken();
    final body = {
      "network_name": networkName,
      "token_address": tokenAddress,
      "quantity": quantity,
      "recipient_address": recipientAddress
    };
    final response = await httpClient.post(
        endpoint: '/api/v1/transfer/tokens/execute',
        body: body,
        authToken: authToken);
    return TransferTokenResponse.fromMap(response);
  }

  /// Method to get order history with optional filters
  /// Returns a [OrderHistoryResponse] object
  /// Default value of offset is 0 and limit is 1 and orderState is SUCCESS
  Future<OrderHistoryResponse> orderHistory(
      {int offset = 0,
      int limit = 1,
      String? orderId,
      OrderState? orderState}) async {
    String? orderStateToPass;
    switch (orderState) {
      case OrderState.pending:
        orderStateToPass = 'PENDING';
      case OrderState.success:
        orderStateToPass = 'SUCCESS';
      case OrderState.failed:
        orderStateToPass = 'FAILED';
        break;
      default:
        orderStateToPass = 'SUCCESS';
    }
    final authToken = await tokenManager.getAuthToken();
    final queryParameters = {
      'offset': offset.toString(),
      'limit': limit.toString(),
      if (orderId != null) 'order_id': orderId,
      if (orderState != null) 'order_state': orderStateToPass
    };
    final queryString = Uri(queryParameters: queryParameters).query;
    final response = await httpClient.get(
        endpoint: '/api/v1/orders?$queryString', authToken: authToken);
    return OrderHistoryResponse.fromMap(response);
  }

  /// Method to transfer nft
  /// Returns a [TransferNftResponse] object
  /// Operation Types: "NFT_TRANSFER"
  Future<TransferNftResponse> transferNft({
    required String operationType,
    required String networkName,
    required String collectionAddress,
    required String collectionName,
    required String quantity,
    required String recipientAddress,
    required String nftAddress,
  }) async {
    final authToken = await tokenManager.getAuthToken();
    final response = await httpClient.post(
        endpoint: '/api/v1/nft/transfer',
        body: {
          'operation_type': operationType,
          'network_name': networkName,
          'collection_address': collectionAddress,
          'collection_name': collectionName,
          'quantity': quantity,
          'recipient_address': recipientAddress,
          'nft_address': nftAddress
        },
        authToken: authToken);
    return TransferNftResponse.fromMap(response);
  }

  /// Method to get the order details for nft
  /// Returns a [OrderDetailsNftResponse] object
  /// Default value of page is 1 and size is 500
  /// Optional parameters: orderId, orderState
  Future<OrderDetailsNftResponse> orderDetailsNft(
      {int page = 1,
      int size = 500,
      String? orderId,
      String? orderState}) async {
    final authToken = await tokenManager.getAuthToken();
    final queryParams = {
      'page': page.toString(),
      'size': size.toString(),
      if (orderId != null) 'order_id': orderId,
      if (orderState != null) 'order_state': orderState
    };
    final queryString = Uri(queryParameters: queryParams).query;
    final response = await httpClient.get(
        endpoint: '/api/v1/nft/order_details?$queryString',
        authToken: authToken);
    return OrderDetailsNftResponse.fromMap(response);
  }

  /// Method to execute a raw transaction
  /// Returns a [RawTransactionExecuteResponse] object
  Future<RawTransactionExecuteResponse> rawTransactionExecute(
      {required String networkName,
      required Map<String, dynamic> transaction}) async {
    final authToken = await tokenManager.getAuthToken();
    final response = await httpClient.post(
      endpoint: '/api/v1/rawtransaction/execute',
      body: {'network_name': networkName, 'transaction': transaction},
      authToken: authToken,
    );
    return RawTransactionExecuteResponse.fromMap(response);
  }

  /// Method to get the status of a raw transaction
  /// Returns a [RawTransactionStatusResponse] object
  /// Pass the orderId received from the [rawTransactionExecute] method
  Future<RawTransactionStatusResponse> rawTransactionStatus(
      {required String orderId}) async {
    final authToken = await tokenManager.getAuthToken();
    final response = await httpClient.get(
        endpoint: '/api/v1/rawtransaction/status?order_id=$orderId',
        authToken: authToken);
    return RawTransactionStatusResponse.fromMap(response);
  }

  /// Log-out of the okto wallet
  Future<bool> logout() async {
    bool result = await tokenManager.deleteToken();
    return result;
  }

  Future openBottomSheet({
    required BuildContext context,

    /// Initial height of the bottom sheet
    /// Ranges from 0.1 to 1.0
    /// Default value is 0.7, which means the bottom sheet will take 70% of the screen height
    double height = 0.7,
    String textPrimaryColor = '0xFFFFFFFF',
    String textSecondaryColor = '0xFFFFFFFF',
    String textTertiaryColor = '0xFFFFFFFF',
    String accent1Color = '0xFF905BF5',
    String accent2Color = '0x80905BF5',
    String strokeBorderColor = '0xFFACACAB',
    String strokeDividerColor = '0x4DA8A8A8',
    String surfaceColor = '0xFF1F1F1F',
    String backgroundColor = '0xFF000000',
  }) async {
    final WebViewController controller = WebViewController();
    final authToken = await tokenManager.getAuthToken();
    final deviceToken = await tokenManager.getDeviceToken();
    String buildtype = '';
    switch (buildType) {
      case BuildType.sandbox:
        buildtype = 'SANDBOX';
        break;
      case BuildType.staging:
        buildtype = 'STAGING';
        break;
      case BuildType.production:
        buildtype = 'PRODUCTION';
        break;
    }

    String getInjectedJs() {
      String injectJs = '''
    window.localStorage.setItem('ENVIRONMENT', '$buildtype');
    window.localStorage.setItem('textPrimaryColor', '$textPrimaryColor');
    window.localStorage.setItem('textSecondaryColor', '$textSecondaryColor');
    window.localStorage.setItem('textTertiaryColor', '$textTertiaryColor');
    window.localStorage.setItem('accent1Color', '$accent1Color');
    window.localStorage.setItem('accent2Color', '$accent2Color');
    window.localStorage.setItem('strokeBorderColor', '$strokeBorderColor');
    window.localStorage.setItem('strokeDividerColor', '$strokeDividerColor');
    window.localStorage.setItem('surfaceColor', '$surfaceColor');
    window.localStorage.setItem('backgroundColor', '$backgroundColor');
  ''';

      if (authToken != null) {
        injectJs += "window.localStorage.setItem('authToken', '$authToken');";
        injectJs += "window.localStorage.setItem('deviceToken', '$deviceToken');";
      }
      return injectJs;
    }

    await showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      context: context,
      enableDrag: false,
      useSafeArea: true,
      isScrollControlled: true,
      builder: (BuildContext context) {
        controller
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setNavigationDelegate(
            NavigationDelegate(
              onProgress: (int progress) {},
              onPageStarted: (String url) {
                controller.runJavaScript(getInjectedJs());
              },
              onPageFinished: (String url) {},
              onHttpError: (HttpResponseError error) {},
              onWebResourceError: (WebResourceError error) {},
            ),
          )
          ..loadRequest(Uri.parse(switch (buildType) {
            BuildType.sandbox || BuildType.production => 'https://3p.okto.tech/',
            BuildType.staging => 'https://3p.oktostage.com/',
          }));

        return SizedBox(
          height: MediaQuery.of(context).size.height * height,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            child: WebViewWidget(
              controller: controller..clearCache()..clearLocalStorage(),
            ),
          ),
        );
      },
    );
  }
}
