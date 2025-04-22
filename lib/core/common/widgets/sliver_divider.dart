import 'package:flutter/material.dart';

class SliverDivider extends StatelessWidget {
  final Color color;

  const SliverDivider({
    super.key,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Divider(
        color: color,
        height: 1,
      ),
    );
  }
}
