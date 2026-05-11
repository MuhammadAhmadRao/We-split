import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class NeoBrutalCard extends StatelessWidget {
  final Widget child;
  final Color color;
  final double radius;
  final EdgeInsets padding;

  const NeoBrutalCard({
    super.key,
    required this.child,
    this.color = Colors.white,
    this.radius = 0,
    this.padding = const EdgeInsets.all(16),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: AppTheme.neoBrutalDecoration(color: color, radius: radius),
      child: child,
    );
  }
}
