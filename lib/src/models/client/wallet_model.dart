import 'dart:convert';

class WalletResponse {
  final String success;
  final WalletsData data;
  WalletResponse({
    required this.success,
    required this.data,
  });

  Map<String, dynamic> toMap() {
    return {
      'success': success,
      'data': data.toMap(),
    };
  }

  factory WalletResponse.fromMap(Map<String, dynamic> map) {
    return WalletResponse(
      success: map['success'] ?? '',
      data: WalletsData.fromMap(map['data']),
    );
  }

  String toJson() => json.encode(toMap());

  factory WalletResponse.fromJson(String source) => WalletResponse.fromMap(json.decode(source));
}

class WalletsData {
  final List<Wallet> wallets;

  WalletsData({required this.wallets});

  Map<String, dynamic> toMap() {
    return {
      'wallets': wallets.map((x) => x.toMap()).toList(),
    };
  }

  factory WalletsData.fromMap(Map<String, dynamic> map) {
    return WalletsData(
      wallets: List<Wallet>.from(map['wallets']?.map((x) => Wallet.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory WalletsData.fromJson(String source) => WalletsData.fromMap(json.decode(source));
}

class Wallet {
  final String networkName;
  final String address;
  final bool success;
  Wallet({
    required this.networkName,
    required this.address,
    required this.success,
  });

  Map<String, dynamic> toMap() {
    return {
      'network_Name': networkName,
      'address': address,
      'success': success,
    };
  }

  factory Wallet.fromMap(Map<String, dynamic> map) {
    return Wallet(
      networkName: map['network_Name'] ?? '',
      address: map['address'] ?? '',
      success: map['success'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory Wallet.fromJson(String source) => Wallet.fromMap(json.decode(source));
}
