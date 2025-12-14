import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/widgets/glassmorphic_container.dart';

class CustomUserTextField extends StatelessWidget {
  CustomUserTextField({
    super.key,
    required this.controller,
    required this.labelText,
    this.textInputType,
  });
  final TextEditingController controller;
  final String labelText;
  final TextInputType? textInputType;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;

    return GlassmorphicContainer(
      borderRadius: BorderRadius.circular(16),
      padding: EdgeInsets.zero,
      child: TextField(
        controller: controller,
        cursorHeight: 20,
        keyboardType: textInputType,
        cursorColor: isDark ? Colors.white : colorScheme.primary,
        style: GoogleFonts.inter(
          color: isDark ? Colors.white : Colors.black87,
        ),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
          labelText: labelText,
          labelStyle: GoogleFonts.inter(
            color: isDark ? Colors.white70 : Colors.grey.shade600,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: colorScheme.primary.withOpacity(0.5),
              width: 2,
            ),
          ),
        ),
      ),
    );
  }
}
