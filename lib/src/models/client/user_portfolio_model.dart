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
  final AggregatedData aggregatedData;
  final List<GroupTokens> groupTokens;
  UserPortfolioData({
    required this.aggregatedData,
    required this.groupTokens,
  });

  Map<String, dynamic> toMap() {
    return {
      'aggregated_data': aggregatedData.toMap(),
      'group_tokens': groupTokens.map((x) => x.toMap()).toList(),
    };
  }

  factory UserPortfolioData.fromMap(Map<String, dynamic> map) {
    return UserPortfolioData(
      aggregatedData: AggregatedData.fromMap(map['aggregated_data']),
      groupTokens: List<GroupTokens>.from(map['group_tokens']?.map((x) => GroupTokens.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserPortfolioData.fromJson(String source) => UserPortfolioData.fromMap(json.decode(source));
}

class AggregatedData {
  final String holdingsCount;
  final String holdingsPriceInr;
  final String holdingsPriceUsdt;
  final String totalHoldingPriceInr;
  final String totalHoldingPriceUsdt;
  AggregatedData({
    required this.holdingsCount,
    required this.holdingsPriceInr,
    required this.holdingsPriceUsdt,
    required this.totalHoldingPriceInr,
    required this.totalHoldingPriceUsdt,
  });

  Map<String, dynamic> toMap() {
    return {
      'holdings_count': holdingsCount,
      'holdings_price_inr': holdingsPriceInr,
      'holdings_price_usdt': holdingsPriceUsdt,
      'total_holding_price_inr': totalHoldingPriceInr,
      'total_holding_price_usdt': totalHoldingPriceUsdt,
    };
  }

  factory AggregatedData.fromMap(Map<String, dynamic> map) {
    return AggregatedData(
      holdingsCount: map['holdings_count'] ?? '',
      holdingsPriceInr: map['holdings_price_inr'] ?? '',
      holdingsPriceUsdt: map['holdings_price_usdt'] ?? '',
      totalHoldingPriceInr: map['total_holding_price_inr'] ?? '',
      totalHoldingPriceUsdt: map['total_holdins_price_usdt'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AggregatedData.fromJson(String source) => AggregatedData.fromMap(json.decode(source));
}

class GroupTokens {
  final String id;
  final String name;
  final String symbol;
  final String shortName;
  final String tokenImage;
  final String networkId;
  final bool isPrimary;
  final String balance;
  final String holdingsPriceUsdt;
  final String holdingsPriceInr;
  final String aggregationType;
  GroupTokens({
    required this.id,
    required this.name,
    required this.symbol,
    required this.shortName,
    required this.tokenImage,
    required this.networkId,
    required this.isPrimary,
    required this.balance,
    required this.holdingsPriceUsdt,
    required this.holdingsPriceInr,
    required this.aggregationType,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'symbol': symbol,
      'short_name': shortName,
      'token_image': tokenImage,
      'network_id': networkId,
      'is_primary': isPrimary,
      'balance': balance,
      'holdings_price_usdt': holdingsPriceUsdt,
      'holdings_price_inr': holdingsPriceInr,
      'aggregation_type': aggregationType,
    };
  }

  factory GroupTokens.fromMap(Map<String, dynamic> map) {
    return GroupTokens(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      symbol: map['symbol'] ?? '',
      shortName: map['short_name'] ?? '',
      tokenImage: map['token_image'] ?? '',
      networkId: map['network_id'] ?? '',
      isPrimary: map['is_primary'] ?? false,
      balance: map['balance'] ?? '',
      holdingsPriceUsdt: map['holdings_price_usdt'] ?? '',
      holdingsPriceInr: map['holdings_price_inr'] ?? '',
      aggregationType: map['aggregation_type'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory GroupTokens.fromJson(String source) => GroupTokens.fromMap(json.decode(source));
}
