class Utils {
  static String? extractAccessToken(String url) {
    if (url.startsWith("vk1")) {
      return url;
    }
    Match? tokenMatch = RegExp(r"access_token=([^&]+)").firstMatch(url);
    if (tokenMatch == null) {
      return null;
    }
    final token = tokenMatch.group(1).toString();
    if (!token.startsWith('vk1')) {
      return null;
    }
    return token;
  }
}
