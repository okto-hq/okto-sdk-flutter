import 'dart:convert';

class OrderDetailsNftResponse {
  final String status;
  final OrderDetailsNftData data;
  OrderDetailsNftResponse({
    required this.status,
    required this.data,
  });

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'data': data.toMap(),
    };
  }

  factory OrderDetailsNftResponse.fromMap(Map<String, dynamic> map) {
    return OrderDetailsNftResponse(
      status: map['status'] ?? '',
      data: OrderDetailsNftData.fromMap(map['data']),
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderDetailsNftResponse.fromJson(String source) => OrderDetailsNftResponse.fromMap(json.decode(source));
}

class OrderDetailsNftData {
  final int total;
  final List<Details> details;
  OrderDetailsNftData({
    required this.total,
    required this.details,
  });

  Map<String, dynamic> toMap() {
    return {
      'total': total,
      'details': details.map((x) => x.toMap()).toList(),
    };
  }

  factory OrderDetailsNftData.fromMap(Map<String, dynamic> map) {
    return OrderDetailsNftData(
      total: map['total']?.toInt() ?? 0,
      details: List<Details>.from(map['details']?.map((x) => Details.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderDetailsNftData.fromJson(String source) => OrderDetailsNftData.fromMap(json.decode(source));
}

class Details {
  final String explorerSmartContractUrl;
  final String desctiption;
  final String type;
  final String collectionId;
  final String collectionName;
  final String nftTokenId;
  final String tokenUri;
  final String id;
  final String image;
  final String collectionAddress;
  final String collectionImage;
  final String networkName;
  final String networkId;
  final String nftName;
  Details({
    required this.explorerSmartContractUrl,
    required this.desctiption,
    required this.type,
    required this.collectionId,
    required this.collectionName,
    required this.nftTokenId,
    required this.tokenUri,
    required this.id,
    required this.image,
    required this.collectionAddress,
    required this.collectionImage,
    required this.networkName,
    required this.networkId,
    required this.nftName,
  });

  Map<String, dynamic> toMap() {
    return {
      'explorer_smart_contract_url': explorerSmartContractUrl,
      'desctiption': desctiption,
      'type': type,
      'collection_id': collectionId,
      'collection_name': collectionName,
      'nft_token_id': nftTokenId,
      'token_uri': tokenUri,
      'id': id,
      'image': image,
      'collection_address': collectionAddress,
      'collection_image': collectionImage,
      'network_name': networkName,
      'network_id': networkId,
      'nft_name': nftName,
    };
  }

  factory Details.fromMap(Map<String, dynamic> map) {
    return Details(
      explorerSmartContractUrl: map['explorer_smart_contract_url'] ?? '',
      desctiption: map['desctiption'] ?? '',
      type: map['type'] ?? '',
      collectionId: map['collection_id'] ?? '',
      collectionName: map['collection_name'] ?? '',
      nftTokenId: map['nft_token_id'] ?? '',
      tokenUri: map['token_uri'] ?? '',
      id: map['id'] ?? '',
      image: map['image'] ?? '',
      collectionAddress: map['collection_address'] ?? '',
      collectionImage: map['collection_image'] ?? '',
      networkName: map['network_name'] ?? '',
      networkId: map['network_id'] ?? '',
      nftName: map['nft_name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Details.fromJson(String source) => Details.fromMap(json.decode(source));
}
