import 'dart:convert';

class UserDetails {
  final String status;
  final UserData data;

  UserDetails({required this.status, required this.data});

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'data': data.toMap(),
    };
  }

  factory UserDetails.fromMap(Map<String, dynamic> map) {
    return UserDetails(
      status: map['status'] ?? '',
      data: UserData.fromMap(map['data']),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserDetails.fromJson(String source) => UserDetails.fromMap(json.decode(source));
}

class UserData {
  final String email;
  final String userId;
  final String createdAt;
  final bool freezed;
  final String freezeReason;

  UserData({required this.email, required this.userId, required this.createdAt, required this.freezed, required this.freezeReason});

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'user_id': userId,
      'created_at': createdAt,
      'freezed': freezed,
      'freeze_reason': freezeReason,
    };
  }

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      email: map['email'] ?? '',
      userId: map['user_id'] ?? '',
      createdAt: map['created_at'] ?? '',
      freezed: map['freezed'] ?? false,
      freezeReason: map['freeze_reason'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserData.fromJson(String source) => UserData.fromMap(json.decode(source));
}
