class NoParams {}

class UserParams {
  final String? userIds;
  final List<String>? fields;
  final String accessToken;
  final String v;

  UserParams({
    this.userIds,
    this.fields,
    required this.accessToken,
    required this.v,
  });
}

class AudioListParams {
  final int? ownerId;
  final int? albumId;
  final int? count;
  final int? offset;
  final String accessToken;
  final String v;

  AudioListParams({
    this.ownerId,
    this.albumId,
    required this.count,
    this.offset,
    required this.accessToken,
    required this.v,
  });
}

class PlaylistListParams {
  final int ownerId;
  final int? count;
  final int? offset;
  final int? extended;
  final String? filters;
  final String accessToken;
  final String v;

  PlaylistListParams({
    required this.ownerId,
    this.count,
    this.offset,
    this.extended,
    this.filters,
    required this.accessToken,
    required this.v,
  });
}
