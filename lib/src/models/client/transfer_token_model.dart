import 'dart:convert';

class TransferTokenResponse {
  final String status;
  final TransferTokenData data;
  TransferTokenResponse({
    required this.status,
    required this.data,
  });

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'data': data.toMap(),
    };
  }

  factory TransferTokenResponse.fromMap(Map<String, dynamic> map) {
    return TransferTokenResponse(
      status: map['status'] ?? '',
      data: TransferTokenData.fromMap(map['data']),
    );
  }

  String toJson() => json.encode(toMap());

  factory TransferTokenResponse.fromJson(String source) => TransferTokenResponse.fromMap(json.decode(source));
}

class TransferTokenData {
  final String orderId;
  TransferTokenData({
    required this.orderId,
  });

  Map<String, dynamic> toMap() {
    return {
      'order_id': orderId,
    };
  }

  factory TransferTokenData.fromMap(Map<String, dynamic> map) {
    return TransferTokenData(
      orderId: map['order_id'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory TransferTokenData.fromJson(String source) => TransferTokenData.fromMap(json.decode(source));
}
