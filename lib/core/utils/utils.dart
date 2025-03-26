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

  static String formatDuration(int duration) {
    final minutes = duration ~/ 60;
    final seconds = duration % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }
}
