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

  static String? extractUserId(String url) {
    final uri = Uri.parse(url);
    final fragment = uri.fragment;
    final params = Uri.splitQueryString(fragment);

    return params['user_id'];
  }

  static String formatDuration(int duration) {
    final minutes = duration ~/ 60;
    final seconds = duration % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }
}
