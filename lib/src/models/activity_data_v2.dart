/// count : 451
/// activity : [{"symbol":"APT","image":"https://s2.coinmarketcap.com/static/img/coins/64x64/21794.png","name":"APT","short_name":"APT","id":"286e53ec-8991-3f7d-a276-1484a5800ea4","group_id":"","description":"External Withdrawal","quantity":"0.001","order_type":"EXTERNAL_WITHDRAWAL","transfer_type":"WITHDRAWAL","status":"COMPLETED","timestamp":1732878457,"tx_hash":"0x932037b61147e8316cae5ab664ec7a64ef8c442beebad21c6a1779e80b5c416a","network_id":"dd50ef5f-58f4-3133-8e25-9c2673a9122f","network_name":"APTOS","network_explorer_url":"https://explorer.aptoslabs.com/txn/0x932037b61147e8316cae5ab664ec7a64ef8c442beebad21c6a1779e80b5c416a?network=mainnet","network_symbol":"APT","caip_id":""}]

class ActivityDataV2 {

  num? count;
  List<ActivityV2>? activity;

  ActivityDataV2({
      this.count, 
      this.activity,});

  ActivityDataV2.fromJson(dynamic json) {
    count = json['count'];
    if (json['activity'] != null) {
      activity = [];
      json['activity'].forEach((v) {
        activity?.add(ActivityV2.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['count'] = count;
    if (activity != null) {
      map['activity'] = activity?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// symbol : "APT"
/// image : "https://s2.coinmarketcap.com/static/img/coins/64x64/21794.png"
/// name : "APT"
/// short_name : "APT"
/// id : "286e53ec-8991-3f7d-a276-1484a5800ea4"
/// group_id : ""
/// description : "External Withdrawal"
/// quantity : "0.001"
/// order_type : "EXTERNAL_WITHDRAWAL"
/// transfer_type : "WITHDRAWAL"
/// status : "COMPLETED"
/// timestamp : 1732878457
/// tx_hash : "0x932037b61147e8316cae5ab664ec7a64ef8c442beebad21c6a1779e80b5c416a"
/// network_id : "dd50ef5f-58f4-3133-8e25-9c2673a9122f"
/// network_name : "APTOS"
/// network_explorer_url : "https://explorer.aptoslabs.com/txn/0x932037b61147e8316cae5ab664ec7a64ef8c442beebad21c6a1779e80b5c416a?network=mainnet"
/// network_symbol : "APT"
/// caip_id : ""

class ActivityV2 {
  ActivityV2({
      this.symbol, 
      this.image, 
      this.name, 
      this.shortName, 
      this.id, 
      this.groupId, 
      this.description, 
      this.quantity, 
      this.orderType, 
      this.transferType, 
      this.status, 
      this.timestamp, 
      this.txHash, 
      this.networkId, 
      this.networkName, 
      this.networkExplorerUrl, 
      this.networkSymbol, 
      this.caipId,});

  ActivityV2.fromJson(dynamic json) {
    symbol = json['symbol'];
    image = json['image'];
    name = json['name'];
    shortName = json['short_name'];
    id = json['id'];
    groupId = json['group_id'];
    description = json['description'];
    quantity = json['quantity'];
    orderType = json['order_type'];
    transferType = json['transfer_type'];
    status = json['status'];
    timestamp = json['timestamp'];
    txHash = json['tx_hash'];
    networkId = json['network_id'];
    networkName = json['network_name'];
    networkExplorerUrl = json['network_explorer_url'];
    networkSymbol = json['network_symbol'];
    caipId = json['caip_id'];
  }
  String? symbol;
  String? image;
  String? name;
  String? shortName;
  String? id;
  String? groupId;
  String? description;
  String? quantity;
  String? orderType;
  String? transferType;
  String? status;
  num? timestamp;
  String? txHash;
  String? networkId;
  String? networkName;
  String? networkExplorerUrl;
  String? networkSymbol;
  String? caipId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['symbol'] = symbol;
    map['image'] = image;
    map['name'] = name;
    map['short_name'] = shortName;
    map['id'] = id;
    map['group_id'] = groupId;
    map['description'] = description;
    map['quantity'] = quantity;
    map['order_type'] = orderType;
    map['transfer_type'] = transferType;
    map['status'] = status;
    map['timestamp'] = timestamp;
    map['tx_hash'] = txHash;
    map['network_id'] = networkId;
    map['network_name'] = networkName;
    map['network_explorer_url'] = networkExplorerUrl;
    map['network_symbol'] = networkSymbol;
    map['caip_id'] = caipId;
    return map;
  }

}