import 'dart:convert';

class AuthenticationResponse {
  final String status;
  final AuthenticationData data;
  AuthenticationResponse({
    required this.status,
    required this.data,
  });

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'data': data.toMap(),
    };
  }

  factory AuthenticationResponse.fromMap(Map<String, dynamic> map) {
    return AuthenticationResponse(
      status: map['status'] ?? '',
      data: AuthenticationData.fromMap(map['data']),
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthenticationResponse.fromJson(String source) => AuthenticationResponse.fromMap(json.decode(source));
}

class AuthenticationData {
  final String token;
  final String message;
  final int status;
  final String action;
  final int code;
  AuthenticationData({
    required this.token,
    required this.message,
    required this.status,
    required this.action,
    required this.code,
  });

  Map<String, dynamic> toMap() {
    return {
      'token': token,
      'message': message,
      'status': status,
      'action': action,
      'code': code,
    };
  }

  factory AuthenticationData.fromMap(Map<String, dynamic> map) {
    return AuthenticationData(
      token: map['token'] ?? '',
      message: map['message'] ?? '',
      status: map['status']?.toInt() ?? 0,
      action: map['action'] ?? '',
      code: map['code']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthenticationData.fromJson(String source) => AuthenticationData.fromMap(json.decode(source));
}
