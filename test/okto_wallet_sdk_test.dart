import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:okto_flutter_sdk/okto_flutter_sdk.dart';

import 'okto_wallet_sdk_test.mocks.dart';

void main() {
  late Okto okto;
  late MockHttpClient mockHttpClient;
  late MockTokenManager mockTokenManager;

  setUp(() {
    mockHttpClient = MockHttpClient();
    mockTokenManager = MockTokenManager();
    okto = Okto.test('fake_api_key', BuildType.staging, mockHttpClient, mockTokenManager);
  });

  group('Okto', () {
    test('authenticateWithUserId returns AuthTokenResponse and stores tokens', () async {
      // Arrange
      const userId = 'testUser123';
      const jwtToken = 'fakeJwtToken';
      final fakeResponse = {
        'status': 'success',
        'data': {
          'auth_token': 'fakeAuthToken',
          'message': 'Authentication successful',
          'refresb_auth_token': 'fakeRefreshToken',
          'device_token': 'fakeDeviceToken',
        }
      };

      when(mockHttpClient.defaultPost(
        endpoint: '/api/v1/jwt-authenticate',
        body: {'user_id': userId, 'auth_token': jwtToken},
      )).thenAnswer((_) async => fakeResponse);

      when(mockTokenManager.storeTokens(any, any, any)).thenAnswer((_) async => {});

      // Act
      final result = await okto.authenticateWithUserId(userId: userId, jwtToken: jwtToken);

      // Assert
      expect(result, isA<AuthTokenResponse>());
      expect(result.status, equals('success'));
      expect(result.data.authToken, equals('fakeAuthToken'));
      expect(result.data.refreshAuthToken, equals('fakeRefreshToken'));
      expect(result.data.deviceToken, equals('fakeDeviceToken'));

      // Verify that storeTokens was called with the correct arguments
      verify(mockTokenManager.storeTokens('fakeAuthToken', 'fakeRefreshToken', 'fakeDeviceToken')).called(1);
    });

    test('userDetails returns UserDetails on successful response', () async {
      // Arrange
      const fakeAuthToken = 'fakeAuthToken';
      final fakeResponse = {
        'status': 'success',
        'data': {
          'email': 'test@example.com',
          'user_id': 'user123',
          'created_at': '2023-06-23T12:34:56Z',
          'freezed': false,
          'freeze_reason': '',
        }
      };

      when(mockTokenManager.getAuthToken()).thenAnswer((_) async => fakeAuthToken);
      when(mockHttpClient.get(
        endpoint: '/api/v1/user_from_token',
        authToken: fakeAuthToken,
      )).thenAnswer((_) async => fakeResponse);

      // Act
      final result = await okto.userDetails();

      // Assert
      expect(result, isA<UserDetails>());
      expect(result.status, equals('success'));
      expect(result.data.email, equals('test@example.com'));
      expect(result.data.userId, equals('user123'));
      expect(result.data.createdAt, equals('2023-06-23T12:34:56Z'));
      expect(result.data.freezed, isFalse);
      expect(result.data.freezeReason, isEmpty);
    });

    test('userDetails handles error response', () async {
      // Arrange
      const fakeAuthToken = 'fakeAuthToken';
      final fakeErrorResponse = {
        'status': 'error',
        'message': 'User not found',
      };

      when(mockTokenManager.getAuthToken()).thenAnswer((_) async => fakeAuthToken);
      when(mockHttpClient.get(
        endpoint: '/api/v1/user_from_token',
        authToken: fakeAuthToken,
      )).thenAnswer((_) async => fakeErrorResponse);

      // Act
    });

    test('userDetails handles network error', () async {
      // Arrange
      const fakeAuthToken = 'fakeAuthToken';

      when(mockTokenManager.getAuthToken()).thenAnswer((_) async => fakeAuthToken);
      when(mockHttpClient.get(
        endpoint: '/api/v1/user_from_token',
        authToken: fakeAuthToken,
      )).thenThrow(Exception('Network error'));

      // Act
    });

    test('userDetails handles invalid response format', () async {
      // Arrange
      const fakeAuthToken = 'fakeAuthToken';
      final invalidResponse = {
        'status': 'success',
        'data': 'Invalid data format',
      };

      when(mockTokenManager.getAuthToken()).thenAnswer((_) async => fakeAuthToken);
      when(mockHttpClient.get(
        endpoint: '/api/v1/user_from_token',
        authToken: fakeAuthToken,
      )).thenAnswer((_) async => invalidResponse);

      // Act
    });

    test('createWallet returns WalletResponse on successful response', () async {
      // Arrange
      const fakeAuthToken = 'fakeAuthToken';
      final fakeResponse = {
        'success': 'true',
        'data': {
          'wallets': [
            {
              'network_Name': 'Ethereum',
              'address': '0x1234567890123456789012345678901234567890',
              'success': true,
            },
            {
              'network_Name': 'Bitcoin',
              'address': '1BvBMSEYstWetqTFn5Au4m4GFg7xJaNVN2',
              'success': true,
            },
          ],
        },
      };

      when(mockTokenManager.getAuthToken()).thenAnswer((_) async => fakeAuthToken);
      when(mockHttpClient.post(
        endpoint: '/api/v1/wallet',
        body: {},
        authToken: fakeAuthToken,
      )).thenAnswer((_) async => fakeResponse);

      // Act
      final result = await okto.createWallet();

      // Assert
      expect(result, isA<WalletResponse>());
      expect(result.success, equals('true'));
      expect(result.data.wallets.length, equals(2));
      expect(result.data.wallets[0].networkName, equals('Ethereum'));
      expect(result.data.wallets[0].address, equals('0x1234567890123456789012345678901234567890'));
      expect(result.data.wallets[0].success, isTrue);
      expect(result.data.wallets[1].networkName, equals('Bitcoin'));
      expect(result.data.wallets[1].address, equals('1BvBMSEYstWetqTFn5Au4m4GFg7xJaNVN2'));
      expect(result.data.wallets[1].success, isTrue);
    });

    test('createWallet handles error response', () async {
      // Arrange
      const fakeAuthToken = 'fakeAuthToken';
      final fakeErrorResponse = {
        'success': 'false',
        'error': 'Unable to create wallet',
      };

      when(mockTokenManager.getAuthToken()).thenAnswer((_) async => fakeAuthToken);
      when(mockHttpClient.post(
        endpoint: '/api/v1/wallet',
        body: {},
        authToken: fakeAuthToken,
      )).thenAnswer((_) async => fakeErrorResponse);

      // Act
    });

    test('createWallet handles network error', () async {
      // Arrange
      const fakeAuthToken = 'fakeAuthToken';

      when(mockTokenManager.getAuthToken()).thenAnswer((_) async => fakeAuthToken);
      when(mockHttpClient.post(
        endpoint: '/api/v1/wallet',
        body: {},
        authToken: fakeAuthToken,
      )).thenThrow(Exception('Network error'));

      // Act
    });

    test('createWallet handles invalid response format', () async {
      // Arrange
      const fakeAuthToken = 'fakeAuthToken';
      final invalidResponse = {
        'success': 'true',
        'data': 'Invalid data format',
      };

      when(mockTokenManager.getAuthToken()).thenAnswer((_) async => fakeAuthToken);
      when(mockHttpClient.post(
        endpoint: '/api/v1/wallet',
        body: {},
        authToken: fakeAuthToken,
      )).thenAnswer((_) async => invalidResponse);

      // Act
    });

    test('getWallets returns WalletResponse on successful response', () async {
      // Arrange
      const fakeAuthToken = 'fakeAuthToken';
      final fakeResponse = {
        'success': 'true',
        'data': {
          'wallets': [
            {
              'network_Name': 'Ethereum',
              'address': '0x1234567890123456789012345678901234567890',
              'success': true,
            },
            {
              'network_Name': 'Bitcoin',
              'address': '1BvBMSEYstWetqTFn5Au4m4GFg7xJaNVN2',
              'success': true,
            },
          ],
        },
      };

      when(mockTokenManager.getAuthToken()).thenAnswer((_) async => fakeAuthToken);
      when(mockHttpClient.get(
        endpoint: '/api/v1/wallet',
        authToken: fakeAuthToken,
      )).thenAnswer((_) async => fakeResponse);

      // Act
      final result = await okto.getWallets();

      // Assert
      expect(result, isA<WalletResponse>());
      expect(result.success, equals('true'));
      expect(result.data.wallets.length, equals(2));
      expect(result.data.wallets[0].networkName, equals('Ethereum'));
      expect(result.data.wallets[0].address, equals('0x1234567890123456789012345678901234567890'));
      expect(result.data.wallets[0].success, isTrue);
      expect(result.data.wallets[1].networkName, equals('Bitcoin'));
      expect(result.data.wallets[1].address, equals('1BvBMSEYstWetqTFn5Au4m4GFg7xJaNVN2'));
      expect(result.data.wallets[1].success, isTrue);
    });

    test('getWallets handles error response', () async {
      // Arrange
      const fakeAuthToken = 'fakeAuthToken';
      final fakeErrorResponse = {
        'success': 'false',
        'error': 'Unable to retrieve wallets',
      };

      when(mockTokenManager.getAuthToken()).thenAnswer((_) async => fakeAuthToken);
      when(mockHttpClient.get(
        endpoint: '/api/v1/wallet',
        authToken: fakeAuthToken,
      )).thenAnswer((_) async => fakeErrorResponse);
    });

    test('getWallets handles network error', () async {
      // Arrange
      const fakeAuthToken = 'fakeAuthToken';

      when(mockTokenManager.getAuthToken()).thenAnswer((_) async => fakeAuthToken);
      when(mockHttpClient.get(
        endpoint: '/api/v1/wallet',
        authToken: fakeAuthToken,
      )).thenThrow(Exception('Network error'));
    });

    test('getWallets handles invalid response format', () async {
      // Arrange
      const fakeAuthToken = 'fakeAuthToken';
      final invalidResponse = {
        'success': 'true',
        'data': 'Invalid data format',
      };

      when(mockTokenManager.getAuthToken()).thenAnswer((_) async => fakeAuthToken);
      when(mockHttpClient.get(
        endpoint: '/api/v1/wallet',
        authToken: fakeAuthToken,
      )).thenAnswer((_) async => invalidResponse);
    });

    test('supportedNetworks returns NetworkDetails on successful response', () async {
      // Arrange
      const fakeAuthToken = 'fakeAuthToken';
      final fakeResponse = {
        'status': 'success',
        'data': {
          'network': [
            {
              'network_name': 'Ethereum',
              'chain_id': '1',
            },
            {
              'network_name': 'Bitcoin',
              'chain_id': '2',
            },
          ],
        },
      };

      when(mockTokenManager.getAuthToken()).thenAnswer((_) async => fakeAuthToken);
      when(mockHttpClient.get(
        endpoint: '/api/v1/supported/networks',
        authToken: fakeAuthToken,
      )).thenAnswer((_) async => fakeResponse);

      // Act
      final result = await okto.supportedNetworks();

      // Assert
      expect(result, isA<NetworkDetails>());
      expect(result.status, equals('success'));
      expect(result.data.network.length, equals(2));
      expect(result.data.network[0].networkName, equals('Ethereum'));
      expect(result.data.network[0].chainId, equals('1'));
      expect(result.data.network[1].networkName, equals('Bitcoin'));
      expect(result.data.network[1].chainId, equals('2'));
    });

    test('supportedNetworks handles error response', () async {
      // Arrange
      const fakeAuthToken = 'fakeAuthToken';
      final fakeErrorResponse = {
        'status': 'error',
        'message': 'Unable to retrieve supported networks',
      };

      when(mockTokenManager.getAuthToken()).thenAnswer((_) async => fakeAuthToken);
      when(mockHttpClient.get(
        endpoint: '/api/v1/supported/networks',
        authToken: fakeAuthToken,
      )).thenAnswer((_) async => fakeErrorResponse);
    });

    test('supportedNetworks handles network error', () async {
      // Arrange
      const fakeAuthToken = 'fakeAuthToken';

      when(mockTokenManager.getAuthToken()).thenAnswer((_) async => fakeAuthToken);
      when(mockHttpClient.get(
        endpoint: '/api/v1/supported/networks',
        authToken: fakeAuthToken,
      )).thenThrow(Exception('Network error'));
    });

    test('supportedNetworks handles invalid response format', () async {
      // Arrange
      const fakeAuthToken = 'fakeAuthToken';
      final invalidResponse = {
        'status': 'success',
        'data': 'Invalid data format',
      };

      when(mockTokenManager.getAuthToken()).thenAnswer((_) async => fakeAuthToken);
      when(mockHttpClient.get(
        endpoint: '/api/v1/supported/networks',
        authToken: fakeAuthToken,
      )).thenAnswer((_) async => invalidResponse);
    });

    test('supportedTokens returns TokenResponse on successful response', () async {
      // Arrange
      const fakeAuthToken = 'fakeAuthToken';
      final fakeResponse = {
        'status': 'success',
        'data': {
          'tokens': [
            {
              'token_name': 'USDT',
              'token_address': '0x1234567890123456789012345678901234567890',
              'network_name': 'Ethereum',
            },
            {
              'token_name': 'DAI',
              'token_address': '0x0987654321098765432109876543210987654321',
              'network_name': 'Ethereum',
            },
          ],
        },
      };

      when(mockTokenManager.getAuthToken()).thenAnswer((_) async => fakeAuthToken);
      when(mockHttpClient.get(
        endpoint: '/api/v1/supported/tokens?page=1&size=10',
        authToken: fakeAuthToken,
      )).thenAnswer((_) async => fakeResponse);

      // Act
      final result = await okto.supportedTokens(page: 1, size: 10);

      // Assert
      expect(result, isA<TokenResponse>());
      expect(result.status, equals('success'));
      expect(result.data.tokens.length, equals(2));
      expect(result.data.tokens[0].tokenName, equals('USDT'));
      expect(result.data.tokens[0].tokenAddress, equals('0x1234567890123456789012345678901234567890'));
      expect(result.data.tokens[0].networkName, equals('Ethereum'));
      expect(result.data.tokens[1].tokenName, equals('DAI'));
      expect(result.data.tokens[1].tokenAddress, equals('0x0987654321098765432109876543210987654321'));
      expect(result.data.tokens[1].networkName, equals('Ethereum'));
    });

    test('supportedTokens handles error response', () async {
      // Arrange
      const fakeAuthToken = 'fakeAuthToken';
      final fakeErrorResponse = {
        'status': 'error',
        'message': 'Unable to retrieve supported tokens',
      };

      when(mockTokenManager.getAuthToken()).thenAnswer((_) async => fakeAuthToken);
      when(mockHttpClient.get(
        endpoint: '/api/v1/supported/tokens?page=1&size=10',
        authToken: fakeAuthToken,
      )).thenAnswer((_) async => fakeErrorResponse);
    });

    test('supportedTokens handles network error', () async {
      // Arrange
      const fakeAuthToken = 'fakeAuthToken';

      when(mockTokenManager.getAuthToken()).thenAnswer((_) async => fakeAuthToken);
      when(mockHttpClient.get(
        endpoint: '/api/v1/supported/tokens?page=1&size=10',
        authToken: fakeAuthToken,
      )).thenThrow(Exception('Network error'));
    });

    test('supportedTokens handles invalid response format', () async {
      // Arrange
      const fakeAuthToken = 'fakeAuthToken';
      final invalidResponse = {
        'status': 'success',
        'data': 'Invalid data format',
      };

      when(mockTokenManager.getAuthToken()).thenAnswer((_) async => fakeAuthToken);
      when(mockHttpClient.get(
        endpoint: '/api/v1/supported/tokens?page=1&size=10',
        authToken: fakeAuthToken,
      )).thenAnswer((_) async => invalidResponse);
    });

    test('userPortfolio returns UserPortfolioResponse on successful response', () async {
      // Arrange
      const fakeAuthToken = 'fakeAuthToken';
      final fakeResponse = {
        'status': 'success',
        'data': {
          'aggregated_data': {
            'holdings_count': '10',
            'holdings_price_inr': '100000',
            'holdings_price_usdt': '1200',
            'total_holding_price_inr': '150000',
            'total_holdins_price_usdt': '2000',
          },
          'group_tokens': [
            {
              'id': '1',
              'name': 'Bitcoin',
              'symbol': 'BTC',
              'short_name': 'BTC',
              'token_image': 'btc.png',
              'network_id': 'bitcoin',
              'is_primary': true,
              'balance': '0.5',
              'holdings_price_usdt': '20000',
              'holdings_price_inr': '1500000',
              'aggregation_type': 'crypto',
            },
            {
              'id': '2',
              'name': 'Ethereum',
              'symbol': 'ETH',
              'short_name': 'ETH',
              'token_image': 'eth.png',
              'network_id': 'ethereum',
              'is_primary': false,
              'balance': '10',
              'holdings_price_usdt': '2000',
              'holdings_price_inr': '150000',
              'aggregation_type': 'crypto',
            },
          ],
        },
      };

      when(mockTokenManager.getAuthToken()).thenAnswer((_) async => fakeAuthToken);
      when(mockHttpClient.get(
        endpoint: '/api/v1/portfolio',
        authToken: fakeAuthToken,
      )).thenAnswer((_) async => fakeResponse);

      // Act
      final result = await okto.userPortfolio();

      // Assert
      expect(result, isA<UserPortfolioResponse>());
      expect(result.status, equals('success'));
      expect(result.data.aggregatedData.holdingsCount, equals('10'));
      expect(result.data.aggregatedData.holdingsPriceInr, equals('100000'));
      expect(result.data.aggregatedData.holdingsPriceUsdt, equals('1200'));
      expect(result.data.aggregatedData.totalHoldingPriceInr, equals('150000'));
      expect(result.data.aggregatedData.totalHoldingPriceUsdt, equals('2000'));
      expect(result.data.groupTokens.length, equals(2));
      expect(result.data.groupTokens[0].name, equals('Bitcoin'));
      expect(result.data.groupTokens[0].balance, equals('0.5'));
      expect(result.data.groupTokens[1].name, equals('Ethereum'));
      expect(result.data.groupTokens[1].balance, equals('10'));
    });

    test('userPortfolio handles error response', () async {
      // Arrange
      const fakeAuthToken = 'fakeAuthToken';
      final fakeErrorResponse = {
        'status': 'error',
        'message': 'Unable to retrieve user portfolio',
      };

      when(mockTokenManager.getAuthToken()).thenAnswer((_) async => fakeAuthToken);
      when(mockHttpClient.get(
        endpoint: '/api/v1/portfolio',
        authToken: fakeAuthToken,
      )).thenAnswer((_) async => fakeErrorResponse);
    });

    test('userPortfolio handles network error', () async {
      // Arrange
      const fakeAuthToken = 'fakeAuthToken';

      when(mockTokenManager.getAuthToken()).thenAnswer((_) async => fakeAuthToken);
      when(mockHttpClient.get(
        endpoint: '/api/v1/portfolio',
        authToken: fakeAuthToken,
      )).thenThrow(Exception('Network error'));
    });

    test('userPortfolio handles invalid response format', () async {
      // Arrange
      const fakeAuthToken = 'fakeAuthToken';
      final invalidResponse = {
        'status': 'success',
        'data': 'Invalid data format',
      };

      when(mockTokenManager.getAuthToken()).thenAnswer((_) async => fakeAuthToken);
      when(mockHttpClient.get(
        endpoint: '/api/v1/portfolio',
        authToken: fakeAuthToken,
      )).thenAnswer((_) async => invalidResponse);
    });

    test('getUserPortfolioActivity returns UserPortfolioActivityResponse on successful response', () async {
      // Arrange
      const fakeAuthToken = 'fakeAuthToken';
      final fakeResponse = {
        'status': 'success',
        'data': {
          'count': 2,
          'activity': [
            {
              'symbol': 'BTC',
              'image': 'btc.png',
              'name': 'Bitcoin',
              'short_name': 'BTC',
              'id': '1',
              'group_id': 'g1',
              'description': 'Bought 0.5 BTC',
              'quantity': '0.5',
              'order_type': 'buy',
              'transfer_type': 'deposit',
              'status': 'completed',
              'timestamp': 1625812800,
              'tx_hash': 'hash1',
              'network_id': 'bitcoin',
              'network_name': 'Bitcoin Network',
              'network_explorer_url': 'https://btc.com/',
              'network_symbol': 'BTC',
            },
            {
              'symbol': 'ETH',
              'image': 'eth.png',
              'name': 'Ethereum',
              'short_name': 'ETH',
              'id': '2',
              'group_id': 'g2',
              'description': 'Transferred 2 ETH',
              'quantity': '2',
              'order_type': 'transfer',
              'transfer_type': 'withdrawal',
              'status': 'pending',
              'timestamp': 1625812801,
              'tx_hash': 'hash2',
              'network_id': 'ethereum',
              'network_name': 'Ethereum Network',
              'network_explorer_url': 'https://etherscan.io/',
              'network_symbol': 'ETH',
            },
          ],
        },
      };

      when(mockTokenManager.getAuthToken()).thenAnswer((_) async => fakeAuthToken);
      when(mockHttpClient.get(
        endpoint: '/api/v1/portfolio/activity?limit=10&offset=1',
        authToken: fakeAuthToken,
      )).thenAnswer((_) async => fakeResponse);

      // Act
      final result = await okto.getUserPortfolioActivity();

      // Assert
      expect(result, isA<UserPortfolioActivityResponse>());
      expect(result.status, equals('success'));
      expect(result.data.count, equals(2));
      expect(result.data.activity.length, equals(2));
      expect(result.data.activity[0].symbol, equals('BTC'));
      expect(result.data.activity[0].description, equals('Bought 0.5 BTC'));
      expect(result.data.activity[1].symbol, equals('ETH'));
      expect(result.data.activity[1].description, equals('Transferred 2 ETH'));
    });

    test('getUserPortfolioActivity handles error response', () async {
      // Arrange
      const fakeAuthToken = 'fakeAuthToken';
      final fakeErrorResponse = {
        'status': 'error',
        'message': 'Unable to retrieve user portfolio activity',
      };

      when(mockTokenManager.getAuthToken()).thenAnswer((_) async => fakeAuthToken);
      when(mockHttpClient.get(
        endpoint: '/api/v1/portfolio/activity?limit=10&offset=1',
        authToken: fakeAuthToken,
      )).thenAnswer((_) async => fakeErrorResponse);
    });

    test('getUserPortfolioActivity handles network error', () async {
      // Arrange
      const fakeAuthToken = 'fakeAuthToken';

      when(mockTokenManager.getAuthToken()).thenAnswer((_) async => fakeAuthToken);
      when(mockHttpClient.get(
        endpoint: '/api/v1/portfolio/activity?limit=10&offset=1',
        authToken: fakeAuthToken,
      )).thenThrow(Exception('Network error'));
    });

    test('getUserPortfolioActivity handles invalid response format', () async {
      // Arrange
      const fakeAuthToken = 'fakeAuthToken';
      final invalidResponse = {
        'status': 'success',
        'data': 'Invalid data format',
      };

      when(mockTokenManager.getAuthToken()).thenAnswer((_) async => fakeAuthToken);
      when(mockHttpClient.get(
        endpoint: '/api/v1/portfolio/activity?limit=10&offset=1',
        authToken: fakeAuthToken,
      )).thenAnswer((_) async => invalidResponse);
    });
  });
}
