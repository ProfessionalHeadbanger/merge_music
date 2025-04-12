import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merge_music/core/common/global_state/theme/theme_cubit.dart';
import 'package:merge_music/core/extensions/extensions.dart';

class ThemeSwitcherSliver extends StatelessWidget {
  const ThemeSwitcherSliver({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          final isDark = state.themeMode == ThemeMode.dark;

          return Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: context.color.tertiaryText!,
                  width: 1,
                ),
                bottom: BorderSide(
                  color: context.color.tertiaryText!,
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    context.l10n.theme,
                    style: context.text.smallTitle,
                  ),
                ),
                Text(
                  isDark ? context.l10n.dark : context.l10n.light,
                  style: context.text.smallTitle,
                ),
                SizedBox(
                  width: 8,
                ),
                Switch(
                  value: isDark,
                  onChanged: (value) {
                    context.read<ThemeCubit>().toggleDarkMode(value);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
