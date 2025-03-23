import 'package:flutter/material.dart';
import 'package:merge_music/core/extensions/extensions.dart';

class VkLoginButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const VkLoginButton({super.key, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ButtonStyle(
        backgroundColor:
            WidgetStatePropertyAll(context.color.customButtonColor),
        minimumSize: WidgetStatePropertyAll(Size(250, 45)),
      ),
      child: Text(
        label,
        style: context.text.customButtonText,
      ),
    );
  }
}
