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
  final List<Tokens> tokens;
  TokenData({
    required this.tokens,
  });

  Map<String, dynamic> toMap() {
    return {
      'tokens': tokens.map((x) => x.toMap()).toList(),
    };
  }

  factory TokenData.fromMap(Map<String, dynamic> map) {
    return TokenData(
      tokens: List<Tokens>.from(map['tokens']?.map((x) => Tokens.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory TokenData.fromJson(String source) => TokenData.fromMap(json.decode(source));
}

class Tokens {
  final String tokenName;
  final String tokenAddress;
  final String networkName;
  Tokens({
    required this.tokenName,
    required this.tokenAddress,
    required this.networkName,
  });

  Map<String, dynamic> toMap() {
    return {
      'token_name': tokenName,
      'token_address': tokenAddress,
      'network_name': networkName,
    };
  }

  factory Tokens.fromMap(Map<String, dynamic> map) {
    return Tokens(
      tokenName: map['token_name'] ?? '',
      tokenAddress: map['token_address'] ?? '',
      networkName: map['network_name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Tokens.fromJson(String source) => Tokens.fromMap(json.decode(source));
}
