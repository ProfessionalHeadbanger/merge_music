import 'package:merge_music/domain/entities/audio_entity.dart';

class AudioModel extends AudioEntity {
  AudioModel({
    required super.id,
    required super.ownerId,
    required super.artist,
    required super.title,
    required super.duration,
    required super.url,
    required super.lyricsId,
    required super.albumId,
    required super.genreId,
    required super.date,
    required super.noSearch,
    required super.isHq,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ownerId': ownerId,
      'artist': artist,
      'title': title,
      'duration': duration,
      'url': url,
      'lyricsId': lyricsId,
      'albumId': albumId,
      'genreId': genreId,
      'date': date,
      'noSearch': noSearch,
      'isHq': isHq,
    };
  }

  factory AudioModel.fromJson(Map<String, dynamic> json) {
    return AudioModel(
      id: json['id'],
      ownerId: json['ownerId'],
      artist: json['artist'],
      title: json['title'],
      duration: json['duration'],
      url: json['url'],
      lyricsId: json['lyricsId'],
      albumId: json['albumId'],
      genreId: json['genreId'],
      date: json['date'],
      noSearch: json['noSearch'],
      isHq: json['isHq'],
    );
  }

  AudioModel copyWith({
    int? id,
    int? ownerId,
    String? artist,
    String? title,
    int? duration,
    String? url,
    int? lyricsId,
    int? albumId,
    int? genreId,
    int? date,
    int? noSearch,
    int? isHq,
  }) {
    return AudioModel(
      id: id ?? this.id,
      ownerId: ownerId ?? this.ownerId,
      artist: artist ?? this.artist,
      title: title ?? this.title,
      duration: duration ?? this.duration,
      url: url ?? this.url,
      lyricsId: lyricsId ?? this.lyricsId,
      albumId: albumId ?? this.albumId,
      genreId: genreId ?? this.genreId,
      date: date ?? this.date,
      noSearch: noSearch ?? this.noSearch,
      isHq: isHq ?? this.isHq,
    );
  }
}
