// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:okto_flutter_sdk/src/models/client/auth_token_model.dart';
import 'package:okto_flutter_sdk/src/models/client/authentication_model.dart';
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
        tokenManager = TokenManager(HttpClient(apiKey: apiKey, buildType: buildType));

  // Factory constructor for testing
  @visibleForTesting
  factory Okto.test(String apiKey, BuildType buildType, HttpClient httpClient, TokenManager tokenManager) {
    return Okto._test(apiKey, buildType, httpClient, tokenManager);
  }

  // Private constructor for testing
  Okto._test(this.apiKey, this.buildType, this.httpClient, this.tokenManager);

  /// Method to authenticate a new user using the id token received from google_sign_in
  /// Pass the idToken received from google_sign_in to authenticate the user
  Future<dynamic> authenticate({required String idToken}) async {
    _idToken = idToken;
    final response = await httpClient.post(endpoint: '/api/v1/authenticate', body: {'id_token': idToken});
    if (response['data']['action'] == 'signup') {
      final authResponse = AuthenticationResponse.fromMap(response);
      _oktoToken = authResponse.data.token;
      return authResponse;
    } else {
      final authTokenResponse = AuthTokenResponse.fromMap(response);
      await tokenManager.storeTokens(authTokenResponse.data.authToken, authTokenResponse.data.refreshAuthToken, authTokenResponse.data.deviceToken);
      return authTokenResponse;
    }
  }

  /// Method to authenticate a user using the user id and JWT token
  /// This method gives an AUTH_TOKEN, REFRESH_AUTH_TOKEN and DEVICE_TOKEN
  /// Do not call [setPin] if you are authenticating with this method
  Future<AuthTokenResponse> authenticateWithUserId({required String userId, required String jwtToken}) async {
    _idToken = jwtToken;
    final response = await httpClient.post(endpoint: '/api/v1/jwt-authenticate', body: {'user_id': userId, 'auth_token': jwtToken});
    final authTokenResponse = AuthTokenResponse.fromMap(response);
    await tokenManager.storeTokens(authTokenResponse.data.authToken, authTokenResponse.data.refreshAuthToken, authTokenResponse.data.deviceToken);
    return authTokenResponse;
  }

  /// Necessary to set pin for the user after authentiction using [authenticate] method
  /// This method gives an AUTH_TOKEN, REFRESH_AUTH_TOKEN and DEVICE_TOKEN
  Future<AuthTokenResponse> setPin({required String pin}) async {
    if (_idToken == null) throw Exception('Id token is not set. Please authenticate with google sign in first.');
    if (_oktoToken == null) throw Exception('Okto Auth token is not set. Please authenticate first.');
    final response = await httpClient.post(endpoint: '/api/v1/set_pin', body: {
      'id_token': _idToken, // idToken from the google oauth2 provider
      'token': _oktoToken, // token received from the okto server after authentication
      'relogin_pin': pin, // new pin to be set
      'purpose': 'set_pin', // purpose of the request.
    });

    final authTokenResponse = AuthTokenResponse.fromMap(response);
    await tokenManager.storeTokens(authTokenResponse.data.authToken, authTokenResponse.data.refreshAuthToken, authTokenResponse.data.deviceToken);
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
    final response = await httpClient.get(endpoint: '/api/v1/user_from_token', authToken: authToken);
    return UserDetails.fromMap(response);
  }

  /// Method to create a new wallet for the user
  /// Returns a [WalletResponse] object
  Future<WalletResponse> createWallet() async {
    final authToken = await tokenManager.getAuthToken();
    final response = await httpClient.post(endpoint: '/api/v1/wallet', body: {}, authToken: authToken);
    print(response);
    return WalletResponse.fromMap(response);
  }

  /// Method to get the user wallets
  /// Returns a [WalletResponse] object
  Future<WalletResponse> getWallets() async {
    final authToken = await tokenManager.getAuthToken();
    final response = await httpClient.get(endpoint: '/api/v1/wallet', authToken: authToken);
    print(response);
    return WalletResponse.fromMap(response);
  }

  /// Method to get supported networks
  /// Returns a [NetworkDetails] object
  Future<NetworkDetails> supportedNetworks() async {
    final authToken = await tokenManager.getAuthToken();
    final response = await httpClient.get(endpoint: '/api/v1/supported/networks', authToken: authToken);
    print(response);
    return NetworkDetails.fromMap(response);
  }

  /// Method to get supported tokens with pagination
  /// Returns a [TokenResponse] object
  /// Default value of page is 1 and size is 10
  Future<TokenResponse> supportedTokens({int page = 1, int size = 10}) async {
    final authToken = await tokenManager.getAuthToken();
    final response = await httpClient.get(endpoint: '/api/v1/supported/tokens?page=$page&size=$size', authToken: authToken);
    print(response);
    return TokenResponse.fromMap(response);
  }

  /// Method to get the user portfolio
  /// Returns a [UserPortfolioResponse] object
  Future<UserPortfolioResponse> userPortfolio() async {
    final authToken = await tokenManager.getAuthToken();
    final response = await httpClient.get(endpoint: '/api/v1/portfolio', authToken: authToken);
    print(response);
    return UserPortfolioResponse.fromMap(response);
  }

  /// Method to get the user portfolio activity
  /// Returns a [UserPortfolioActivityResponse] object
  /// Default value of limit is 10 and offset is 1
  Future<UserPortfolioActivityResponse> getUserPortfolioActivity({int limit = 10, int offset = 1}) async {
    final authToken = await tokenManager.getAuthToken();
    final response = await httpClient.get(endpoint: '/api/v1/portfolio/activity?limit=$limit&offset=$offset', authToken: authToken);
    print(response);
    return UserPortfolioActivityResponse.fromMap(response);
  }

  /// Method to transfer tokens from one wallet to another
  /// Returns a [TransferTokenResponse] object
  /// Network Names: "APTOS", "BASE", "POLYGON", "POLYGON_TESTNET_AMOY", "SOLANA", "SOLANA_DEVNET",
  Future<TransferTokenResponse> transferTokens({required String networkName, String? tokenAddress, required String quantity, required String recipientAddress}) async {
    final authToken = await tokenManager.getAuthToken();
    final body = {"network_name": networkName, "token_address": tokenAddress, "quantity": quantity, "recipient_address": recipientAddress};
    final response = await httpClient.post(endpoint: '/api/v1/transfer/tokens/execute', body: body, authToken: authToken);
    print(response);
    return TransferTokenResponse.fromMap(response);
  }

  /// Method to get order history with optional filters
  /// Returns a [OrderHistoryResponse] object
  /// Default value of offset is 0 and limit is 1 and orderState is SUCCESS
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
    print(response);
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
    print(response);
    return TransferNftResponse.fromMap(response);
  }

  /// Method to get the order details for nft
  /// Returns a [OrderDetailsNftResponse] object
  /// Default value of page is 1 and size is 500
  /// Optional parameters: orderId, orderState
  Future<OrderDetailsNftResponse> orderDetailsNft({int page = 1, int size = 500, String? orderId, String? orderState}) async {
    final authToken = await tokenManager.getAuthToken();
    final queryParams = {'page': page.toString(), 'size': size.toString(), if (orderId != null) 'order_id': orderId, if (orderState != null) 'order_state': orderState};
    final queryString = Uri(queryParameters: queryParams).query;
    final response = await httpClient.get(endpoint: '/api/v1/nft/order_details?$queryString', authToken: authToken);
    print(response);
    return OrderDetailsNftResponse.fromMap(response);
  }

  /// Method to execute a raw transaction
  /// Returns a [RawTransactionExecuteResponse] object
  Future<RawTransactionExecuteResponse> rawTransactionExecute({required String networkName, required Map<String, dynamic> transaction}) async {
    final authToken = await tokenManager.getAuthToken();
    final response = await httpClient.post(
      endpoint: '/api/v1/rawtransaction/execute',
      body: {'network_name': networkName, 'transaction': transaction},
      authToken: authToken,
    );
    print(response);
    return RawTransactionExecuteResponse.fromMap(response);
  }

  /// Method to get the status of a raw transaction
  /// Returns a [RawTransactionStatusResponse] object
  /// Pass the orderId received from the [rawTransactionExecute] method
  Future<RawTransactionStatusResponse> rawTransactionStatus({required String orderId}) async {
    final authToken = await tokenManager.getAuthToken();
    final response = await httpClient.get(endpoint: '/api/v1/rawtransaction/status?order_id=$orderId', authToken: authToken);
    print(response);
    return RawTransactionStatusResponse.fromMap(response);
  }

  /// Log-out of the okto wallet
  Future<bool> logout() async {
    bool result = await tokenManager.deleteToken();
    return result;
  }

  /// Show Bottom Sheet
  Future openBottomSheet({
    required BuildContext context,

    /// Height ranges from 0.1 to 1.0
    /// It can be used to define the height of bottomsheet
    double height = 0.6,
    String textPrimaryColor = '0xFFFFFFFF',
    String textSecondaryColor = '0xFFFFFFFF',
    String textTertiaryColor = '0xFFFFFFFF',
    String accentColor = '0x80433454',
    String accent2Color = '0x80905BF5',
    String strokBorderColor = '0xFFACACAB',
    String strokDividerColor = '0x4DA8A8A8',
    String surfaceColor = '0xFF1F0A2F',
    String backgroundColor = '0xFF000000',
  }) async {
    WebViewController controller = WebViewController();
    final authToken = await tokenManager.getAuthToken();
    final draggableScrollableController = DraggableScrollableController();

    String getInjectedJs() {
      String injectJs = '''
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

      if (authToken != null) {
        injectJs += "window.localStorage.setItem('authToken', '$authToken');";
      }
      return injectJs;
    }

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
      ..loadRequest(Uri.parse('https://3p.okto.tech/'));

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      enableDrag: true,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          controller: draggableScrollableController,
          initialChildSize: height,
          builder: (_, ScrollController scrollController) {
            return Container(
              decoration: BoxDecoration(
                color: Color(int.parse(backgroundColor)),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                child: WebViewWidget(controller: controller),
              ),
            );
          },
        );
      },
    );
  }
}
