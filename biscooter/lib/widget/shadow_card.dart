import 'dart:ui';
import 'package:flutter/material.dart';

class ShadowCard extends StatelessWidget {
  final double radius;
  final double filter;
  final Widget child;

  const ShadowCard({super.key, required this.radius, required this.filter, required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: filter,
            sigmaY: filter,
          ),
          child: child,
        ),
      ),
    );
  }
}
