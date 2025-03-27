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
