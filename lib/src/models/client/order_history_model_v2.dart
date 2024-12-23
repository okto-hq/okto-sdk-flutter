class OrderHistoryResponseV2 {
  String? status;
  OrderHistoryDataV2? data;

  OrderHistoryResponseV2({
    this.status,
    this.data,
  });

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'data': data?.toMap(),
    };
  }

  factory OrderHistoryResponseV2.fromMap(Map<String, dynamic> map) {
    return OrderHistoryResponseV2(
      status: map['status'],
      data: OrderHistoryDataV2.fromMap(map['data']),
    );
  }
}

class OrderHistoryDataV2 {
  final String? transactionHash;
  final List<String>? downstreamTransactionHash;
  final String? status;
  final String? orderId;
  final String? intentType;
  final String? networkName;
  final String? caipId;
  final OrderDetails? details;

  OrderHistoryDataV2({
    this.transactionHash,
    this.downstreamTransactionHash,
    this.status,
    this.orderId,
    this.intentType,
    this.networkName,
    this.caipId,
    this.details,
  });

  Map<String, dynamic> toMap() {
    return {
      'transaction_hash': transactionHash,
      'downstream_transaction_hash': downstreamTransactionHash,
      'status': status,
      'order_id': orderId,
      'intent_type': intentType,
      'network_name': networkName,
      'caip_id': caipId,
      'details': details?.toMap(),
    };
  }

  factory OrderHistoryDataV2.fromMap(Map<String, dynamic> map) {
    return OrderHistoryDataV2(
      transactionHash: map['transaction_hash'],
      downstreamTransactionHash:
          List<String>.from(map['downstream_transaction_hash']),
      status: map['status'],
      orderId: map['order_id'],
      intentType: map['intent_type'],
      networkName: map['network_name'],
      caipId: map['caip_id'],
      details: OrderDetails.fromMap(map['details']),
    );
  }
}

class OrderDetails {
  final String? recipientWalletAddress;
  final String? networkId;
  final String? tokenAddress;
  final String? amount;

  OrderDetails({
    this.recipientWalletAddress,
    this.networkId,
    this.tokenAddress,
    this.amount,
  });

  Map<String, dynamic> toMap() {
    return {
      'recipient_wallet_address': recipientWalletAddress,
      'network_id': networkId,
      'token_address': tokenAddress,
      'amount': amount,
    };
  }

  factory OrderDetails.fromMap(Map<String, dynamic> map) {
    return OrderDetails(
      recipientWalletAddress: map['recipient_wallet_address'],
      networkId: map['network_id'],
      tokenAddress: map['token_address'],
      amount: map['amount'],
    );
  }
}
