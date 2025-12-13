import 'package:flutter/material.dart';

class ResponsiveConstraint extends StatelessWidget {
  final Widget child;
  final double maxWidth;

  const ResponsiveConstraint({
    super.key,
    required this.child,
    this.maxWidth = 600, // Standard tablet/mobile-friendly max width
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: child,
      ),
    );
  }
}