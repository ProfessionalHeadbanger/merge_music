import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:merge_music/core/common/widgets/loading_widget.dart';
import 'package:merge_music/core/constants/icons_constants.dart';
import 'package:merge_music/core/extensions/extensions.dart';
import 'package:merge_music/presentation/search_page/bloc/search_page_bloc.dart';
import 'package:merge_music/presentation/search_page/widgets/empty_history_widget.dart';
import 'package:merge_music/presentation/search_page/widgets/loaded_history_widget.dart';
import 'package:merge_music/presentation/search_page/widgets/searched_tracks_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _controller = TextEditingController();
  bool _showClearButton = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _showClearButton = _controller.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(top: 12),
          child: Container(
            height: 44,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: context.color.secondaryBackground,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Row(
              children: [
                SvgPicture.asset(
                  IconsConstants.searchOutline,
                  colorFilter: ColorFilter.mode(
                      context.color.unselectedNavBarItem!, BlendMode.srcIn),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _controller,
                    style: context.text.subtitle,
                    onSubmitted: (query) {
                      final trimmed = query.trim();
                      if (trimmed.isNotEmpty) {
                        context
                            .read<SearchPageBloc>()
                            .add(AddQueryToHistory(query: trimmed));
                        context
                            .read<SearchPageBloc>()
                            .add(SearchTracksEvent(query: trimmed));
                      } else {
                        _controller.clear();
                      }
                    },
                    decoration: InputDecoration(
                      hintText: context.l10n.search,
                      hintStyle: context.text.subtitle,
                      border: InputBorder.none,
                      isCollapsed: true,
                    ),
                  ),
                ),
                if (_showClearButton)
                  GestureDetector(
                    onTap: () {
                      _controller.clear();
                      context
                          .read<SearchPageBloc>()
                          .add(ClearSearchTextField());
                    },
                    child: SvgPicture.asset(
                      IconsConstants.cancelCircleOutline,
                      colorFilter: ColorFilter.mode(
                          context.color.unselectedNavBarItem!, BlendMode.srcIn),
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
      body: BlocBuilder<SearchPageBloc, SearchPageState>(
        builder: (context, state) {
          if (state is SearchPageEmptyHistory) {
            return EmptyHistoryWidget();
          }
          if (state is SearchPageHistoryLoaded) {
            return LoadedHistoryWidget(history: state.history);
          }
          if (state is SearchPageLoading) {
            return const Center(child: LoadingWidget());
          }
          if (state is SearchPageTracksLoaded) {
            return SearchedTracksWidget(tracks: state.tracks);
          }
          return EmptyHistoryWidget();
        },
      ),
    );
  }
}
