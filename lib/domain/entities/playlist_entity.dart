import 'package:merge_music/domain/entities/artist_entity.dart';

class PlaylistEntity {
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

  PlaylistEntity({
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
}
