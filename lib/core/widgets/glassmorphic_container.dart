import 'dart:ui';
import 'package:flutter/material.dart';

class GlassmorphicContainer extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BorderRadius? borderRadius;
  final double blur;
  final double opacity;
  final Color? borderColor;
  final double borderWidth;
  final List<BoxShadow>? customShadows;
  final Gradient? gradient;

  const GlassmorphicContainer({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.borderRadius,
    this.blur = 15.0,
    this.opacity = 0.2,
    this.borderColor,
    this.borderWidth = 1.5,
    this.customShadows,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: width,
      height: height,
      margin: margin,
      child: ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
              gradient:
                  gradient ??
                  LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors:
                        isDark
                            ? [
                              colorScheme.surface.withOpacity(0.3),
                              colorScheme.surface.withOpacity(0.1),
                            ]
                            : [
                              Colors.white.withOpacity(0.9),
                              Colors.white.withOpacity(0.85),
                            ],
                  ),
              borderRadius: borderRadius ?? BorderRadius.circular(20),
              border: Border.all(
                color:
                    borderColor ??
                    (isDark
                        ? Colors.white.withOpacity(0.1)
                        : Colors.white.withOpacity(0.3)),
                width: borderWidth,
              ),
              boxShadow:
                  customShadows ??
                  [
                    BoxShadow(
                      color:
                          isDark
                              ? Colors.black.withOpacity(0.5)
                              : Colors.black.withOpacity(0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                      spreadRadius: 0,
                    ),
                    BoxShadow(
                      color:
                          isDark
                              ? Colors.black.withOpacity(0.3)
                              : Colors.white.withOpacity(0.8),
                      blurRadius: 6,
                      offset: const Offset(0, -2),
                      spreadRadius: 0,
                    ),
                  ],
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
