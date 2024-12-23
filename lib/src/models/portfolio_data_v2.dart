import 'package:okto_flutter_sdk/src/models/whitelisted_token_data_v2.dart';

/// aggregated_data : {"holdings_count":"2","holdings_price_inr":"0","holdings_price_usdt":"0","total_holding_price_inr":"0","total_holding_price_usdt":"0"}
/// group_tokens : [{"caip_id":"","id":"6ddfc36b-55d2-3b1f-8c45-4b076ae3bb9e","name":"APT","symbol":"APT_TESTNET","short_name":"APT_TESTNET","token_image":"https://s2.coinmarketcap.com/static/img/coins/64x64/21794.png","token_address":"0x1::aptos_coin::AptosCoin","network_id":"d6fd4680-c28d-37b2-994e-b9d3d4026f91","precision":"8","network_name":"APTOS_TESTNET","is_primary":false,"balance":"5.419506","holdings_price_usdt":"0","holdings_price_inr":"0","aggregation_type":"token"},{"caip_id":"","id":"286e53ec-8991-3f7d-a276-1484a5800ea4","name":"APT","symbol":"APT","short_name":"APT","token_image":"https://s2.coinmarketcap.com/static/img/coins/64x64/21794.png","token_address":"0x1::aptos_coin::AptosCoin","network_id":"dd50ef5f-58f4-3133-8e25-9c2673a9122f","precision":"8","network_name":"APTOS","is_primary":false,"balance":"0.011606","holdings_price_usdt":"0","holdings_price_inr":"0","aggregation_type":"token"}]

class PortfolioDataV2 {
  AggregatedDataV2? aggregatedData;
  List<GroupTokensV2>? groupTokens;

  PortfolioDataV2({
    this.aggregatedData,
    this.groupTokens,
  });

  PortfolioDataV2.fromJson(dynamic json) {
    aggregatedData = json['aggregated_data'] != null
        ? AggregatedDataV2.fromJson(json['aggregated_data'])
        : null;
    if (json['group_tokens'] != null) {
      groupTokens = [];
      json['group_tokens'].forEach((v) {
        groupTokens?.add(GroupTokensV2.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (aggregatedData != null) {
      map['aggregated_data'] = aggregatedData?.toJson();
    }
    if (groupTokens != null) {
      map['group_tokens'] = groupTokens?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// caip_id : ""
/// id : "6ddfc36b-55d2-3b1f-8c45-4b076ae3bb9e"
/// name : "APT"
/// symbol : "APT_TESTNET"
/// short_name : "APT_TESTNET"
/// token_image : "https://s2.coinmarketcap.com/static/img/coins/64x64/21794.png"
/// token_address : "0x1::aptos_coin::AptosCoin"
/// network_id : "d6fd4680-c28d-37b2-994e-b9d3d4026f91"
/// precision : "8"
/// network_name : "APTOS_TESTNET"
/// is_primary : false
/// balance : "5.419506"
/// holdings_price_usdt : "0"
/// holdings_price_inr : "0"
/// aggregation_type : "token"

class GroupTokensV2 {
  GroupTokensV2(
      {this.caipId,
      this.id,
      this.name,
      this.symbol,
      this.shortName,
      this.tokenImage,
      this.tokenAddress,
      this.networkId,
      this.precision,
      this.networkName,
      this.isPrimary,
      this.balance,
      this.holdingsPriceUsdt,
      this.holdingsPriceInr,
      this.aggregationType,
      this.tokens});

  GroupTokensV2.fromJson(dynamic json) {
    caipId = json['caip_id'];
    id = json['id'];
    name = json['name'];
    symbol = json['symbol'];
    shortName = json['short_name'];
    tokenImage = json['token_image'];
    tokenAddress = json['token_address'];
    networkId = json['network_id'];
    precision = json['precision'];
    networkName = json['network_name'];
    isPrimary = json['is_primary'];
    balance = json['balance'];
    holdingsPriceUsdt = json['holdings_price_usdt'];
    holdingsPriceInr = json['holdings_price_inr'];
    aggregationType = json['aggregation_type'];
    if (json['tokens'] != null) {
      tokens = <TokenV2>[];
      json['tokens'].forEach((v) {
        tokens!.add(TokenV2.fromJson(v));
      });
    }
  }

  String? caipId;
  String? id;
  String? name;
  String? symbol;
  String? shortName;
  String? tokenImage;
  String? tokenAddress;
  String? networkId;
  String? precision;
  String? networkName;
  bool? isPrimary;
  String? balance;
  String? holdingsPriceUsdt;
  String? holdingsPriceInr;
  String? aggregationType;
  List<TokenV2>? tokens;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['caip_id'] = caipId;
    map['id'] = id;
    map['name'] = name;
    map['symbol'] = symbol;
    map['short_name'] = shortName;
    map['token_image'] = tokenImage;
    map['token_address'] = tokenAddress;
    map['network_id'] = networkId;
    map['precision'] = precision;
    map['network_name'] = networkName;
    map['is_primary'] = isPrimary;
    map['balance'] = balance;
    map['holdings_price_usdt'] = holdingsPriceUsdt;
    map['holdings_price_inr'] = holdingsPriceInr;
    map['aggregation_type'] = aggregationType;
    if (tokens != null) {
      map['tokens'] = tokens!.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// holdings_count : "2"
/// holdings_price_inr : "0"
/// holdings_price_usdt : "0"
/// total_holding_price_inr : "0"
/// total_holding_price_usdt : "0"

class AggregatedDataV2 {
  AggregatedDataV2({
    this.holdingsCount,
    this.holdingsPriceInr,
    this.holdingsPriceUsdt,
    this.totalHoldingPriceInr,
    this.totalHoldingPriceUsdt,
  });

  AggregatedDataV2.fromJson(dynamic json) {
    holdingsCount = json['holdings_count'];
    holdingsPriceInr = json['holdings_price_inr'];
    holdingsPriceUsdt = json['holdings_price_usdt'];
    totalHoldingPriceInr = json['total_holding_price_inr'];
    totalHoldingPriceUsdt = json['total_holding_price_usdt'];
  }

  String? holdingsCount;
  String? holdingsPriceInr;
  String? holdingsPriceUsdt;
  String? totalHoldingPriceInr;
  String? totalHoldingPriceUsdt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['holdings_count'] = holdingsCount;
    map['holdings_price_inr'] = holdingsPriceInr;
    map['holdings_price_usdt'] = holdingsPriceUsdt;
    map['total_holding_price_inr'] = totalHoldingPriceInr;
    map['total_holding_price_usdt'] = totalHoldingPriceUsdt;
    return map;
  }
}
