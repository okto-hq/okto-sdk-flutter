import 'package:okto_flutter_sdk/src/models/token_v2.dart';

class OmsDataV2 {
  OmsDataV2({
    this.encodedCallData,
    this.encodedPaymaster,
    this.gasData,
    this.paymasterData,
    this.details,
    this.callData,
  });

  OmsDataV2.fromJson(dynamic json) {
    encodedCallData = json['encodedCallData'];
    encodedPaymaster = json['encodedPaymaster'];
    gasData =
        json['gasData'] != null ? GasData.fromJson(json['gasData']) : null;
    paymasterData = json['paymasterData'] != null
        ? PaymasterData.fromJson(json['paymasterData'])
        : null;
    details =
        json['details'] != null ? EstimationDetail.fromJson(json['details']) : null;
    callData =
        json['callData'] != null ? CallDataV2.fromJson(json['callData']) : null;
  }

  String? encodedCallData;
  String? encodedPaymaster;
  GasData? gasData;
  PaymasterData? paymasterData;
  EstimationDetail? details;
  CallDataV2? callData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['encodedCallData'] = encodedCallData;
    map['encodedPaymaster'] = encodedPaymaster;
    if (gasData != null) {
      map['gasData'] = gasData?.toJson();
    }
    if (paymasterData != null) {
      map['paymasterData'] = paymasterData?.toJson();
    }
    if (details != null) {
      map['details'] = details?.toJson();
    }
    if (callData != null) {
      map['callData'] = callData?.toJson();
    }
    return map;
  }
}

/// intentType : "TOKEN_TRANSFER"
/// jobId : "<job-id>"
/// vendorId : "venderId"
/// creatorId : "<userAddress>"
/// policies : {"gsnEnabled":false,"sponsorshipEnabled":false}
/// gsn : {"isRequired":false,"details":{"requiredNetworks":["...caipNetworkId..."],"tokens":[{"networkId":"...caipNetworkId ...","address":"...","amount":"...","amountInUSDT":"..."}]}}
/// payload : {"recipientWalletAddress":"0x32Df3751A8FD122F984eCf468Ca562Ca20b13A6A","networkId":"...caipNetworkId...","tokenAddress":"...address...","amount":"1000"}

class CallDataV2 {
  CallDataV2({
    this.intentType,
    this.jobId,
    this.vendorId,
    this.creatorId,
    this.policies,
    this.gsn,
    this.payload,
  });

  CallDataV2.fromJson(dynamic json) {
    intentType = json['intentType'];
    jobId = json['jobId'];
    vendorId = json['vendorId'];
    creatorId = json['creatorId'];
    policies =
        json['policies'] != null ? Policies.fromJson(json['policies']) : null;
    gsn = json['gsn'] != null ? GsnV2.fromJson(json['gsn']) : null;
    payload =
        json['payload'] != null ? PayloadV2.fromJson(json['payload']) : null;
  }

  String? intentType;
  String? jobId;
  String? vendorId;
  String? creatorId;
  Policies? policies;
  GsnV2? gsn;
  PayloadV2? payload;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['intentType'] = intentType;
    map['jobId'] = jobId;
    map['vendorId'] = vendorId;
    map['creatorId'] = creatorId;
    if (policies != null) {
      map['policies'] = policies?.toJson();
    }
    if (gsn != null) {
      map['gsn'] = gsn?.toJson();
    }
    if (payload != null) {
      map['payload'] = payload?.toJson();
    }
    return map;
  }
}

/// recipientWalletAddress : "0x32Df3751A8FD122F984eCf468Ca562Ca20b13A6A"
/// networkId : "...caipNetworkId..."
/// tokenAddress : "...address..."
/// amount : "1000"

class PayloadV2 {
  PayloadV2({
    this.recipientWalletAddress,
    this.networkId,
    this.tokenAddress,
    this.amount,
  });

  PayloadV2.fromJson(dynamic json) {
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

/// isRequired : false
/// details : {"requiredNetworks":["...caipNetworkId..."],"tokens":[{"networkId":"...caipNetworkId ...","address":"...","amount":"...","amountInUSDT":"..."}]}

class GsnV2 {
  GsnV2({
    this.isRequired,
    this.details,
  });

  GsnV2.fromJson(dynamic json) {
    isRequired = json['isRequired'];
    details =
        json['details'] != null ? GsnDetailsV2.fromJson(json['details']) : null;
  }

  bool? isRequired;
  GsnDetailsV2? details;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['isRequired'] = isRequired;
    if (details != null) {
      map['details'] = details?.toJson();
    }
    return map;
  }
}

/// requiredNetworks : ["...caipNetworkId..."]
/// tokens : [{"networkId":"...caipNetworkId ...","address":"...","amount":"...","amountInUSDT":"..."}]

class GsnDetailsV2 {
  GsnDetailsV2({
    this.requiredNetworks,
    this.tokens,
  });

  GsnDetailsV2.fromJson(dynamic json) {
    requiredNetworks = json['requiredNetworks'] != null
        ? json['requiredNetworks'].cast<String>()
        : [];
    if (json['tokens'] != null) {
      tokens = [];
      json['tokens'].forEach((v) {
        tokens?.add(TokenV2.fromJson(v));
      });
    }
  }

  List<String>? requiredNetworks;
  List<TokenV2>? tokens;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['requiredNetworks'] = requiredNetworks;
    if (tokens != null) {
      map['tokens'] = tokens?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// gsnEnabled : false
/// sponsorshipEnabled : false

class Policies {
  Policies({
    this.gsnEnabled,
    this.sponsorshipEnabled,
  });

  Policies.fromJson(dynamic json) {
    gsnEnabled = json['gsnEnabled'];
    sponsorshipEnabled = json['sponsorshipEnabled'];
  }

  bool? gsnEnabled;
  bool? sponsorshipEnabled;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['gsnEnabled'] = gsnEnabled;
    map['sponsorshipEnabled'] = sponsorshipEnabled;
    return map;
  }
}

/// estimation : {"amount":""}
/// fees : {"transactionFees":{"caipNetworkId1":"gasFee","caipNetworkId2":"gasFee"},"approxTransactionFeesInUSDT":"0.1"}

class EstimationDetail {
  EstimationDetail({
    this.estimation,
    this.fees,
  });

  EstimationDetail.fromJson(dynamic json) {
    estimation = json['estimation'] != null
        ? Estimation.fromJson(json['estimation'])
        : null;
    fees = json['fees'] != null ? Fees.fromJson(json['fees']) : null;
  }

  Estimation? estimation;
  Fees? fees;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (estimation != null) {
      map['estimation'] = estimation?.toJson();
    }
    if (fees != null) {
      map['fees'] = fees?.toJson();
    }
    return map;
  }
}

/// transactionFees : {"caipNetworkId1":"gasFee","caipNetworkId2":"gasFee"}
/// approxTransactionFeesInUSDT : "0.1"

class Fees {
  Fees({
    this.transactionFees,
    this.approxTransactionFeesInUSDT,
  });

  Fees.fromJson(dynamic json) {
    transactionFees = json['transactionFees'] != null
        ? TransactionFees.fromJson(json['transactionFees'])
        : null;
    approxTransactionFeesInUSDT = json['approxTransactionFeesInUSDT'];
  }

  TransactionFees? transactionFees;
  String? approxTransactionFeesInUSDT;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (transactionFees != null) {
      map['transactionFees'] = transactionFees?.toJson();
    }
    map['approxTransactionFeesInUSDT'] = approxTransactionFeesInUSDT;
    return map;
  }
}

/// caipNetworkId1 : "gasFee"
/// caipNetworkId2 : "gasFee"

class TransactionFees {
  TransactionFees({
    this.caipNetworkId1,
    this.caipNetworkId2,
  });

  TransactionFees.fromJson(dynamic json) {
    caipNetworkId1 = json['caipNetworkId1'];
    caipNetworkId2 = json['caipNetworkId2'];
  }

  String? caipNetworkId1;
  String? caipNetworkId2;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['caipNetworkId1'] = caipNetworkId1;
    map['caipNetworkId2'] = caipNetworkId2;
    return map;
  }
}

/// amount : ""

class Estimation {
  Estimation({
    this.amount,
  });

  Estimation.fromJson(dynamic json) {
    amount = json['amount'];
  }

  String? amount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['amount'] = amount;
    return map;
  }
}

/// paymasterId : "<address deployed for vendor>"
/// validUntil : "<unixmilli>"
/// validAfter : "<unixmilli>"

class PaymasterData {
  PaymasterData({
    this.paymasterId,
    this.validUntil,
    this.validAfter,
  });

  PaymasterData.fromJson(dynamic json) {
    paymasterId = json['paymasterId'];
    validUntil = json['validUntil'];
    validAfter = json['validAfter'];
  }

  String? paymasterId;
  String? validUntil;
  String? validAfter;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['paymasterId'] = paymasterId;
    map['validUntil'] = validUntil;
    map['validAfter'] = validAfter;
    return map;
  }
}

/// callGasLimit : "<>"
/// verificationGasLimit : "<>"
/// preVerificationGas : "<>"
/// paymasterVerificationGasLimit : "<>"
/// paymasterPostOpGasLimit : "<>"

class GasData {
  GasData({
    this.callGasLimit,
    this.verificationGasLimit,
    this.preVerificationGas,
    this.paymasterVerificationGasLimit,
    this.paymasterPostOpGasLimit,
  });

  GasData.fromJson(dynamic json) {
    callGasLimit = json['callGasLimit'];
    verificationGasLimit = json['verificationGasLimit'];
    preVerificationGas = json['preVerificationGas'];
    paymasterVerificationGasLimit = json['paymasterVerificationGasLimit'];
    paymasterPostOpGasLimit = json['paymasterPostOpGasLimit'];
  }

  String? callGasLimit;
  String? verificationGasLimit;
  String? preVerificationGas;
  String? paymasterVerificationGasLimit;
  String? paymasterPostOpGasLimit;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['callGasLimit'] = callGasLimit;
    map['verificationGasLimit'] = verificationGasLimit;
    map['preVerificationGas'] = preVerificationGas;
    map['paymasterVerificationGasLimit'] = paymasterVerificationGasLimit;
    map['paymasterPostOpGasLimit'] = paymasterPostOpGasLimit;
    return map;
  }
}
