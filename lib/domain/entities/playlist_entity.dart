import 'package:equatable/equatable.dart';
import 'package:merge_music/domain/entities/artist_entity.dart';

class PlaylistEntity extends Equatable {
  final int id;
  final int ownerId;
  final int type;
  final String title;
  final String? description;
  final int? count;
  final int? plays;
  final List<String>? genres;
  final bool isFollowing;
  final int? year;
  final String photo135;
  final String photo300;
  final String photo1200;
  final String? accessKey;
  final List<ArtistEntity>? mainArtists;

  const PlaylistEntity({
    required this.id,
    required this.ownerId,
    required this.type,
    required this.title,
    required this.description,
    required this.count,
    required this.plays,
    required this.genres,
    required this.isFollowing,
    required this.year,
    required this.photo135,
    required this.photo300,
    required this.photo1200,
    required this.accessKey,
    required this.mainArtists,
  });

  @override
  List<Object?> get props => [
        id,
        ownerId,
        type,
        title,
        description,
        count,
        plays,
        genres,
        isFollowing,
        year,
        photo135,
        photo300,
        photo1200,
        accessKey,
        mainArtists,
      ];

  PlaylistEntity copyWith({
    int? id,
    int? ownerId,
    int? type,
    String? title,
    String? description,
    int? count,
    int? plays,
    List<String>? genres,
    bool? isFollowing,
    int? year,
    String? photo135,
    String? photo300,
    String? photo1200,
    String? accessKey,
    List<ArtistEntity>? mainArtists,
  }) {
    return PlaylistEntity(
      id: id ?? this.id,
      ownerId: ownerId ?? this.ownerId,
      type: type ?? this.type,
      title: title ?? this.title,
      description: description ?? this.description,
      count: count ?? this.count,
      plays: plays ?? this.plays,
      genres: genres ?? this.genres,
      isFollowing: isFollowing ?? this.isFollowing,
      year: year ?? this.year,
      photo135: photo135 ?? this.photo135,
      photo300: photo300 ?? this.photo300,
      photo1200: photo1200 ?? this.photo1200,
      accessKey: accessKey ?? this.accessKey,
      mainArtists: mainArtists ?? this.mainArtists,
    );
  }
}
