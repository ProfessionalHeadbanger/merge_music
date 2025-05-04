import 'package:flutter/material.dart';
import 'package:overflow_text_animated/overflow_text_animated.dart';

class AnimatedOverflowedText extends StatelessWidget {
  final String text;
  final TextStyle style;

  const AnimatedOverflowedText({
    super.key,
    required this.text,
    required this.style,
  });

  @override
  Widget build(BuildContext context) {
    return OverflowTextAnimated(
      text: text,
      style: style,
      curve: Curves.easeInOut,
      animation: OverFlowTextAnimations.scrollOpposite,
      animateDuration: const Duration(milliseconds: 3000),
      delay: const Duration(milliseconds: 1000),
    );
  }
}
