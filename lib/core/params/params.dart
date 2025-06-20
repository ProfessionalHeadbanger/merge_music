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
  final int? albumId;
  final int? ownerId;
  final int? count;
  final int? offset;
  final String? accessKey;
  final String accessToken;
  final String v;

  AudioListParams({
    this.albumId,
    this.ownerId,
    this.count,
    this.offset,
    this.accessKey,
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

class AudioSearchParams {
  final String q;
  final int? count;
  final int? offset;
  final bool? performerOnly;
  final bool? autoComplete;
  final String accessToken;
  final String v;

  AudioSearchParams({
    required this.q,
    this.count,
    this.offset,
    this.performerOnly,
    this.autoComplete,
    required this.accessToken,
    required this.v,
  });
}

class AudioSearchPartialParams {
  final String q;

  AudioSearchPartialParams({required this.q});
}

class AudioSearchPlaylistsParams {
  final String q;
  final int? count;
  final int? offset;
  final String? filters;
  final String accessToken;
  final String v;

  AudioSearchPlaylistsParams({
    required this.q,
    this.count,
    this.offset,
    this.filters,
    required this.accessToken,
    required this.v,
  });
}

class AudioSearchAlbumsParams {
  final String q;
  final int? count;
  final int? offset;
  final String accessToken;
  final String v;

  AudioSearchAlbumsParams({
    required this.q,
    this.count,
    this.offset,
    required this.accessToken,
    required this.v,
  });
}

class AudioSearchArtistsParams {
  final String q;
  final int? count;
  final int? offset;
  final String accessToken;
  final String v;

  AudioSearchArtistsParams({
    required this.q,
    this.count,
    this.offset,
    required this.accessToken,
    required this.v,
  });
}

class GetPlaylistAudiosParams {
  final int? albumId;
  final int? ownerId;
  final String? accessKey;

  GetPlaylistAudiosParams({
    this.albumId,
    this.ownerId,
    this.accessKey,
  });
}

class GetArtistParams {
  final String artistId;
  final int? extended;
  final String accessToken;
  final String v;

  GetArtistParams({
    required this.artistId,
    this.extended,
    required this.accessToken,
    required this.v,
  });
}

class GetAudiosByArtistParams {
  final String artistId;
  final int? count;
  final int? offset;
  final String accessToken;
  final String v;

  GetAudiosByArtistParams({
    required this.artistId,
    this.count,
    this.offset,
    required this.accessToken,
    required this.v,
  });
}

class GetArtistByIdParams {
  final String artistId;

  GetArtistByIdParams({required this.artistId});
}

class GetRecommendationsParams {
  final int? userId;
  final String? targetAudio; // format: ownerId_trackId
  final int? count;
  final int? offset;
  final String accessToken;
  final String v;

  GetRecommendationsParams({
    this.userId,
    this.targetAudio,
    this.count,
    this.offset,
    required this.accessToken,
    required this.v,
  });
}

class AddAndDeleteParams {
  final int id;
  final int ownerId;
  final String accessToken;
  final String v;

  AddAndDeleteParams({
    required this.id,
    required this.ownerId,
    required this.accessToken,
    required this.v,
  });
}

class AddAndDeletePartialParams {
  final int id;
  final int ownerId;

  AddAndDeletePartialParams({
    required this.id,
    required this.ownerId,
  });
}

class DeezerSearchParams {
  final String artist;
  final String track;
  final int? limit;
  final String? order;
  final String? strict;

  DeezerSearchParams({
    required this.artist,
    required this.track,
    this.limit,
    this.order,
    this.strict,
  });
}
