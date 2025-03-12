import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:merge_music/core/constants/icons_constants.dart';
import 'package:merge_music/core/constants/size_constants.dart';
import 'package:merge_music/core/themes/constants/app_colors.dart';

class RootPage extends StatelessWidget {
  const RootPage({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        items: buildBottomNavBarItems,
        currentIndex: navigationShell.currentIndex,
        onTap: (index) => navigationShell.goBranch(index,
            initialLocation: index == navigationShell.currentIndex),
        selectedItemColor: LightAppColors.selectedNavBarItem,
        unselectedItemColor: LightAppColors.unselectedNavBarItem,
      ),
    );
  }

  List<BottomNavigationBarItem> get buildBottomNavBarItems => [
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            IconsConstants.homeOutline,
            width: SizeConstants.navBarIconSize,
            height: SizeConstants.navBarIconSize,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            IconsConstants.searchOutline,
            width: SizeConstants.navBarIconSize,
            height: SizeConstants.navBarIconSize,
          ),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            IconsConstants.musicOutline,
            width: SizeConstants.navBarIconSize,
            height: SizeConstants.navBarIconSize,
          ),
          label: 'Library',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            IconsConstants.settingsOutline,
            width: SizeConstants.navBarIconSize,
            height: SizeConstants.navBarIconSize,
          ),
          label: 'Settings',
        )
      ];
}
