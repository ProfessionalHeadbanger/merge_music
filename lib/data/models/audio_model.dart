import 'package:merge_music/domain/entities/audio_entity.dart';

class AudioModel extends AudioEntity {
  const AudioModel({
    required super.id,
    required super.ownerId,
    required super.artist,
    required super.title,
    required super.duration,
    required super.url,
    required super.hasLyrics,
    required super.lyricsId,
    required super.albumId,
    required super.genreId,
    required super.date,
    required super.noSearch,
    required super.isHq,
    required super.like,
    super.coverSmall,
    super.coverXL,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'owner_id': ownerId,
      'artist': artist,
      'title': title,
      'duration': duration,
      'url': url,
      'has_lyrics': hasLyrics,
      'lyrics_id': lyricsId,
      'album_id': albumId,
      'genre_id': genreId,
      'date': date,
      'no_search': noSearch,
      'is_hq': isHq,
      'like': like,
    };
  }

  factory AudioModel.fromJson(Map<String, dynamic> json) {
    return AudioModel(
      id: json['id'],
      ownerId: json['owner_id'],
      artist: json['artist'],
      title: json['title'],
      duration: json['duration'],
      url: json['url'],
      hasLyrics: json['has_lyrics'] ?? false,
      lyricsId: json['lyrics_id'],
      albumId: json['album_id'],
      genreId: json['genre_id'],
      date: json['date'],
      noSearch: json['no_search'] ?? 0,
      isHq: json['is_hq'],
      like: json['like'],
    );
  }

  @override
  AudioModel copyWith({
    int? id,
    int? ownerId,
    String? artist,
    String? title,
    int? duration,
    String? url,
    bool? hasLyrics,
    int? lyricsId,
    int? albumId,
    int? genreId,
    int? date,
    int? noSearch,
    int? isHq,
    bool? like,
    String? coverSmall,
    String? coverXL,
  }) {
    return AudioModel(
      id: id ?? this.id,
      ownerId: ownerId ?? this.ownerId,
      artist: artist ?? this.artist,
      title: title ?? this.title,
      duration: duration ?? this.duration,
      url: url ?? this.url,
      hasLyrics: hasLyrics ?? this.hasLyrics,
      lyricsId: lyricsId ?? this.lyricsId,
      albumId: albumId ?? this.albumId,
      genreId: genreId ?? this.genreId,
      date: date ?? this.date,
      noSearch: noSearch ?? this.noSearch,
      isHq: isHq ?? this.isHq,
      like: like ?? this.like,
      coverSmall: coverSmall ?? this.coverSmall,
      coverXL: coverXL ?? this.coverXL,
    );
  }
}
