import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merge_music/core/common/widgets/retry_button.dart';
import 'package:merge_music/core/extensions/extensions.dart';
import 'package:merge_music/presentation/main_page/bloc/main_page_bloc.dart';
import 'package:merge_music/presentation/main_page/widgets/audio_list_sliver.dart';
import 'package:merge_music/presentation/main_page/widgets/vk_mix_sliver.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.l10n.mainPage,
        ),
      ),
      body: BlocBuilder<MainPageBloc, MainPageState>(
        builder: (context, state) {
          if (state is MainPageLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is MainPageError) {
            return Center(
              child: RetryButton(
                onPressed: () {
                  context.read<MainPageBloc>().add(LoadMainPageAudios());
                },
              ),
            );
          }
          if (state is MainPageLoaded) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: CustomScrollView(
                slivers: [
                  VkMixSliver(),
                  AudioListSliver(audios: state.audios),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
