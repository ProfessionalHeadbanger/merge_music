import 'package:merge_music/domain/entities/artist_entity.dart';

class ArtistModel extends ArtistEntity {
  ArtistModel({
    required super.name,
    required super.id,
    required super.photo,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'photo': photo,
    };
  }

  factory ArtistModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> photos = json['photo'];
    return ArtistModel(
      id: json['id'].toString(),
      name: json['name'],
      photo: photos.last['url'],
    );
  }

  ArtistModel copyWith({
    String? id,
    String? name,
    String? photo,
  }) {
    return ArtistModel(
      id: id ?? this.id,
      name: name ?? this.name,
      photo: photo ?? this.photo,
    );
  }
}
