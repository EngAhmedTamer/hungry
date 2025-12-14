import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/widgets/glassmorphic_container.dart';

class SearchField extends StatelessWidget {
  const SearchField({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;

    return GlassmorphicContainer(
      borderRadius: BorderRadius.circular(18),
      padding: EdgeInsets.zero,
      child: TextField(

        style: GoogleFonts.inter(
          color: isDark ? Colors.white : Colors.black87,
        ),
        decoration: InputDecoration(
          prefixIcon: Icon(
            CupertinoIcons.search,
            color: colorScheme.primary,
            size: 22,
          ),
          hintText: 'Search for food...',
          hintStyle: GoogleFonts.inter(
            color: isDark ? Colors.white54 : Colors.grey.shade500,
          ),
          filled: false,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,

          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
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
