import 'dart:convert';

class UserPortfolioActivityResponse {
  final String status;
  final UserPortfolioActivityData data;
  UserPortfolioActivityResponse({
    required this.status,
    required this.data,
  });

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'data': data.toMap(),
    };
  }

  factory UserPortfolioActivityResponse.fromMap(Map<String, dynamic> map) {
    return UserPortfolioActivityResponse(
      status: map['status'] ?? '',
      data: UserPortfolioActivityData.fromMap(map['data']),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserPortfolioActivityResponse.fromJson(String source) => UserPortfolioActivityResponse.fromMap(json.decode(source));
}

class UserPortfolioActivityData {
  final int count;
  final List<Activity> activity;
  UserPortfolioActivityData({
    required this.count,
    required this.activity,
  });

  Map<String, dynamic> toMap() {
    return {
      'count': count,
      'activity': activity.map((x) => x.toMap()).toList(),
    };
  }

  factory UserPortfolioActivityData.fromMap(Map<String, dynamic> map) {
    return UserPortfolioActivityData(
      count: map['count']?.toInt() ?? 0,
      activity: List<Activity>.from(map['activity']?.map((x) => Activity.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserPortfolioActivityData.fromJson(String source) => UserPortfolioActivityData.fromMap(json.decode(source));
}

class Activity {
  final String symbol;
  final String image;
  final String name;
  final String shortName;
  final String id;
  final String groupId;
  final String description;
  final String quantity;
  final String orderType;
  final String transferType;
  final String status;
  final int timestamp;
  final String txHash;
  final String networkId;
  final String networkName;
  final String networkExplorerUrl;
  final String networkSymbol;
  Activity({
    required this.symbol,
    required this.image,
    required this.name,
    required this.shortName,
    required this.id,
    required this.groupId,
    required this.description,
    required this.quantity,
    required this.orderType,
    required this.transferType,
    required this.status,
    required this.timestamp,
    required this.txHash,
    required this.networkId,
    required this.networkName,
    required this.networkExplorerUrl,
    required this.networkSymbol,
  });

  Map<String, dynamic> toMap() {
    return {
      'symbol': symbol,
      'image': image,
      'name': name,
      'short_name': shortName,
      'id': id,
      'group_id': groupId,
      'description': description,
      'quantity': quantity,
      'order_type': orderType,
      'transfer_type': transferType,
      'status': status,
      'timestamp': timestamp,
      'tx_hash': txHash,
      'network_id': networkId,
      'network_name': networkName,
      'network_explorer_url': networkExplorerUrl,
      'network_symbol': networkSymbol,
    };
  }

  factory Activity.fromMap(Map<String, dynamic> map) {
    return Activity(
      symbol: map['symbol'] ?? '',
      image: map['image'] ?? '',
      name: map['name'] ?? '',
      shortName: map['short_name'] ?? '',
      id: map['id'] ?? '',
      groupId: map['group_id'] ?? '',
      description: map['description'] ?? '',
      quantity: map['quantity'] ?? '',
      orderType: map['order_type'] ?? '',
      transferType: map['transfer_type'] ?? '',
      status: map['status'] ?? '',
      timestamp: map['timestamp']?.toInt() ?? 0,
      txHash: map['tx_hash'] ?? '',
      networkId: map['network_id'] ?? '',
      networkName: map['network_name'] ?? '',
      networkExplorerUrl: map['network_explorer_url'] ?? '',
      networkSymbol: map['network_symbol'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Activity.fromJson(String source) => Activity.fromMap(json.decode(source));
}
