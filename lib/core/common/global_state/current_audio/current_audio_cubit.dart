import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:merge_music/domain/entities/audio_entity.dart';
import 'package:merge_music/service_locator.dart';

class CurrentAudioCubit extends Cubit<AudioEntity?> {
  CurrentAudioCubit() : super(null);

  void set(AudioEntity audio) {
    emit(audio);
    serviceLocator.get<Logger>().i('Current audio set: ${audio.id}');
  }

  void clear() => emit(null);
}
