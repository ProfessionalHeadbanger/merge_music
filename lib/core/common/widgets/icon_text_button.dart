import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:merge_music/core/constants/size_constants.dart';
import 'package:merge_music/core/extensions/extensions.dart';

class IconTextButton extends StatelessWidget {
  final String iconPath;
  final String label;
  final VoidCallback? onPressed;

  const IconTextButton({
    super.key,
    required this.iconPath,
    required this.label,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            iconPath,
            width: SizeConstants.navBarIconSize,
            height: SizeConstants.navBarIconSize,
            colorFilter:
                ColorFilter.mode(context.color.primaryText!, BlendMode.srcIn),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            label,
            style: context.text.textButton,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
