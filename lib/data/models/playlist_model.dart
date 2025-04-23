import 'package:merge_music/data/models/artist_model.dart';
import 'package:merge_music/domain/entities/artist_entity.dart';
import 'package:merge_music/domain/entities/playlist_entity.dart';

class PlaylistModel extends PlaylistEntity {
  PlaylistModel({
    required super.id,
    required super.ownerId,
    required super.type,
    required super.title,
    required super.isFollowing,
    required super.year,
    required super.photo135,
    required super.photo300,
    required super.photo1200,
    required super.description,
    required super.count,
    required super.plays,
    required super.genres,
    required super.accessKey,
    required super.mainArtists,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'owner_id': ownerId,
      'type': type,
      'title': title,
      'is_following': isFollowing,
      'year': year,
      'photo_135': photo135,
      'photo_300': photo300,
      'photo_1200': photo1200,
      'description': description,
      'count': count,
      'plays': plays,
      'genres': genres,
      'access_key': accessKey,
      'main_artists': mainArtists,
    };
  }

  factory PlaylistModel.fromJson(Map<String, dynamic> json) {
    return PlaylistModel(
      id: json['id'],
      ownerId: json['owner_id'],
      type: json['type'],
      title: json['title'],
      isFollowing: json['is_following'],
      year: json['year'],
      photo135: json['photo']['photo_135'],
      photo300: json['photo']['photo_300'],
      photo1200: json['photo']['photo_1200'],
      description: json['description'],
      count: json['count'],
      plays: json['plays'],
      genres: (json['genres'] as List<dynamic>?)
              ?.map((genre) => genre['name'] as String)
              .toList() ??
          [],
      accessKey: json['access_key'],
      mainArtists: json['main_artists'] == null
          ? null
          : List<ArtistEntity>.from(
              json['main_artists'].map((x) => ArtistModel.fromJson(x)),
            ),
    );
  }

  PlaylistModel copyWith({
    int? id,
    int? ownerId,
    int? type,
    String? title,
    bool? isFollowing,
    int? year,
    String? photo135,
    String? photo300,
    String? photo1200,
    String? description,
    int? count,
    int? plays,
    List<String>? genres,
    String? accessKey,
    List<ArtistEntity>? mainArtists,
  }) {
    return PlaylistModel(
      id: id ?? this.id,
      ownerId: ownerId ?? this.ownerId,
      type: type ?? this.type,
      title: title ?? this.title,
      isFollowing: isFollowing ?? this.isFollowing,
      year: year ?? this.year,
      photo135: photo135 ?? this.photo135,
      photo300: photo300 ?? this.photo300,
      photo1200: photo1200 ?? this.photo1200,
      description: description ?? this.description,
      count: count ?? this.count,
      plays: plays ?? this.plays,
      genres: genres ?? this.genres,
      accessKey: accessKey ?? this.accessKey,
      mainArtists: mainArtists ?? this.mainArtists,
    );
  }
}
