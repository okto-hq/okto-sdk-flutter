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
  final int count;
  final List<Nfts> nfts;
  OrderDetailsNftData({
    required this.count,
    required this.nfts,
  });

  Map<String, dynamic> toMap() {
    return {
      'count': count,
      'nfts': nfts.map((x) => x.toMap()).toList(),
    };
  }

  factory OrderDetailsNftData.fromMap(Map<String, dynamic> map) {
    return OrderDetailsNftData(
      count: map['count']?.toInt() ?? 0,
      nfts: List<Nfts>.from(map['nfts']?.map((x) => Nfts.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderDetailsNftData.fromJson(String source) => OrderDetailsNftData.fromMap(json.decode(source));
}

class Nfts {
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
  Nfts({
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

  factory Nfts.fromMap(Map<String, dynamic> map) {
    return Nfts(
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

  factory Nfts.fromJson(String source) => Nfts.fromMap(json.decode(source));
}
