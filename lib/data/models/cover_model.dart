import 'package:merge_music/domain/entities/cover_entity.dart';

class CoverModel extends CoverEntity {
  CoverModel({
    required super.coverSmall,
    required super.coverXL,
  });

  Map<String, dynamic> toJson() {
    return {
      'cover_small': coverSmall,
      'cover_xl': coverXL,
    };
  }

  factory CoverModel.fromJson(Map<String, dynamic> json) {
    return CoverModel(
      coverSmall: json['cover_small'],
      coverXL: json['cover_xl'],
    );
  }

  CoverModel copyWith({
    String? coverSmall,
    String? coverXL,
  }) {
    return CoverModel(
      coverSmall: coverSmall ?? this.coverSmall,
      coverXL: coverXL ?? this.coverXL,
    );
  }
}
