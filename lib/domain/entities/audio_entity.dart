class AudioEntity {
  final int id;
  final int ownerId;
  final String artist;
  final String title;
  final int duration;
  final String url;
  final bool hasLyrics;
  final int? lyricsId;
  final int? albumId;
  final int? genreId;
  final int date;
  final int noSearch;
  final int? isHq;
  final bool? like;

  final String? coverSmall;
  final String? coverXL;

  AudioEntity({
    required this.id,
    required this.ownerId,
    required this.artist,
    required this.title,
    required this.duration,
    required this.url,
    required this.hasLyrics,
    required this.lyricsId,
    required this.albumId,
    required this.genreId,
    required this.date,
    required this.noSearch,
    required this.isHq,
    required this.like,
    this.coverSmall,
    this.coverXL,
  });

  AudioEntity copyWith({
    String? coverSmall,
    String? coverXL,
  }) {
    return AudioEntity(
      id: id,
      ownerId: ownerId,
      artist: artist,
      title: title,
      duration: duration,
      url: url,
      hasLyrics: hasLyrics,
      lyricsId: lyricsId,
      albumId: albumId,
      genreId: genreId,
      date: date,
      noSearch: noSearch,
      isHq: isHq,
      like: like,
      coverSmall: coverSmall ?? this.coverSmall,
      coverXL: coverXL ?? this.coverXL,
    );
  }
}
