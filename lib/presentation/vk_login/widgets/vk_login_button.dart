import 'package:flutter/material.dart';
import 'package:merge_music/core/extensions/extensions.dart';

class VkLoginButton extends StatelessWidget {
  final VoidCallback onTap;
  final Widget content;

  const VkLoginButton({
    super.key,
    required this.onTap,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ButtonStyle(
        backgroundColor:
            WidgetStatePropertyAll(context.color.customButtonColor),
        minimumSize: WidgetStatePropertyAll(Size(250, 45)),
      ),
      child: content,
    );
  }
}
