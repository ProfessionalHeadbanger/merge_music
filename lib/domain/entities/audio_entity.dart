import 'package:equatable/equatable.dart';

class AudioEntity extends Equatable {
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

  const AudioEntity({
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

  @override
  List<Object?> get props => [
        id,
        ownerId,
        artist,
        title,
        duration,
        url,
        hasLyrics,
        lyricsId,
        albumId,
        genreId,
        date,
        noSearch,
        isHq,
        like,
        coverSmall,
        coverXL,
      ];

  AudioEntity copyWith({
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
    return AudioEntity(
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
