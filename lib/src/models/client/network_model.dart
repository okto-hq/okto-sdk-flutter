import 'dart:convert';

class NetworkDetails {
  final String status;
  final NetworkData data;
  NetworkDetails({
    required this.status,
    required this.data,
  });

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'data': data.toMap(),
    };
  }

  factory NetworkDetails.fromMap(Map<String, dynamic> map) {
    return NetworkDetails(
      status: map['status'] ?? '',
      data: NetworkData.fromMap(map['data']),
    );
  }

  String toJson() => json.encode(toMap());

  factory NetworkDetails.fromJson(String source) => NetworkDetails.fromMap(json.decode(source));
}

class NetworkData {
  final List<Network> network;
  NetworkData({
    required this.network,
  });

  Map<String, dynamic> toMap() {
    return {
      'network': network.map((x) => x.toMap()).toList(),
    };
  }

  factory NetworkData.fromMap(Map<String, dynamic> map) {
    return NetworkData(
      network: List<Network>.from(map['network']?.map((x) => Network.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory NetworkData.fromJson(String source) => NetworkData.fromMap(json.decode(source));
}

class Network {
  final String networkName;
  final String chainId;
  Network({
    required this.networkName,
    required this.chainId,
  });

  Map<String, dynamic> toMap() {
    return {
      'network_name': networkName,
      'chain_id': chainId,
    };
  }

  factory Network.fromMap(Map<String, dynamic> map) {
    return Network(
      networkName: map['network_name'] ?? '',
      chainId: map['chain_id'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Network.fromJson(String source) => Network.fromMap(json.decode(source));
}
