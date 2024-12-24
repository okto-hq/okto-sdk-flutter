import 'package:okto_flutter_sdk/src/models/portfolio_data_v2.dart';
import 'package:okto_flutter_sdk/src/models/token_v2.dart';
import 'package:okto_flutter_sdk/src/models/wallet_data_v2.dart';

class WhitelistedTokenDataV2 {
  WhitelistedTokenDataV2({
    this.count,
    this.tokens,
  });

  WhitelistedTokenDataV2.fromJson(dynamic json) {
    count = json['count'];
    if (json['tokens'] != null) {
      tokens = [];
      json['tokens'].forEach((v) {
        tokens?.add(TokenV2.fromJson(v));
      });
    }
  }

  num? count;
  List<TokenV2>? tokens;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['count'] = count;
    if (tokens != null) {
      map['tokens'] = tokens?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class CombinedTokenV2 {
  late String name;
  late String symbol;
  late String shortName;
  late String id;
  late String groupId;
  late String holdingsPriceUsdt;
  late String holdingsPriceInr;
  late String balance;
  late String networkId;
  late bool isPrimary;
  late String tokenImage;
  late String networkName;
  late String walletAddress;
  String? chainId;
  TokenV2? token;

  CombinedTokenV2(
      TokenV2 tokenV2, GroupTokensV2? portfolioToken, WalletsV2? wallet) {
    name = tokenV2.name ?? '';
    symbol = tokenV2.symbol ?? '';
    shortName = tokenV2.shortName ?? '';
    id = tokenV2.id ?? '';
    groupId = tokenV2.groupId ?? '';
    holdingsPriceUsdt = portfolioToken?.holdingsPriceUsdt ?? '0';
    holdingsPriceInr = portfolioToken?.holdingsPriceInr ?? '0';
    balance = portfolioToken?.balance ?? '0';
    isPrimary = portfolioToken?.isPrimary ?? false;
    tokenImage = tokenV2.image ?? '';
    networkName = wallet?.networkName ?? '';
    networkId = wallet?.networkId ?? '';
    walletAddress = wallet?.address ?? '';
    token = portfolioToken?.tokens?.firstWhere((t) => token?.id == t.id);
  }

  CombinedTokenV2.nft(this.name, this.networkName, this.walletAddress) {
    symbol = '';
    shortName = '';
    id = '';
    groupId = '';
    holdingsPriceUsdt = '0';
    holdingsPriceInr = '0';
    balance = '0';
    networkId = '';
    isPrimary = false;
    tokenImage = '';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CombinedTokenV2 &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
