import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:merge_music/core/extensions/extensions.dart';
import 'package:merge_music/service_locator.dart';

class QueueSheet extends StatelessWidget {
  const QueueSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final audioHandler = serviceLocator.get<AudioHandler>();

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.5,
      minChildSize: 0.3,
      maxChildSize: 0.9,
      builder: (context, scrollController) {
        return StreamBuilder<List<MediaItem>>(
          stream: audioHandler.queue,
          builder: (context, snapshot) {
            final queue = snapshot.data ?? [];
            return ListView.separated(
              controller: scrollController,
              itemCount: queue.length,
              separatorBuilder: (_, __) => Divider(
                color: context.color.auxiliaryText,
                height: 1,
              ),
              itemBuilder: (context, index) {
                final item = queue[index];
                return ListTile(
                  title: Text(
                    item.title,
                    style: context.text.trackName,
                  ),
                  subtitle: Text(
                    item.artist ?? '',
                    style: context.text.artistName,
                  ),
                  onTap: () => audioHandler.skipToQueueItem(index),
                );
              },
            );
          },
        );
      },
    );
  }
}
