class PlaylistEntity {
  final int id;
  final int ownerId;
  final int type;
  final String title;
  final bool isFollowing;
  final int? year;
  final String photo135;
  final String photo300;
  final String photo1200;
  // final List<ArtistEntity> mainArtists;

  PlaylistEntity({
    required this.id,
    required this.ownerId,
    required this.type,
    required this.title,
    required this.isFollowing,
    required this.year,
    required this.photo135,
    required this.photo300,
    required this.photo1200,
  });
}
