import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:merge_music/core/constants/icons_constants.dart';
import 'package:merge_music/core/constants/size_constants.dart';
import 'package:merge_music/core/extensions/extensions.dart';

class RootPage extends StatelessWidget {
  const RootPage({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        destinations: [
          NavigationDestination(
            icon: SvgPicture.asset(
              IconsConstants.homeOutline,
              width: SizeConstants.navBarIconSize,
              height: SizeConstants.navBarIconSize,
              colorFilter: ColorFilter.mode(
                  context.color.unselectedNavBarItem!, BlendMode.srcIn),
            ),
            selectedIcon: SvgPicture.asset(
              IconsConstants.homeOutline,
              width: SizeConstants.navBarIconSize,
              height: SizeConstants.navBarIconSize,
              colorFilter: ColorFilter.mode(
                  context.color.selectedNavBarItem!, BlendMode.srcIn),
            ),
            label: 'Home',
          ),
          NavigationDestination(
            icon: SvgPicture.asset(
              IconsConstants.searchOutline,
              width: SizeConstants.navBarIconSize,
              height: SizeConstants.navBarIconSize,
              colorFilter: ColorFilter.mode(
                  context.color.unselectedNavBarItem!, BlendMode.srcIn),
            ),
            selectedIcon: SvgPicture.asset(
              IconsConstants.searchOutline,
              width: SizeConstants.navBarIconSize,
              height: SizeConstants.navBarIconSize,
              colorFilter: ColorFilter.mode(
                  context.color.selectedNavBarItem!, BlendMode.srcIn),
            ),
            label: 'Search',
          ),
          NavigationDestination(
            icon: SvgPicture.asset(
              IconsConstants.musicOutline,
              width: SizeConstants.navBarIconSize,
              height: SizeConstants.navBarIconSize,
              colorFilter: ColorFilter.mode(
                  context.color.unselectedNavBarItem!, BlendMode.srcIn),
            ),
            selectedIcon: SvgPicture.asset(
              IconsConstants.musicOutline,
              width: SizeConstants.navBarIconSize,
              height: SizeConstants.navBarIconSize,
              colorFilter: ColorFilter.mode(
                  context.color.selectedNavBarItem!, BlendMode.srcIn),
            ),
            label: 'Library',
          ),
          NavigationDestination(
            icon: SvgPicture.asset(
              IconsConstants.settingsOutline,
              width: SizeConstants.navBarIconSize,
              height: SizeConstants.navBarIconSize,
              colorFilter: ColorFilter.mode(
                  context.color.unselectedNavBarItem!, BlendMode.srcIn),
            ),
            selectedIcon: SvgPicture.asset(
              IconsConstants.settingsOutline,
              width: SizeConstants.navBarIconSize,
              height: SizeConstants.navBarIconSize,
              colorFilter: ColorFilter.mode(
                  context.color.selectedNavBarItem!, BlendMode.srcIn),
            ),
            label: 'Settings',
          )
        ],
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: navigationShell.goBranch,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        indicatorShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        indicatorColor: context.color.selectedNavBarItemBoxColor!,
        backgroundColor: context.color.primaryBackground,
      ),
    );
  }
}
