import 'dart:ui';
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final double blur;

  const GlassCard({
    Key? key,
    required this.child,
    this.padding = const EdgeInsets.all(24.0),
    this.borderRadius = 20.0,
    this.blur = 16.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: AppColors.cardGlass,
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              color: AppColors.cardGlassBorder,
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.35),
                blurRadius: 30,
                offset: const Offset(0, 15),
              ),
              BoxShadow(
                color: AppColors.primary.withOpacity(0.08),
                blurRadius: 20,
                offset: const Offset(0, 0),
              ),
            ],
          ),
          child: child,
        ),
      ),
    );
  }
}
