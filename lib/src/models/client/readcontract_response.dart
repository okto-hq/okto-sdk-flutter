class ReadContractResponse {

  bool? success;
  dynamic data;

  ReadContractResponse({
    this.success,
    this.data,
  });

  factory ReadContractResponse.fromJson(Map<String, dynamic> json) {
    return ReadContractResponse(
      success: json['success'],
      data: json['data'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data,
    };
  }
}