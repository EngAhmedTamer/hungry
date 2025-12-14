import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    super.key,
    required this.text,
    this.color,
    this.size,
    this.weight,
  });

  final String text;
  final Color? color;
  final double? size;
  final FontWeight? weight;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;

    return Text(
      text,
      style: GoogleFonts.inter(
        fontSize: size,
        color: color ?? (isDark ? Colors.white : Colors.black87),
        fontWeight: weight ?? FontWeight.w400,
      ),
    );
  }
}
