import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merge_music/core/common/global_state/user_albums/user_albums_cubit.dart';
import 'package:merge_music/core/common/widgets/playlist_tile.dart';
import 'package:merge_music/core/extensions/extensions.dart';

class UserAlbumsSliver extends StatelessWidget {
  const UserAlbumsSliver({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserAlbumsCubit, UserAlbumsState>(
      builder: (context, state) {
        if (state is! UserAlbumsLoaded) {
          return const SliverToBoxAdapter();
        }

        final albums = state.albums.take(10).toList();

        if (albums.isEmpty) {
          return const SliverToBoxAdapter();
        }

        return SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      context.l10n.myAlbums,
                      style: context.text.mediumTitle,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      context.l10n.showAll,
                      style: context.text.textButton,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 180,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: albums.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: PlaylistTile(
                        playlistEntity: albums[index],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }
}
