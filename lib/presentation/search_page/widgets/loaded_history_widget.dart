import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:merge_music/core/constants/icons_constants.dart';
import 'package:merge_music/core/extensions/extensions.dart';
import 'package:merge_music/presentation/search_page/bloc/search_page_bloc.dart';
import 'package:provider/provider.dart';

class LoadedHistoryWidget extends StatelessWidget {
  final List<String> history;

  const LoadedHistoryWidget({super.key, required this.history});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  context.l10n.queryHistory,
                  style: context.text.smallTitle,
                ),
              ),
              IconButton(
                onPressed: () {
                  context.read<SearchPageBloc>().add(ClearSearchHistory());
                },
                icon: SvgPicture.asset(
                  IconsConstants.listDeleteOutline,
                  colorFilter: ColorFilter.mode(
                      context.color.tertiaryText!, BlendMode.srcIn),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: history.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: SvgPicture.asset(
                  IconsConstants.historyBackwardOutline,
                  colorFilter: ColorFilter.mode(
                      context.color.tertiaryText!, BlendMode.srcIn),
                ),
                title: Text(
                  history[index],
                  style: context.text.subtitle,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
