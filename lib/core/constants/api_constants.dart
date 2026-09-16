class ApiConstants {
  ApiConstants._();

  static const String supabaseUrl = 'url';

  static const String supabaseAnonKey = String.fromEnvironment(
    'publishablkey',
  );
}
