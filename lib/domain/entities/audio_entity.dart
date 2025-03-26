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
  });
}
