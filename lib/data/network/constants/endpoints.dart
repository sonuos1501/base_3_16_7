import '../../../configs/env/env_state.dart';

class Endpoints {
  Endpoints._();

  // base url
  static final String _baseUrl = EnvValue.env.baseUrlApi;

  static const String _versionApi = 'v1.0';

  // receiveTimeout
  static const int receiveTimeout = 15000;

  // connectTimeout
  static const int connectionTimeout = 30000;

  // booking endpoints
  static final String login = '$_baseUrl/api/$_versionApi/?type=login';
}
