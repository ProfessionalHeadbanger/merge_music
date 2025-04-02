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
    );
  }
}
