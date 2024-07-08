  import 'dart:convert';

  class TransferNftResponse {
    final String status;
    final TransferNftData data;
    TransferNftResponse({
      required this.status,
      required this.data,
    });

    Map<String, dynamic> toMap() {
      return {
        'status': status,
        'data': data.toMap(),
      };
    }

    factory TransferNftResponse.fromMap(Map<String, dynamic> map) {
      return TransferNftResponse(
        status: map['status'] ?? '',
        data: TransferNftData.fromMap(map['data']),
      );
    }

    String toJson() => json.encode(toMap());

    factory TransferNftResponse.fromJson(String source) => TransferNftResponse.fromMap(json.decode(source));
  }

  class TransferNftData {
    final String orderId;
    TransferNftData({
      required this.orderId,
    });

    Map<String, dynamic> toMap() {
      return {
        'order_id': orderId,
      };
    }

    factory TransferNftData.fromMap(Map<String, dynamic> map) {
      return TransferNftData(
        orderId: map['order_id'] ?? '',
      );
    }

    String toJson() => json.encode(toMap());

    factory TransferNftData.fromJson(String source) => TransferNftData.fromMap(json.decode(source));
  }
