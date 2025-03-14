import 'package:flutter/material.dart';
import 'package:merge_music/core/extensions/extensions.dart';
import 'package:merge_music/presentation/main_page/widgets/vk_mix_sliver.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.l10n.mainPage,
        ),
      ),
      body: CustomScrollView(
        slivers: [
          VkMixSliver(),
        ],
      ),
    );
  }
}
