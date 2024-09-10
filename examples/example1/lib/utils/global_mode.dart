import 'package:okto_flutter_sdk/okto_flutter_sdk.dart';

class Globals {
  BuildType currentBuildType = BuildType.staging;
  String globalClientApiKey = '';

  static final Globals _singleton = Globals._internal();

  factory Globals() {
    return _singleton;
  }

  Globals._internal();

  static Globals get instance => _singleton;

  void setApiKey(String apiKey) {
    globalClientApiKey = apiKey;
  }

  void setBuildType(BuildType buildType) {
    currentBuildType = buildType;
  }

  BuildType getBuildType() {
    return currentBuildType;
  }

  String getApiKey() {
    return globalClientApiKey;
  }

  
}
