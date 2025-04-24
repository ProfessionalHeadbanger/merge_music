import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:merge_music/core/constants/size_constants.dart';
import 'package:merge_music/core/extensions/extensions.dart';

class CustomButtonWithIcon extends StatelessWidget {
  final String iconPath;
  final String text;
  final VoidCallback? onPressed;
  const CustomButtonWithIcon({
    super.key,
    this.onPressed,
    required this.text,
    required this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      onPressed: onPressed,
      icon: SvgPicture.asset(
        iconPath,
        colorFilter: ColorFilter.mode(
            context.color.invertedPrimaryText!, BlendMode.srcIn),
        width: SizeConstants.customButtonIconSize,
        height: SizeConstants.customButtonIconSize,
      ),
      label: Text(
        text,
        style: context.text.customButtonText,
      ),
      style: ButtonStyle(
        backgroundColor:
            WidgetStatePropertyAll(context.color.customButtonColor),
      ),
    );
  }
}
