import 'dart:convert';

class TokenResponse {
  final String status;
  final TokenData data;
  TokenResponse({
    required this.status,
    required this.data,
  });

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'data': data.toMap(),
    };
  }

  factory TokenResponse.fromMap(Map<String, dynamic> map) {
    return TokenResponse(
      status: map['status'] ?? '',
      data: TokenData.fromMap(map['data']),
    );
  }

  String toJson() => json.encode(toMap());

  factory TokenResponse.fromJson(String source) => TokenResponse.fromMap(json.decode(source));
}

class TokenData {
  final String authToken;
  final String message;
  final String refreshAuthToken;
  final String deviceToken;
  TokenData({
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

  factory TokenData.fromMap(Map<String, dynamic> map) {
    return TokenData(
      authToken: map['auth_token'] ?? '',
      message: map['message'] ?? '',
      refreshAuthToken: map['refresb_auth_token'] ?? '',
      deviceToken: map['device_token'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory TokenData.fromJson(String source) => TokenData.fromMap(json.decode(source));
}
