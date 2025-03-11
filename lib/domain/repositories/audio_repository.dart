import 'package:merge_music/domain/entities/audio_entity.dart';

abstract interface class AudioRepository {
  Future<List<AudioEntity>> getUserAudios();
}
