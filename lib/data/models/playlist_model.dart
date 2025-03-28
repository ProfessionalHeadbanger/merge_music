import 'package:merge_music/domain/entities/playlist_entity.dart';

class PlaylistModel extends PlaylistEntity {
  PlaylistModel({
    required super.id,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
    };
  }

  factory PlaylistModel.fromJson(Map<String, dynamic> json) {
    return PlaylistModel(
      id: json['id'],
    );
  }

  PlaylistModel copyWith({
    int? id,
  }) {
    return PlaylistModel(
      id: id ?? this.id,
    );
  }
}
