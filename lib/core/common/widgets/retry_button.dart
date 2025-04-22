import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:merge_music/core/constants/icons_constants.dart';
import 'package:merge_music/core/constants/size_constants.dart';
import 'package:merge_music/core/extensions/extensions.dart';

class RetryButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const RetryButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: SvgPicture.asset(
        IconsConstants.refreshOutline,
        width: SizeConstants.retryButtonSize,
        height: SizeConstants.retryButtonSize,
        colorFilter:
            ColorFilter.mode(context.color.primaryText!, BlendMode.srcIn),
      ),
    );
  }
}
