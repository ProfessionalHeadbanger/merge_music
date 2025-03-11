import 'package:logger/logger.dart';
import 'package:merge_music/data/data_sources/remote/audio_remote_data_source.dart';
import 'package:merge_music/domain/entities/audio_entity.dart';
import 'package:merge_music/domain/repositories/audio_repository.dart';
import 'package:merge_music/service_locator.dart';

class AudioRepositoryImpl implements AudioRepository {
  final AudioRemoteDataSource audioRemoteDataSource;

  AudioRepositoryImpl(this.audioRemoteDataSource);

  @override
  Future<List<AudioEntity>> getUserAudios() async {
    try {
      final audios = audioRemoteDataSource.getUserAudios();
      return audios;
    } catch (e) {
      serviceLocator.get<Logger>().e('Error occured: $e');
      return [];
    }
  }
}
