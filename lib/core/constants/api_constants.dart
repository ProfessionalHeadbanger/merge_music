class ApiConstants {
  // Общие константы
  static const String v = '5.199';

  // Константы для авторизации
  static const String oauthUrl = 'https://oauth.vk.com/token';
  static const String clientId = '2274003';
  static const String clientSecret = 'hHbZxrka2uZ6jB1inYsH';
  static const String grantType = 'password';
  static const String scope = 'nohttps.audio';
  static const String validateToken = 'true';
  static const String faSupport = '1';

  // Константы для API
  static const String baseUrl = 'https://api.vk.com/method/';
  static const String audioGet = 'audio.get';
  static const int batchCount = 6000;
  static const int mainPageBatchCount = 15;
}
