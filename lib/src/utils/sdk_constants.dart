/// These values are used to testing purpose only, please do not use in production.
class SdkConstants {
  SdkConstants._();
  static const STAGING staging = STAGING();
  static const SANDBOX sandbox = SANDBOX();
  static const PRODUCTION production = PRODUCTION();

  static const String maxPriorityFeePerGas =  "0xBA43B7400";
  static const String maxFeePerGas = "0xBA43B7400";
}

class STAGING {
  const STAGING();
  String get clientSWA => "0x15256FEB5fAea1662Ce9A3fB8A46237B81b6Dfb1";
  String get clientPrivateKey => '2e0df50c533f55a6835f793c0dd8f004ce4e497221243548a9f1b2f8e6a3f261';
  String get clientApiKey => 'a4a65061-6054-4f6d-ac86-7edfb2558b7c';
}

class SANDBOX {
  const SANDBOX();
  String get clientSWA => "0xb532926d0dBC2799Cf8BE2d6e2F1ef8Bd27CaA0c";
  String get clientPrivateKey => '2aaa089f7e26ad3d2da3518e1e945d76804372b6bdd044c7f059598c31fa7dcc';
  String get clientApiKey => "b7a36ee9-80e3-4063-b2a1-f9f482a8db51";
}

class PRODUCTION {
  const PRODUCTION();
  String get clientSWA => "";
  String get clientPrivateKey => '';
  String get clientApiKey => "";
}