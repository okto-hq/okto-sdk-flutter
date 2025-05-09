import 'package:okto_network_manager/enums.dart';

import '../../okto_flutter_sdk.dart';

class Utility {

  static BuildType getBuildType(Env env) {
    switch (env) {
      case Env.staging:{
        return BuildType.staging;
      }
      case Env.sandbox:
        return BuildType.sandbox;

      default:
        return BuildType.production;
    }
  }

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
    switch(buildType) {
      case BuildType.production: {
        return "https://rpc.okto.tech"; //TODO change this
      }
      case BuildType.sandbox: {
        return 'https://sandbox-okto-gateway.oktostage.com';
      }
      default:
        return "https://okto-gateway.oktostage.com";
    }
  }
}