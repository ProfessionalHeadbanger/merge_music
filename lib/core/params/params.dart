class NoParams {}

class AudioListParams {
  final int count;
  final int? offset;
  final String accessToken;
  final String v;

  AudioListParams({
    required this.count,
    this.offset,
    required this.accessToken,
    required this.v,
  });
}

class VkLoginParams {
  final String login;
  final String password;

  VkLoginParams({
    required this.login,
    required this.password,
  });
}

class Request2faParams {
  final String redirectUri;

  Request2faParams({required this.redirectUri});
}
