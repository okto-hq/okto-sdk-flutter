import 'dart:convert';

class RawTransactionExecuteResponse {
  final String status;
  final RawTransactionExecuteData data;
  RawTransactionExecuteResponse({
    required this.status,
    required this.data,
  });

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'data': data.toMap(),
    };
  }

  factory RawTransactionExecuteResponse.fromMap(Map<String, dynamic> map) {
    return RawTransactionExecuteResponse(
      status: map['status'] ?? '',
      data: RawTransactionExecuteData.fromMap(map['data']),
    );
  }

  String toJson() => json.encode(toMap());

  factory RawTransactionExecuteResponse.fromJson(String source) => RawTransactionExecuteResponse.fromMap(json.decode(source));
}

class RawTransactionExecuteData {
  final String jobId;
  RawTransactionExecuteData({
    required this.jobId,
  });

  Map<String, dynamic> toMap() {
    return {
      'jobId': jobId,
    };
  }

  factory RawTransactionExecuteData.fromMap(Map<String, dynamic> map) {
    return RawTransactionExecuteData(
      jobId: map['jobId'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory RawTransactionExecuteData.fromJson(String source) => RawTransactionExecuteData.fromMap(json.decode(source));
}
