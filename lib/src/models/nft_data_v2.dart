class NftDataV2 {

  num? count;
  List<NftDetailsV2>? details;

  NftDataV2({
      this.count, 
      this.details,
  });

  NftDataV2.fromJson(dynamic json) {
    count = json['count'];
    if (json['details'] != null) {
      details = [];
      json['details'].forEach((v) {
        details?.add(NftDetailsV2.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['count'] = count;
    if (details != null) {
      map['details'] = details?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class NftDetailsV2 {
  NftDetailsV2({
      this.caipId, 
      this.networkName, 
      this.entityType, 
      this.collectionAddress, 
      this.collectionName, 
      this.nftId, 
      this.image, 
      this.quantity, 
      this.tokenUri, 
      this.description, 
      this.nftName, 
      this.explorerSmartContractUrl, 
      this.collectionImage,});

  NftDetailsV2.fromJson(dynamic json) {
    caipId = json['caip_id'];
    networkName = json['network_name'];
    entityType = json['entity_type'];
    collectionAddress = json['collection_address'];
    collectionName = json['collection_name'];
    nftId = json['nft_id'];
    image = json['image'];
    quantity = json['quantity'];
    tokenUri = json['token_uri'];
    description = json['description'];
    nftName = json['nft_name'];
    explorerSmartContractUrl = json['explorer_smart_contract_url'];
    collectionImage = json['CollectionImage'];
    collectionId = json['collection_id'];
    networkId = json['network_id'];
  }
  String? caipId;
  String? networkName;
  String? entityType;
  String? collectionAddress;
  String? collectionName;
  String? nftId;
  String? image;
  String? quantity;
  String? tokenUri;
  String? description;
  String? nftName;
  String? explorerSmartContractUrl;
  String? collectionImage;
  String? collectionId;
  String? networkId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['caip_id'] = caipId;
    map['network_name'] = networkName;
    map['entity_type'] = entityType;
    map['collection_address'] = collectionAddress;
    map['collection_name'] = collectionName;
    map['nft_id'] = nftId;
    map['image'] = image;
    map['quantity'] = quantity;
    map['token_uri'] = tokenUri;
    map['description'] = description;
    map['nft_name'] = nftName;
    map['explorer_smart_contract_url'] = explorerSmartContractUrl;
    map['CollectionImage'] = collectionImage;
    map['collection_id'] = collectionId;
    map['network_id'] = networkId;
    return map;
  }

}