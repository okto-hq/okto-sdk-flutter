import 'dart:convert';

class AuthTokenResponse {
  final String status;
  final AuthTokenData data;
  AuthTokenResponse({
    required this.status,
    required this.data,
  });

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'data': data.toMap(),
    };
  }

  factory AuthTokenResponse.fromMap(Map<String, dynamic> map) {
    return AuthTokenResponse(
      status: map['status'] ?? '',
      data: AuthTokenData.fromMap(map['data']),
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthTokenResponse.fromJson(String source) => AuthTokenResponse.fromMap(json.decode(source));
}

class AuthTokenData {
  final String authToken;
  final String message;
  final String refreshAuthToken;
  final String deviceToken;
  AuthTokenData({
    required this.authToken,
    required this.message,
    required this.refreshAuthToken,
    required this.deviceToken,
  });

  Map<String, dynamic> toMap() {
    return {
      'auth_token': authToken,
      'message': message,
      'refresb_auth_token': refreshAuthToken,
      'device_token': deviceToken,
    };
  }

  factory AuthTokenData.fromMap(Map<String, dynamic> map) {
    return AuthTokenData(
      authToken: map['auth_token'] ?? '',
      message: map['message'] ?? '',
      refreshAuthToken: map['refresb_auth_token'] ?? '',
      deviceToken: map['device_token'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthTokenData.fromJson(String source) => AuthTokenData.fromMap(json.decode(source));
}
