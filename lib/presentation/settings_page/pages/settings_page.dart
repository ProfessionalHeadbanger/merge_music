import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:merge_music/core/common/global_state/user/user_cubit.dart';
import 'package:merge_music/core/common/navigation/router.dart';
import 'package:merge_music/core/constants/icons_constants.dart';
import 'package:merge_music/core/constants/size_constants.dart';
import 'package:merge_music/core/extensions/extensions.dart';
import 'package:merge_music/presentation/settings_page/bloc/settings_page_bloc.dart';
import 'package:merge_music/presentation/settings_page/widgets/logout_dialog_builder.dart';
import 'package:merge_music/presentation/settings_page/widgets/theme_switcher_sliver.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        if (state is UserLoggedIn) {
          return Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Scaffold(
              appBar: AppBar(
                leading: CircleAvatar(
                  radius: 24,
                  backgroundImage: NetworkImage(state.user.photo100),
                  backgroundColor: Colors.transparent,
                ),
                title: Text(
                  '${state.user.firstName} ${state.user.lastName}',
                  style: context.text.mediumTitle,
                ),
                actions: [
                  IconButton(
                    onPressed: () => logoutDialogBuilder(
                      context,
                      () {
                        router.pop();
                      },
                      () {
                        context.read<SettingsPageBloc>().add(LogoutEvent());
                      },
                    ),
                    icon: SvgPicture.asset(
                      IconsConstants.doorArrowRightOutline,
                      width: SizeConstants.navBarIconSize,
                      height: SizeConstants.navBarIconSize,
                      colorFilter: ColorFilter.mode(
                          context.color.primaryText!, BlendMode.srcIn),
                    ),
                  ),
                ],
              ),
              body: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Text(
                        context.l10n.settings,
                        style: context.text.mediumTitle,
                      ),
                    ),
                  ),
                  ThemeSwitcherSliver(),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Text(
                        context.l10n.more_settings,
                        style: context.text.mediumTitle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return Scaffold();
      },
    );
  }
}
