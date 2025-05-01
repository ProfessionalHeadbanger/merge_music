import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:merge_music/core/extensions/extensions.dart';

class LibraryButton extends StatelessWidget {
  final String title;
  final String iconPath;
  final VoidCallback? onTap;

  const LibraryButton({
    super.key,
    required this.title,
    required this.iconPath,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: context.color.selectedNavBarItemBoxColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    iconPath,
                    colorFilter: ColorFilter.mode(
                      context.color.selectedNavBarItem!,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Text(
                title,
                style: context.text.subtitle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
