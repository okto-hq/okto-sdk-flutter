class EstimateRequestV2 {
  EstimateRequestV2({
      this.recipientWalletAddress, 
      this.networkId, 
      this.tokenAddress, 
      this.amount,});

  EstimateRequestV2.fromJson(dynamic json) {
    recipientWalletAddress = json['recipientWalletAddress'];
    networkId = json['networkId'];
    tokenAddress = json['tokenAddress'];
    amount = json['amount'];
  }
  String? recipientWalletAddress;
  String? networkId;
  String? tokenAddress;
  String? amount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['recipientWalletAddress'] = recipientWalletAddress;
    map['networkId'] = networkId;
    map['tokenAddress'] = tokenAddress;
    map['amount'] = amount;
    return map;
  }

}