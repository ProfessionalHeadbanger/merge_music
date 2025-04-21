import 'package:flutter/material.dart';
import 'package:merge_music/core/common/widgets/vertical_scrollable_audio_list.dart';
import 'package:merge_music/domain/entities/audio_entity.dart';

class ShowAllTracksPage extends StatelessWidget {
  final String title;
  final List<AudioEntity> audios;

  const ShowAllTracksPage({
    super.key,
    required this.title,
    required this.audios,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: CustomScrollView(
          slivers: [
            VerticalScrollableAudioList(
              audios: audios,
            ),
          ],
        ),
      ),
    );
  }
}
