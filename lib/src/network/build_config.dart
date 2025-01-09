
import 'environment.dart';

class BuildConfig {
  late final Environment environment;
  bool _lock = false;

  static final BuildConfig instance = BuildConfig._internal();

  BuildConfig._internal();

  factory BuildConfig.instantiate({
    required Environment envType,
  }) {
    if (instance._lock) return instance;

    instance.environment = envType;
    instance._lock = true;

    return instance;
  }
}
