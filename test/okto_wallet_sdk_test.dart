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
  });
}
