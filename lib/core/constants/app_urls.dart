import 'package:barcode_mapping/config/env_config.dart';

abstract class AppUrls {
  static String get baseUrlWithPort => EnvConfig.baseUrlWithPort;
  static String get host => EnvConfig.apiHost;
  static String get tokenNew => 'Bearer ${EnvConfig.authTokenNew}';

  static String get domain => EnvConfig.domain;
  static String get tokenIrfan => 'Bearer ${EnvConfig.authTokenIrfan}';

  // Alessa urls
  static String get base => EnvConfig.base;
  static String get token => 'Bearer ${EnvConfig.authToken}';

  // New Gtrack V.2 Urls
  static String get baseUrl => EnvConfig.baseUrl;
}
