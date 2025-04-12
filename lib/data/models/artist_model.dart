import 'package:merge_music/domain/entities/artist_entity.dart';

class ArtistModel extends ArtistEntity {
  ArtistModel({
    required super.id,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
    };
  }

  factory ArtistModel.fromJson(Map<String, dynamic> json) {
    return ArtistModel(
      id: json['id'],
    );
  }

  ArtistModel copyWith({
    int? id,
  }) {
    return ArtistModel(
      id: id ?? this.id,
    );
  }
}
