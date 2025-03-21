import 'package:okto_flutter_sdk/okto_flutter_sdk.dart';

class Globals {
  Env currentBuildType = Env.staging;
  String globalClientApiKey = '';
  String clientSwa = '';
  String clientPrivateKey = '';

  static final Globals _singleton = Globals._internal();

  factory Globals() {
    return _singleton;
  }

  Globals._internal();

  static Globals get instance => _singleton;

  void setApiKey(String apiKey) {
    globalClientApiKey = apiKey;
  }

  void setBuildType(Env buildType) {
    currentBuildType = buildType;
  }

  Env getBuildType() {
    return currentBuildType;
  }

  String getApiKey() {
    return globalClientApiKey;
  }

  void setClientSwa(String swa) {
    clientSwa = swa;
  }

  void setClientPrivateKey(String privateKey) {
    clientPrivateKey = privateKey;
  }

  String getClientSwa() {
    return clientSwa;
  }

  String getClientPrivateKey() {
    return clientPrivateKey;
  }
}
