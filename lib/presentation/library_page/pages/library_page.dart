import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merge_music/core/common/global_state/user_tracks/user_tracks_cubit.dart';
import 'package:merge_music/core/common/widgets/sliver_divider.dart';
import 'package:merge_music/core/common/widgets/vertical_scrollable_audio_list.dart';
import 'package:merge_music/core/constants/icons_constants.dart';
import 'package:merge_music/core/extensions/extensions.dart';
import 'package:merge_music/presentation/library_page/widgets/library_button.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.l10n.libraryPage,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: CustomScrollView(
          slivers: [
            LibraryButton(
              title: context.l10n.recent,
              iconPath: IconsConstants.historyBackwardOutline,
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 8,
              ),
            ),
            LibraryButton(
              title: context.l10n.playlists,
              iconPath: IconsConstants.playlistOutline,
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 8,
              ),
            ),
            LibraryButton(
              title: context.l10n.albums,
              iconPath: IconsConstants.vinylOutline,
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 12,
              ),
            ),
            SliverDivider(color: context.color.tertiaryText!),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 12,
              ),
            ),
            BlocBuilder<UserTracksCubit, UserTracksState>(
              builder: (context, state) {
                if (state is UserTracksLoaded) {
                  return VerticalScrollableAudioList(audios: state.audios);
                }
                return const SliverToBoxAdapter();
              },
            )
          ],
        ),
      ),
    );
  }
}
