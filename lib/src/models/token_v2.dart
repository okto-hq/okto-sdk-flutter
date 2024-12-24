class TokenV2 {
  String? address;
  String? caipId;
  String? symbol;
  String? image;
  String? name;
  String? shortName;
  String? id;
  String? groupId;
  bool? isPrimary;
  String? networkId;
  String? networkName;
  String? balance;
  String? tokenAddress;
  String? precision;

  TokenV2(
      {this.address,
        this.caipId,
        this.symbol,
        this.image,
        this.name,
        this.shortName,
        this.id,
        this.groupId,
        this.isPrimary,
        this.networkId,
        this.networkName,
        this.balance,
        this.tokenAddress,
        this.precision});

  TokenV2.fromJson(dynamic json) {
    address = json['address'];
    caipId = json['caip_id'];
    symbol = json['symbol'];
    image = json['image'];
    name = json['name'];
    shortName = json['short_name'];
    id = json['id'];
    groupId = json['group_id'];
    isPrimary = json['is_primary'];
    networkId = json['network_id'];
    networkName = json['network_name'];
    balance = json['balance'];
    tokenAddress = json['token_address'];
    precision = json['precision'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['address'] = address;
    map['caip_id'] = caipId;
    map['symbol'] = symbol;
    map['image'] = image;
    map['name'] = name;
    map['short_name'] = shortName;
    map['id'] = id;
    map['group_id'] = groupId;
    map['is_primary'] = isPrimary;
    map['network_id'] = networkId;
    map['network_name'] = networkName;
    map['balance'] = balance;
    map['token_address'] = tokenAddress;
    map['precision'] = precision;
    return map;
  }
}