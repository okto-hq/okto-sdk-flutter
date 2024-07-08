import 'dart:convert';

class UserPortfolioResponse {
  final String status;
  final UserPortfolioData data;
  UserPortfolioResponse({
    required this.status,
    required this.data,
  });

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'data': data.toMap(),
    };
  }

  factory UserPortfolioResponse.fromMap(Map<String, dynamic> map) {
    return UserPortfolioResponse(
      status: map['status'] ?? '',
      data: UserPortfolioData.fromMap(map['data']),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserPortfolioResponse.fromJson(String source) => UserPortfolioResponse.fromMap(json.decode(source));
}

class UserPortfolioData {
  final int total;
  final List<Token> tokens;
  UserPortfolioData({
    required this.total,
    required this.tokens,
  });

  Map<String, dynamic> toMap() {
    return {
      'total': total,
      'tokens': tokens.map((x) => x.toMap()).toList(),
    };
  }

  factory UserPortfolioData.fromMap(Map<String, dynamic> map) {
    return UserPortfolioData(
      total: map['total']?.toInt() ?? 0,
      tokens: List<Token>.from(map['tokens']?.map((x) => Token.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserPortfolioData.fromJson(String source) => UserPortfolioData.fromMap(json.decode(source));
}

class Token {
  final String tokenName;
  final String quantity;
  final String amountInInr;
  final String tokenImage;
  final String tokenAddress;
  final String networkName;
  Token({
    required this.tokenName,
    required this.quantity,
    required this.amountInInr,
    required this.tokenImage,
    required this.tokenAddress,
    required this.networkName,
  });

  Map<String, dynamic> toMap() {
    return {
      'token_name': tokenName,
      'quantity': quantity,
      'amount_in_inr': amountInInr,
      'token_image': tokenImage,
      'token_address': tokenAddress,
      'network_name': networkName,
    };
  }

  factory Token.fromMap(Map<String, dynamic> map) {
    return Token(
      tokenName: map['token_name'] ?? '',
      quantity: map['quantity'] ?? '',
      amountInInr: map['amount_in_inr'] ?? '',
      tokenImage: map['token_image'] ?? '',
      tokenAddress: map['token_address'] ?? '',
      networkName: map['network_name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Token.fromJson(String source) => Token.fromMap(json.decode(source));
}
