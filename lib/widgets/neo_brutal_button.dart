import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class NeoBrutalButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final Color color;

  const NeoBrutalButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.color = AppTheme.actionColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        decoration: AppTheme.neoBrutalDecoration(color: color),
        child: Center(
          child: DefaultTextStyle.merge(
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 18,
              color: Colors.black,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
