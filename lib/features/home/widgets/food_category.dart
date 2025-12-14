import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../core/widgets/glassmorphic_container.dart';
import '../../../shared/custom_text.dart';

class FoodCategory extends StatefulWidget {
  FoodCategory({
    super.key,
    required this.currentIndex,
    required this.category,
  });
  late int currentIndex;
  final List category;

  @override
  State<FoodCategory> createState() => _FoodCategoryState();
}

class _FoodCategoryState extends State<FoodCategory>
    with SingleTickerProviderStateMixin {
  late int currentIndex;
  late AnimationController _controller;

  @override
  void initState() {
    currentIndex = widget.currentIndex;
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          widget.category.length,
          (index) {
            final isSelected = currentIndex == index;
            return GestureDetector(
              onTap: () {
                setState(() {
                  currentIndex = index;
                });
                _controller.forward(from: 0.0).then((_) {
                  _controller.reverse();
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                margin: const EdgeInsets.only(right: 12),
                child: GlassmorphicContainer(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 24,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  gradient: isSelected
                      ? LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            colorScheme.primary,
                            colorScheme.secondary,
                          ],
                        )
                      : null,
                  child: CustomText(
                    text: widget.category[index],
                    weight: FontWeight.w600,
                    size: 14,
                    color: isSelected
                        ? Colors.white
                        : (isDark ? Colors.white70 : Colors.grey.shade600),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
