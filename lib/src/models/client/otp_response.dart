class OtpResponse {
  String? status;
  String? message;
  int? code;
  String? token;

  OtpResponse(this.status, this.message, this.code, this.token);

  OtpResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    code = json['code'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, String>{};
    data['status'] = status ?? "";
    data['message'] = message ?? "";
    data['code'] = code ?? "";
    data['token'] = token;
    return data;
  }
}
