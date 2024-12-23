/// wallets : [{"caip_id":"","network_name":"Ethereum","address":"0x3a5208463c424611689cc2055c0c2fa90f5dbd34","network_id":"1","network_symbol":"ETH"},{"caip_id":"","network_name":"Binance Smart Chain","address":"0xb522b7e45e3c1780259a69b2c25703cc02ad3289","network_id":"","network_symbol":"BNB"},{"caip_id":"","network_name":"Polygon","address":"0x0c8cf8938329ae1363ca79834a1e9f4b88552561","network_id":"","network_symbol":"MATIC"}]

class WalletDataV2 {

  WalletDataV2({this.wallets,});

  WalletDataV2.fromJson(dynamic json) {
    if (json != null && json is Iterable) {
      wallets = [];
      for (var v in json) {
        wallets?.add(WalletsV2.fromJson(v));
      }
    }
  }
  List<WalletsV2>? wallets;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (wallets != null) {
      map['wallets'] = wallets?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// caip_id : ""
/// network_name : "Ethereum"
/// address : "0x3a5208463c424611689cc2055c0c2fa90f5dbd34"
/// network_id : "1"
/// network_symbol : "ETH"

class WalletsV2 {
  WalletsV2({
      this.caipId, 
      this.networkName, 
      this.address, 
      this.networkId, 
      this.networkSymbol,});

  WalletsV2.fromJson(dynamic json) {
    caipId = json['caip_id'];
    networkName = json['network_name'];
    address = json['address'];
    networkId = json['network_id'];
    networkSymbol = json['network_symbol'];
  }
  String? caipId;
  String? networkName;
  String? address;
  String? networkId;
  String? networkSymbol;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['caip_id'] = caipId;
    map['network_name'] = networkName;
    map['address'] = address;
    map['network_id'] = networkId;
    map['network_symbol'] = networkSymbol;
    return map;
  }

}