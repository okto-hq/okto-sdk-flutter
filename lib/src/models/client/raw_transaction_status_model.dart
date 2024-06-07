import 'dart:convert';

class RawTransactionStatusResponse {
  final String status;
  final RawTransactionData data;
  RawTransactionStatusResponse({
    required this.status,
    required this.data,
  });

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'data': data.toMap(),
    };
  }

  factory RawTransactionStatusResponse.fromMap(Map<String, dynamic> map) {
    return RawTransactionStatusResponse(
      status: map['status'] ?? '',
      data: RawTransactionData.fromMap(map['data']),
    );
  }

  String toJson() => json.encode(toMap());

  factory RawTransactionStatusResponse.fromJson(String source) => RawTransactionStatusResponse.fromMap(json.decode(source));
}

class RawTransactionData {
  final List<RawTransactionJobs> jobs;
  RawTransactionData({
    required this.jobs,
  });

  Map<String, dynamic> toMap() {
    return {
      'jobs': jobs.map((x) => x.toMap()).toList(),
    };
  }

  factory RawTransactionData.fromMap(Map<String, dynamic> map) {
    return RawTransactionData(
      jobs: List<RawTransactionJobs>.from(map['jobs']?.map((x) => RawTransactionJobs.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory RawTransactionData.fromJson(String source) => RawTransactionData.fromMap(json.decode(source));
}

class RawTransactionJobs {
  final String orderId;
  final String networkName;
  final String status;
  final String transactionHash;
  RawTransactionJobs({
    required this.orderId,
    required this.networkName,
    required this.status,
    required this.transactionHash,
  });
  

  Map<String, dynamic> toMap() {
    return {
      'order_id': orderId,
      'network_name': networkName,
      'status': status,
      'transaction_hash': transactionHash,
    };
  }

  factory RawTransactionJobs.fromMap(Map<String, dynamic> map) {
    return RawTransactionJobs(
      orderId: map['order_id'] ?? '',
      networkName: map['network_name'] ?? '',
      status: map['status'] ?? '',
      transactionHash: map['transaction_hash'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory RawTransactionJobs.fromJson(String source) => RawTransactionJobs.fromMap(json.decode(source));
}
