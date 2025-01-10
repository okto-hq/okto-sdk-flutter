import 'package:flutter/material.dart';
import 'package:okto_flutter_sdk/okto_flutter_sdk.dart';
import 'package:okto_flutter_sdk/src/models/auth_type.dart';
import 'package:okto_flutter_sdk/src/ui/onboarding_screen.dart';
import 'package:okto_flutter_sdk/src/utils/enums.dart';
import 'package:okto_flutter_sdk/src/utils/http_client.dart';
import 'package:okto_flutter_sdk/src/utils/token_manager.dart';
import 'package:okto_flutter_sdk/src/utils/utility.dart';
import 'package:okto_network_manager/service_config.dart';
import 'package:okto_sdk/core/repository/auth.dart';
import 'package:okto_sdk/core/repository/sdk_repository_provider.dart';
import 'package:okto_sdk/core/sdk_client/sdk_core.dart';
import 'package:okto_sdk/network/models/activity_data_v2.dart';
import 'package:okto_sdk/network/models/client/auth_token_model.dart';
import 'package:okto_sdk/network/models/client/order_history_model_v2.dart';
import 'package:okto_sdk/network/models/client/otp_response.dart';
import 'package:okto_sdk/network/models/client/raw_transaction_execute_model.dart';
import 'package:okto_sdk/network/models/client/raw_transaction_status_model.dart';
import 'package:okto_sdk/network/models/client/transfer_nft_model.dart';
import 'package:okto_sdk/network/models/client/user_model.dart';
import 'package:okto_sdk/network/models/client/wallet_model.dart';
import 'package:okto_sdk/network/models/nft_data_v2.dart';
import 'package:okto_sdk/network/models/order_response_v2.dart';
import 'package:okto_sdk/network/models/portfolio_data_v2.dart';
import 'package:okto_sdk/network/models/wallet_data_v2.dart';
import 'package:okto_sdk/network/models/whitelisted_network_data_v2.dart';
import 'package:okto_sdk/network/models/whitelisted_token_data_v2.dart';
import 'package:okto_sdk/okto_flutter_sdk.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'models/nft_order_details_v2.dart';

class Okto {
  /// Client Side Api Key received from OKto
  final String apiKey;
  final BuildType buildType;

  Okto(this.apiKey, this.buildType) {
    _initializeSdk();
  }

  _initializeSdk() async {
    final baseUrl = Utility.getBaseUrl(buildType);
    final serviceConfig = ServiceConfig(
        appName: "okto_sdk",
        baseUrls: <String, String>{
          "bff": baseUrl,
          "auth": baseUrl,
          "portfolio": baseUrl,
          "oms": baseUrl
        },
        rpcBaseUrl: Utility.getRpcBaseUrl(buildType));
    await OktoSdk().init(
        OktoCore(
            id: "",
            privateKey: "",
            apiKey: apiKey,
            maxPriorityFeePerGas: "",
            maxFeePerGas: ""),
        oktoServiceConfig: serviceConfig);
  }

  // Factory constructor for testing
  @visibleForTesting
  factory Okto.test(String apiKey, BuildType buildType) {
    return Okto._test(apiKey, buildType);
  }

  // Private constructor for testing
  Okto._test(this.apiKey, this.buildType);

  /// Method to authenticate a new user using the id token received from google_sign_in
  /// Pass the idToken received from google_sign_in to authenticate the user
  Future<AuthTokenData> authenticate({required String idToken}) async {
    final AuthTokenData response = await OktoSdk().loginWithIdToken(idToken);
    return response;
  }

  /// Method to authenticate a user using the user id and JWT token
  /// This method gives an AUTH_TOKEN, REFRESH_AUTH_TOKEN and DEVICE_TOKEN
  Future<AuthTokenData> authenticateWithUserId(
      {required String userId, required String jwtToken}) async {
    final authTokenResponse = await OktoSdk()
        .authenticateWithUserId(userId: userId, jwtToken: jwtToken);
    return authTokenResponse;
  }

  /// To send OTP to the given [email].
  /// returns an token along with OTP which will be used to verify the OTP.
  Future<OtpResponse?> sendEmailOtp({required String email}) async {
    try {
      return await OktoSdk().sendEmailOtp(email: email);
    } catch (e) {
      rethrow;
    }
  }

  /// Verify the OTP providing [emailId], [otp] and [token] provided with sendEmailOtp().
  Future<AuthTokenData> verifyEmailOtp(
      {required String emailId,
      required String otp,
      required String token}) async {
    final AuthTokenData response =
        await OktoSdk().verifyEmailOtp(email: emailId, otp: otp, token: token);
    return response;
  }

  /// To send OTP to the given [phoneNumber].
  /// returns an token along with OTP which will be used to verify the OTP.
  Future<OtpResponse?> sendPhoneOtp(
      {required String phoneNumber, String countryCode = "IN"}) async {
    try {
      final response = await OktoSdk()
          .sendPhoneOtp(phoneNumber: phoneNumber, countryCode: countryCode);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// Verify the OTP providing [phoneNumber], [otp] and [token] provided with sendEmailOtp().
  Future<AuthTokenData> verifyPhoneOtp(
      {required String phoneNumber,
      required String otp,
      required String token,
      String countryCode = "IN"}) async {
    final response = await OktoSdk().verifyPhoneOtp(
        phoneNumber: phoneNumber,
        countryCode: countryCode,
        otp: otp,
        token: token);
    return response;
  }

  /// Use to check if the current session in the app is logged in or not.
  /// Use this method to show login page or home page for an user.
  Future<bool> isLoggedIn() async {
    try {
      final authToken = await OktoSdk().getAuthToken();
      return authToken?.isNotEmpty == true;
    } catch (e) {
      return false;
    }
  }

  /// POST
  /// Method to refresh the user auth token.
  /// @returns: [AuthTokenData]
  Future<AuthTokenData> refreshToken() async {
    final refreshToken = await OktoSdk().refreshAuthToken();
    return refreshToken;
  }

  /// Method to get the user details
  /// Returns an [UserDetails] object
  Future<UserData> userDetails() async {
    final response = await OktoSdk().getUserInfo();
    return response;
  }

  /// Method to create a new wallet for the user
  /// Returns a [WalletResponse] object
  Future<WalletsData?> createWallet() async {
    final WalletsData? response = await OktoSdk().oktoUserClient?.createWallet();
    return response;
  }

  /// Method to get the user wallets
  /// Returns a [WalletDataV2] object
  Future<WalletDataV2?> getWallets() async {
    final response = await OktoSdk().oktoUserClient?.getWallets();
    return response;
  }

  /// Method to get supported networks
  /// Returns a [WhitelistedNetworkDataV2] object
  Future<WhitelistedNetworkDataV2?> supportedNetworks() async {
    final response = await OktoSdk().oktoUserClient?.getSupportedNetworks();
    return response;
  }

  /// Method to get supported tokens with pagination
  /// Returns a [WhitelistedTokenDataV2] object
  /// Default value of page is 1 and size is 10
  Future<WhitelistedTokenDataV2?> supportedTokens(
      {int page = 1, int size = 10}) async {
    final response =
        await OktoSdk().oktoUserClient?.getAllTokens(limit: page, offset: size);
    return response;
  }

  /// Method to get the user portfolio
  /// Returns a [PortfolioDataV2] object
  Future<PortfolioDataV2?> userPortfolio() async {
    final response = await OktoSdk().oktoUserClient?.getCryptoPortfolio();
    return response;
  }

  /// Method to get the user portfolio activity
  /// Returns a [UserPortfolioActivityResponse] object
  /// Default value of limit is 10 and offset is 1
  Future<ActivityDataV2?> getUserPortfolioActivity(
      {int limit = 10, int offset = 1}) async {
    final ActivityDataV2? response = await OktoSdk()
        .oktoUserClient
        ?.getUserActivity(size: limit, page: offset);
    return response;
  }

  /// Method to transfer tokens from one wallet to another
  /// Returns a [OmsDataV2] object
  /// Network Names: "APTOS", "BASE", "POLYGON", "POLYGON_TESTNET_AMOY", "SOLANA", "SOLANA_DEVNET",
  Future<OrderResponseV2?> transferTokens(
      {required String networkName,
      String? tokenAddress,
      required String quantity,
      required String recipientAddress}) async {
    final response = await OktoSdk().oktoUserClient?.executeTransaction(
        networkName: networkName,
        quantity: quantity,
        recipientAddress: recipientAddress);
    return response;
  }

  /// Method to get order history with optional filters
  /// Returns a [OrderHistoryResponse] object
  /// Default value of offset is 0 and limit is 1 and orderState is SUCCESS
  Future<OrderHistoryResponseV2?> orderHistory(
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
    final response = await OktoSdk().oktoUserClient?.getOrdersHistory(
        page: offset,
        size: limit,
        intentType: 'TOKEN_TRANSFER',
        orderId: orderId,
        orderState: orderStateToPass);
    return response;
  }

  /// Method to transfer nft
  /// Returns a [TransferNftResponse] object
  /// Operation Types: "NFT_TRANSFER"
  Future<TransferNftResponse?> transferNft({
    required String operationType,
    required String networkName,
    required String collectionAddress,
    required String collectionName,
    required String quantity,
    required String recipientAddress,
    required String nftAddress,
  }) async {
    final response = await OktoSdk().oktoUserClient?.nftTransfer(
        operationType: operationType,
        networkName: networkName,
        collectionAddress: collectionAddress,
        collectionName: collectionName,
        quantity: quantity,
        recipientAddress: recipientAddress,
        nftAddress: nftAddress);
    return response;
  }

  /// Method to get the order details for nft
  /// Returns a [NftOrderDetailsV2] object
  /// Default value of page is 1 and size is 500
  /// Optional parameters: orderId, orderState
  Future<NftDataV2?> orderDetailsNft(
      {int page = 1,
      int size = 500,
      String? orderId,
      String? orderState}) async {
    final response = await OktoSdk().oktoUserClient?.getNftPortfolio(
        page: page.toString(),
        offset: size.toString(),
        orderId: orderId,
        orderState: orderState);
    return response;
  }

  /// Method to execute a raw transaction
  /// Returns a [RawTransactionExecuteResponse] object
  Future<RawTransactionExecuteResponse?> rawTransactionExecute(
      {required String networkName,
      required Map<String, dynamic> transaction}) async {
    final response = await OktoSdk().oktoUserClient?.rawTransactionExecute(
        networkName: networkName, transaction: transaction);
    return response;
  }

  /// Method to get the status of a raw transaction
  /// Returns a [RawTransactionStatusResponse] object
  /// Pass the orderId received from the [rawTransactionExecute] method
  Future<RawTransactionStatusResponse?> rawTransactionStatus(
      {required String orderId}) async {
    final response =
        await OktoSdk().oktoUserClient?.rawTransactionStatus(orderId: orderId);
    return response;
  }

  /// Log-out of the okto wallet
  Future<bool> logout() async {
    bool result = await OktoSdk().logout();
    return result;
  }

  /// [gAuthCallback] : Implement this for G-auth, this will return
  /// idToken which will authenticated using by Okto auth service.
  /// [onLoginSuccess] : Implement this when user logged in successfully.
  /// We save auth details to local storage which later can be accessed
  /// to access other flow.
  /// [primaryAuth] : Default login method eg: Phone, Email or GAuth.
  /// User can change later according to his preference.
  /// [title] : The vendor's brand name, that will be shown on login page.
  /// [iconUrl] : Vendor's brand image URL, that will be shown on login page
  Future<void> openOnboarding(
      {required BuildContext context,
      String textPrimaryColor = '0xFFFFFFFF',
      String textSecondaryColor = '0xB3FFFFFF',
      String textTertiaryColor = '0xffA8A8A8',
      String accent1Color = '0xFF905BF5',
      String accent2Color = '0x80905BF5',
      String strokeBorderColor = '0xFFACACAB',
      String strokeDividerColor = '0x4DA8A8A8',
      String surfaceColor = '0xFF1F1F1F',
      String backgroundColor = '0xFF000000',
      String iconUrl = '',
      String title = '',
      String subtitle = '',
      AuthType primaryAuth = AuthType.Email,
      required Future<String> Function() gAuthCallback,
      required Function onLoginSuccess}) async {
    String buildtype = '';
    switch (buildType) {
      case BuildType.sandbox:
        buildtype = 'SANDBOX';
        break;
      case BuildType.staging:
        buildtype = 'SANDBOX';
        break;
      case BuildType.production:
        buildtype = 'SANDBOX';
        break;
    }

    String getInjectedJs() {
      String injectJs = '''
        window.localStorage.setItem('ENVIRONMENT', '$buildtype');
        window.localStorage.setItem('API_KEY', '$apiKey');
        window.localStorage.setItem('textPrimaryColor', '$textPrimaryColor');
        window.localStorage.setItem('textSecondaryColor', '$textSecondaryColor');
        window.localStorage.setItem('textTertiaryColor', '$textTertiaryColor');
        window.localStorage.setItem('accent1Color', '$accent1Color');
        window.localStorage.setItem('accent2Color', '$accent2Color');
        window.localStorage.setItem('strokeBorderColor', '$strokeBorderColor');
        window.localStorage.setItem('strokeDividerColor', '$strokeDividerColor');
        window.localStorage.setItem('surfaceColor', '$surfaceColor');
        window.localStorage.setItem('backgroundColor', '$backgroundColor');
        window.localStorage.setItem('primaryAuthType', '${primaryAuth.name}');
        window.localStorage.setItem('brandTitle', '$title');
        window.localStorage.setItem('brandSubtitle', '$subtitle');
        window.localStorage.setItem('brandIconUrl', '$iconUrl');
      ''';
      return injectJs;
    }

    final url = switch (buildType) {
      BuildType.sandbox =>
        'https://okto-sandbox.firebaseapp.com/#/login_screen',
      BuildType.production =>
        'https://3p.okto.tech/login_screen/#/login_screen',
      BuildType.staging => 'https://3p.oktostage.com/#/login_screen',
    };

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => OnboardingScreen(
                  javaScript: getInjectedJs(),
                  url: url,
                  gAuthCallback: gAuthCallback,
                  loginCallback: (AuthTokenData data) {
                    // tokenManager.storeTokens(data.authToken,
                    //     data.refreshAuthToken, data.deviceToken);
                    onLoginSuccess.call();
                  },
                )));
  }

  Future openBottomSheet({
    required BuildContext context,

    /// Initial height of the bottom sheet
    /// Ranges from 0.1 to 1.0
    /// Default value is 0.7, which means the bottom sheet will take 70% of the screen height
    double height = 0.9,
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
    final authToken = await OktoSdk().oktoUserClient?.authToken ?? "";
    final deviceToken = await OktoSdk().oktoUserClient?.deviceToken ?? "";
    String buildtype = '';
    switch (buildType) {
      case BuildType.sandbox:
        buildtype = 'SANDBOX';
        break;
      case BuildType.staging:
        buildtype = 'SANDBOX';
        break;
      case BuildType.production:
        buildtype = 'SANDBOX';
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

      if (authToken.isNotEmpty) {
        injectJs += "window.localStorage.setItem('authToken', '$authToken');";
        injectJs +=
            "window.localStorage.setItem('deviceToken', '$deviceToken');";
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
            BuildType.sandbox => 'https://okto-sandbox.firebaseapp.com',
            BuildType.production => 'https://3p.okto.tech/',
            BuildType.staging => 'https://3p.oktostage.com/',
          }));

        return LayoutBuilder(builder: (context, constraints) {
          return SizedBox(
            height: constraints.maxHeight * height,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              child: WebViewWidget(
                controller: controller
                  ..clearCache()
                  ..clearLocalStorage(),
              ),
            ),
          );
        });
      },
    );
  }
}
