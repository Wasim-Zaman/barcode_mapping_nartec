import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvConfig {
  static String get apiBaseUrl => dotenv.env['API_BASE_URL'] ?? '';
  static String get apiHost => dotenv.env['API_HOST'] ?? '';
  static String get apiPort1 => dotenv.env['API_PORT_1'] ?? '';
  static String get apiPort2 => dotenv.env['API_PORT_2'] ?? '';
  static String get apiPort3 => dotenv.env['API_PORT_3'] ?? '';

  static String get authTokenNew => dotenv.env['AUTH_TOKEN_NEW'] ?? '';
  static String get authTokenIrfan => dotenv.env['AUTH_TOKEN_IRFAN'] ?? '';
  static String get authToken => dotenv.env['AUTH_TOKEN'] ?? '';

  static String get baseUrlWithPort => '$apiBaseUrl:$apiPort1/api/';
  static String get base => '$apiBaseUrl:$apiPort2/api/';
  static String get baseUrl => '$apiBaseUrl:$apiPort3/';
  static String get domain => apiBaseUrl;
}
