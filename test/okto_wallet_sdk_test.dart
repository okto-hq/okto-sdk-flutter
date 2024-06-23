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
  });
}