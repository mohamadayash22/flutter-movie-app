import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
  Env._();

  static String get apiKey => _get('API_KEY');
  static String get baseUrl => _get('API_BASE_URL');

  static String _get(String key) {
    final value = dotenv.env[key];
    if (value == null || value.isEmpty) {
      throw Exception('Missing env variable: $key');
    }
    return value;
  }
}
