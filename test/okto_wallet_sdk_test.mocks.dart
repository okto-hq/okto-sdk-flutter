// Mocks generated by Mockito 5.4.4 from annotations
// in okto_flutter_sdk/test/okto_wallet_sdk_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i7;

import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i3;
import 'package:http/http.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i5;
import 'package:okto_flutter_sdk/src/utils/enums.dart' as _i6;
import 'package:okto_flutter_sdk/src/utils/http_client.dart' as _i4;
import 'package:okto_flutter_sdk/src/utils/token_manager.dart' as _i8;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeClient_0 extends _i1.SmartFake implements _i2.Client {
  _FakeClient_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeFlutterSecureStorage_1 extends _i1.SmartFake
    implements _i3.FlutterSecureStorage {
  _FakeFlutterSecureStorage_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeHttpClient_2 extends _i1.SmartFake implements _i4.HttpClient {
  _FakeHttpClient_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [HttpClient].
///
/// See the documentation for Mockito's code generation for more information.
class MockHttpClient extends _i1.Mock implements _i4.HttpClient {
  MockHttpClient() {
    _i1.throwOnMissingStub(this);
  }

  @override
  String get apiKey => (super.noSuchMethod(
        Invocation.getter(#apiKey),
        returnValue: _i5.dummyValue<String>(
          this,
          Invocation.getter(#apiKey),
        ),
      ) as String);

  @override
  _i6.BuildType get buildType => (super.noSuchMethod(
        Invocation.getter(#buildType),
        returnValue: _i6.BuildType.staging,
      ) as _i6.BuildType);

  @override
  _i2.Client get httpClient => (super.noSuchMethod(
        Invocation.getter(#httpClient),
        returnValue: _FakeClient_0(
          this,
          Invocation.getter(#httpClient),
        ),
      ) as _i2.Client);

  @override
  _i7.Future<dynamic> post({
    required String? endpoint,
    required Map<String, dynamic>? body,
    String? authToken,
    Map<String, String>? additionalHeaders,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #post,
          [],
          {
            #endpoint: endpoint,
            #body: body,
            #authToken: authToken,
            #additionalHeaders: additionalHeaders,
          },
        ),
        returnValue: _i7.Future<dynamic>.value(),
      ) as _i7.Future<dynamic>);

  @override
  _i7.Future<dynamic> defaultPost({
    required String? endpoint,
    required Map<String, dynamic>? body,
    String? authToken,
    Map<String, String>? additionalHeaders,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #defaultPost,
          [],
          {
            #endpoint: endpoint,
            #body: body,
            #authToken: authToken,
            #additionalHeaders: additionalHeaders,
          },
        ),
        returnValue: _i7.Future<dynamic>.value(),
      ) as _i7.Future<dynamic>);

  @override
  _i7.Future<dynamic> get({
    required String? endpoint,
    String? authToken,
    Map<String, String>? additionalHeaders,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #get,
          [],
          {
            #endpoint: endpoint,
            #authToken: authToken,
            #additionalHeaders: additionalHeaders,
          },
        ),
        returnValue: _i7.Future<dynamic>.value(),
      ) as _i7.Future<dynamic>);
}

/// A class which mocks [TokenManager].
///
/// See the documentation for Mockito's code generation for more information.
class MockTokenManager extends _i1.Mock implements _i8.TokenManager {
  MockTokenManager() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.FlutterSecureStorage get secureStorage => (super.noSuchMethod(
        Invocation.getter(#secureStorage),
        returnValue: _FakeFlutterSecureStorage_1(
          this,
          Invocation.getter(#secureStorage),
        ),
      ) as _i3.FlutterSecureStorage);

  @override
  _i4.HttpClient get httpClient => (super.noSuchMethod(
        Invocation.getter(#httpClient),
        returnValue: _FakeHttpClient_2(
          this,
          Invocation.getter(#httpClient),
        ),
      ) as _i4.HttpClient);

  @override
  _i7.Future<String?> getAuthToken() => (super.noSuchMethod(
        Invocation.method(
          #getAuthToken,
          [],
        ),
        returnValue: _i7.Future<String?>.value(),
      ) as _i7.Future<String?>);

  @override
  _i7.Future<void> storeTokens(
    String? authToken,
    String? refreshToken,
    String? deviceToken,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #storeTokens,
          [
            authToken,
            refreshToken,
            deviceToken,
          ],
        ),
        returnValue: _i7.Future<void>.value(),
        returnValueForMissingStub: _i7.Future<void>.value(),
      ) as _i7.Future<void>);

  @override
  _i7.Future<void> refreshToken() => (super.noSuchMethod(
        Invocation.method(
          #refreshToken,
          [],
        ),
        returnValue: _i7.Future<void>.value(),
        returnValueForMissingStub: _i7.Future<void>.value(),
      ) as _i7.Future<void>);

  @override
  _i7.Future<bool> deleteToken() => (super.noSuchMethod(
        Invocation.method(
          #deleteToken,
          [],
        ),
        returnValue: _i7.Future<bool>.value(false),
      ) as _i7.Future<bool>);
}
