import 'package:flutter/material.dart';
import 'package:merge_music/core/constants/size_constants.dart';
import 'package:merge_music/core/extensions/extensions.dart';

class CustomButtonWithIcon extends StatelessWidget {
  final Icon icon;
  final String text;
  final VoidCallback? onPressed;
  const CustomButtonWithIcon({
    super.key,
    this.onPressed,
    required this.text,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      onPressed: onPressed,
      icon: icon,
      label: Text(
        text,
        style: context.text.customButtonText,
      ),
      style: ButtonStyle(
        backgroundColor:
            WidgetStatePropertyAll(context.color.customButtonColor),
        iconColor: WidgetStatePropertyAll(context.color.invertedPrimaryText),
        iconSize: WidgetStatePropertyAll(SizeConstants.customButtonIconSize),
      ),
    );
  }
}
