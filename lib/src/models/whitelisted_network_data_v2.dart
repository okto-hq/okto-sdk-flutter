/// network : [{"caip_id":"eip::","network_name":"APTOS","chain_id":"1","logo":"https://s2.coinmarketcap.com/static/img/coins/64x64/21794.png"},{"caip_id":"eip::","network_name":"APTOS_TESTNET","chain_id":"2","logo":"https://s2.coinmarketcap.com/static/img/coins/64x64/21794.png"}]

class WhitelistedNetworkDataV2 {
  List<NetworkV2>? network;
  String? status;
  WhitelistedNetworkDataV2({this.network, this.status});

  WhitelistedNetworkDataV2.fromJson(dynamic json) {
    status = json['status'];
    if (json['network'] != null) {
      network = [];
      json['network'].forEach((v) {
        network?.add(NetworkV2.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (network != null) {
      map['network'] = network?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// caip_id : "eip::"
/// network_name : "APTOS"
/// chain_id : "1"
/// logo : "https://s2.coinmarketcap.com/static/img/coins/64x64/21794.png"

class NetworkV2 {
  NetworkV2({
      this.caipId, 
      this.networkName, 
      this.chainId, 
      this.logo,});

  NetworkV2.fromJson(dynamic json) {
    caipId = json['caip_id'];
    networkName = json['network_name'];
    chainId = json['chain_id'];
    logo = json['logo'];
  }
  String? caipId;
  String? networkName;
  String? chainId;
  String? logo;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['caip_id'] = caipId;
    map['network_name'] = networkName;
    map['chain_id'] = chainId;
    map['logo'] = logo;
    return map;
  }

}