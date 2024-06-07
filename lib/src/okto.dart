// ignore_for_file: use_build_context_synchronously

import 'package:okto_wallet_sdk/src/models/client/authentication_model.dart';
import 'package:okto_wallet_sdk/src/models/client/network_model.dart';
import 'package:okto_wallet_sdk/src/models/client/auth_token_model.dart';
import 'package:okto_wallet_sdk/src/models/client/order_details_nft_model.dart';
import 'package:okto_wallet_sdk/src/models/client/order_history_model.dart';
import 'package:okto_wallet_sdk/src/models/client/raw_transaction_execute_model.dart';
import 'package:okto_wallet_sdk/src/models/client/transfer_token_model.dart';
import 'package:okto_wallet_sdk/src/models/client/user_model.dart';
import 'package:okto_wallet_sdk/src/models/client/user_portfilio_activity_model.dart';
import 'package:okto_wallet_sdk/src/models/client/user_portfolio_model.dart';
import 'package:okto_wallet_sdk/src/models/client/wallet_model.dart';
import 'package:okto_wallet_sdk/src/utils/enums.dart';
import 'package:okto_wallet_sdk/src/utils/http_client.dart';
import 'package:okto_wallet_sdk/src/utils/token_manager.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Okto {
  final String apiKey;
  final HttpClient httpClient;
  final TokenManager tokenManager;
  String? _oktoToken;
  String? _idToken;

  Okto(this.apiKey)
      : httpClient = HttpClient(apiKey: apiKey),
        tokenManager = TokenManager(HttpClient(apiKey: apiKey));

  /// POST
  /// Method to authenticate a new user using the id token received from google_sign_in
  Future<AuthenticationResponse> authenticate({required String idToken}) async {
    _idToken = idToken;
    final response = await httpClient.post(endpoint: '/api/v1/authenticate', body: {'id_token': idToken});
    final authResponse = AuthenticationResponse.fromMap(response);
    _oktoToken = authResponse.data.token;
    return authResponse;
  }

  /// POST
  /// Method to set a pin for the user
  Future<TokenResponse> setPin({required String pin}) async {
    if (_idToken == null) throw Exception('Id token is not set. Please authenticate with google sign in first.');
    if (_oktoToken == null) throw Exception('Okto Auth token is not set. Please authenticate first.');
    final response = await httpClient.post(endpoint: '/api/v1/set_pin', body: {
      'id_token': _idToken, // idToken from the google oauth2 provider
      'token': _oktoToken, // token received from the okto server after authentication
      'relogin_pin': pin, // new pin to be set
      'purpose': 'set_pin', // purpose of the request.
    });

    final tokenResponse = TokenResponse.fromMap(response);
    await tokenManager.storeTokens(tokenResponse.data.authToken, tokenResponse.data.refreshAuthToken, tokenResponse.data.deviceToken);
    return tokenResponse;
  }

  /// POST
  /// Method to refresh the user token
  Future refreshToken() async {
    await tokenManager.refreshToken();
  }

  /// GET
  /// Method to get the user details
  Future<UserDetails> userDetails() async {
    final authToken = await tokenManager.getAuthToken();
    final response = await httpClient.get(endpoint: '/api/v1/user_from_token', authToken: authToken);
    return UserDetails.fromMap(response);
  }

  /// POST
  /// Method to create a new wallet for the user
  Future<WalletResponse> createWallet() async {
    final authToken = await tokenManager.getAuthToken();
    final response = await httpClient.post(endpoint: '/api/v1/wallet', body: {}, authToken: authToken);
    return WalletResponse.fromMap(response);
  }

  /// GET
  /// Method to get the user wallets
  Future<WalletResponse> getWallets() async {
    final authToken = await tokenManager.getAuthToken();
    final response = await httpClient.get(endpoint: '/api/v1/user_wallets', authToken: authToken);
    return WalletResponse.fromMap(response);
  }

  /// GET
  /// Method to get supported networks
  Future<NetworkDetails> supportedNetworks() async {
    final authToken = await tokenManager.getAuthToken();
    final response = await httpClient.get(endpoint: '/api/v1/supported/networks', authToken: authToken);
    return NetworkDetails.fromMap(response);
  }

  /// GET
  /// Method to get supported tokens with pagination
  Future<TokenResponse> supportedTokens({int page = 1, int size = 10}) async {
    final authToken = await tokenManager.getAuthToken();
    final response = await httpClient.get(endpoint: '/api/v1/supported/tokens?page=$page&size=$size', authToken: authToken);
    return TokenResponse.fromMap(response);
  }

  /// GET
  /// Method to get the user portfolio
  Future<UserPortfolioResponse> userPortfolio() async {
    final authToken = await tokenManager.getAuthToken();
    final response = await httpClient.get(endpoint: '/api/v1/portfolio', authToken: authToken);
    return UserPortfolioResponse.fromMap(response);
  }

  /// GET
  /// Method to get the user portfolio activity
  Future<UserPortfolioActivityResponse> getUserPortfolioActivity({int limit = 10, int offset = 1}) async {
    final authToken = await tokenManager.getAuthToken();
    final response = await httpClient.get(endpoint: '/api/v1/portfolio/activity?limit=$limit&offset=$offset', authToken: authToken);
    return UserPortfolioActivityResponse.fromMap(response);
  }

  /// POST
  /// Method to transfer tokens from one wallet to another
  Future<TransferTokenResponse> transferTokens({required String networkName, required String tokenAddress, required String quantity, required String recipientAddress}) async {
    final authToken = await tokenManager.getAuthToken();
    final response = await httpClient.post(
        endpoint: '/api/v1/transfer',
        body: {
          'network_name': networkName,
          'token_address': tokenAddress,
          'quantity': quantity,
          'recipient_address': recipientAddress,
        },
        authToken: authToken);
    return TransferTokenResponse.fromMap(response);
  }

  /// GET
  /// Method to get order history with optional filters
  Future<OrderHistoryResponse> orderHistory({int offset = 0, int limit = 1, String? orderId, OrderState? orderState}) async {
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
    final queryParameters = {'offset': offset.toString(), 'limit': limit.toString(), if (orderId != null) 'order_id': orderId, if (orderState != null) 'order_state': orderStateToPass};
    final queryString = Uri(queryParameters: queryParameters).query;
    final response = await httpClient.get(endpoint: '/api/v1/orders?$queryString', authToken: authToken);
    return OrderHistoryResponse.fromMap(response);
  }

  /// POST
  /// Method to transfer nft
  Future<TransferTokenResponse> transferNft({
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

    return TransferTokenResponse.fromMap(response);
  }

  /// GET
  /// Method to get the order details for nft
  Future<OrderDetailsNftResponse> orderDetailsNft({int page = 1, int size = 500, String? orderId, String? orderState}) async {
    final authToken = await tokenManager.getAuthToken();
    final queryParams = {'page': page.toString(), 'size': size.toString(), if (orderId != null) 'order_id': orderId, if (orderState != null) 'order_state': orderState};
    final queryString = Uri(queryParameters: queryParams).query;
    final response = await httpClient.get(endpoint: '/api/v1/nft/order_details?$queryString', authToken: authToken);
    return OrderDetailsNftResponse.fromMap(response);
  }

  /// POST
  /// Method to execute a raw transaction
  Future<RawTransactionExecuteResponse> rawTransactionExecute(
      {required String networkName, required String fromAddress, required String toAddress, required String data, required String value}) async {
    final authToken = await tokenManager.getAuthToken();
    final response = await httpClient.post(
      endpoint: '/api/v1/rawtransaction/execute',
      body: {
        'network_name': networkName,
        'transaction': {'from': fromAddress, 'to': toAddress, 'data': data, 'value': value}
      },
      authToken: authToken,
    );
    return RawTransactionExecuteResponse.fromMap(response);
  }

  /// GET
  /// Method to get the status of a raw transaction
  Future<RawTransactionExecuteResponse> rawTransactionStatus({required String orderId}) async {
    final authToken = await tokenManager.getAuthToken();
    final response = await httpClient.get(endpoint: '/api/v1/rawtransaction/status?order_id=$orderId', authToken: authToken);
    return RawTransactionExecuteResponse.fromMap(response);
  }

  /// Show Bottom Sheet
  Future openBottomSheet({
    required BuildContext context,
    String textPrimaryColor = '0xFFFFFFFF',
    String textSecondaryColor = '0xFF000000',
    String textTertiaryColor = '0xFF000000',
    String accentColor = '0x80433454',
    String accent2Color = '0x80905BF5',
    String strokBorderColor = '0xFFACACAB',
    String strokDividerColor = '0x4DA8A8A8',
    String surfaceColor = '0xFF1F0A2F',
    String backgroundColor = '0xFF000000',
  }) async {
    late final WebViewController controller;
    final authToken = await tokenManager.getAuthToken();

    void runJavaScriptParameters() {
      final jsCode = '''
      window.localStorage.setItem('authToken', $authToken);
      window.localStorage.setItem('textPrimaryColor', '$textPrimaryColor');
      window.localStorage.setItem('textSecondaryColor', '$textSecondaryColor');
      window.localStorage.setItem('textTertiaryColor', '$textTertiaryColor');
      window.localStorage.setItem('accentColor', '$accentColor');
      window.localStorage.setItem('accent2Color', '$accent2Color');
      window.localStorage.setItem('strokBorderColor', '$strokBorderColor');
      window.localStorage.setItem('strokDividerColor', '$strokDividerColor');
      window.localStorage.setItem('surfaceColor', '$surfaceColor');
      window.localStorage.setItem('backgroundColor', '$backgroundColor');
    ''';
      controller.runJavaScript(jsCode);
    }

    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          controller = WebViewController()
            ..setJavaScriptMode(JavaScriptMode.unrestricted)
            ..setBackgroundColor(const Color(0x00000000))
            ..setNavigationDelegate(
              NavigationDelegate(
                onProgress: (int progress) {},
                onPageStarted: (String url) {
                  runJavaScriptParameters();
                },
                onPageFinished: (String url) {},
                onHttpError: (HttpResponseError error) {},
                onWebResourceError: (WebResourceError error) {},
              ),
            )
            ..loadRequest(Uri.parse('https://3p.okto.tech/'));
          return WebViewWidget(controller: controller);
        });
  }
}
