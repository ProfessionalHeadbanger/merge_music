import 'package:merge_music/domain/entities/audio_entity.dart';

class ShowAllTracksPageArgs {
  final String title;
  final List<AudioEntity> audios;

  ShowAllTracksPageArgs({
    required this.title,
    required this.audios,
  });
}
