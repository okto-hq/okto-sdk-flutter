import '../../okto_flutter_sdk.dart';

class Utility {

  static String getBaseUrl(BuildType buildType) {
    switch(buildType) {
      case BuildType.production: {
        return "https://3p.okto.tech";
      }
      case BuildType.sandbox: {
        return "https://sandbox-api.okto.tech";
      }
      default:
        return "https://3p-bff.oktostage.com";
    }
  }

  static String getRpcBaseUrl(BuildType buildType) {
    return "https://okto-gateway.oktostage.com";
  }
}