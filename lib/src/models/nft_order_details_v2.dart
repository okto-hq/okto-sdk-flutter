class NftOrderDetailsV2 {
  String? status;
  OrderDetailsV2 data;

  NftOrderDetailsV2({
    required this.status,
    required this.data,
  });

  NftOrderDetailsV2.fromJson(dynamic json)
      : status = json['status'],
        data = OrderDetailsV2.fromJson(json['data']);

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['data'] = data.toJson();
    return map;
  }
}

class OrderDetailsV2 {
  List<DetailsV2>? executed;

  OrderDetailsV2({
    required this.executed,
  });

  OrderDetailsV2.fromJson(dynamic json) {
    if (json['executed'] != null) {
      executed = [];
      json['executed'].forEach((v) {
        executed?.add(DetailsV2.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['executed'] = executed?.map((v) => v.toJson()).toList();
    return map;
  }
}

class DetailsV2 {
  String? jobId;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? orderType;
  String? networkId;
  String? collectionAddress;
  String? collectionId;

  DetailsV2({
    this.jobId,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.orderType,
    this.networkId,
    this.collectionAddress,
    this.collectionId
  });

  DetailsV2.fromJson(dynamic json) {
    jobId = json['job_id'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    orderType = json['order_type'];
    networkId = json['network_id'];
    collectionAddress = json['collection_address'];
    collectionId = json['collection_id'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['job_id'] = jobId;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['order_type'] = orderType;
    map['network_id'] = networkId;
    map['collection_address'] = collectionAddress;
    map['collection_id'] = collectionId;
    return map;
  }
}
