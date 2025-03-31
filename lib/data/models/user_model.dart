import 'package:merge_music/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.id,
    required super.firstName,
    required super.lastName,
    required super.photo50,
    required super.photo100,
    required super.photoMax,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'photo_50': photo50,
      'photo_100': photo100,
      'photo_max': photoMax,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      photo50: json['photo_50'],
      photo100: json['photo_100'],
      photoMax: json['photo_max'],
    );
  }

  UserModel copyWith({
    int? id,
    String? firstName,
    String? lastName,
    String? photo50,
    String? photo100,
    String? photoMax,
  }) {
    return UserModel(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      photo50: photo50 ?? this.photo50,
      photo100: photo100 ?? this.photo100,
      photoMax: photoMax ?? this.photoMax,
    );
  }
}
