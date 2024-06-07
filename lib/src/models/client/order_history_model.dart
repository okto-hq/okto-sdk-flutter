import 'dart:convert';

class OrderHistoryResponse {
  final String status;
  final OrderHistoryData data;
  OrderHistoryResponse({
    required this.status,
    required this.data,
  });

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'data': data.toMap(),
    };
  }

  factory OrderHistoryResponse.fromMap(Map<String, dynamic> map) {
    return OrderHistoryResponse(
      status: map['status'] ?? '',
      data: OrderHistoryData.fromMap(map['data']),
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderHistoryResponse.fromJson(String source) => OrderHistoryResponse.fromMap(json.decode(source));
}

class OrderHistoryData {
  final int total;
  final List<Jobs> jobs;
  OrderHistoryData({
    required this.total,
    required this.jobs,
  });

  Map<String, dynamic> toMap() {
    return {
      'total': total,
      'jobs': jobs.map((x) => x.toMap()).toList(),
    };
  }

  factory OrderHistoryData.fromMap(Map<String, dynamic> map) {
    return OrderHistoryData(
      total: map['total']?.toInt() ?? 0,
      jobs: List<Jobs>.from(map['jobs']?.map((x) => Jobs.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderHistoryData.fromJson(String source) => OrderHistoryData.fromMap(json.decode(source));
}

class Jobs {
  final String orderId;
  final String orderType;
  final String networkName;
  final String status;
  final String transactionHash;
  Jobs({
    required this.orderId,
    required this.orderType,
    required this.networkName,
    required this.status,
    required this.transactionHash,
  });

  Map<String, dynamic> toMap() {
    return {
      'order_id': orderId,
      'order_type': orderType,
      'network_name': networkName,
      'status': status,
      'transaction_hash': transactionHash,
    };
  }

  factory Jobs.fromMap(Map<String, dynamic> map) {
    return Jobs(
      orderId: map['order_id'] ?? '',
      orderType: map['order_type'] ?? '',
      networkName: map['network_name'] ?? '',
      status: map['status'] ?? '',
      transactionHash: map['transaction_hash'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Jobs.fromJson(String source) => Jobs.fromMap(json.decode(source));
}
