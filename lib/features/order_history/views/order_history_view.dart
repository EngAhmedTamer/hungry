import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hungry/core/widgets/glassmorphic_container.dart';
import '../../../shared/custom_button.dart';
import '../../../shared/custom_text.dart';

class OrderHistoryView extends StatelessWidget {
  const OrderHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: isDark ? colorScheme.background : colorScheme.background,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              const Gap(50),
              Center(
                child: Text(
                  "Your History Order",
                  style: GoogleFonts.inter(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.primary,
                    letterSpacing: -0.5,
                  ),
                ),
              ),
              const Gap(20),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.only(bottom: 200),
                  itemCount: 9,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: GlassmorphicContainer(
                        padding: const EdgeInsets.all(20),
                        borderRadius: BorderRadius.circular(20),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.asset(
                                        'assets/test/test.png',
                                        width: 90,
                                        height: 90,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const Gap(8),
                                    CustomText(
                                      size: 20,
                                      text: 'Cheeseburger',
                                      weight: FontWeight.w600,
                                    ),
                                    const Gap(4),
                                    CustomText(
                                      text: 'Wendy"s burger',
                                      size: 15,
                                      color: isDark
                                          ? Colors.white70
                                          : Colors.black54,
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    CustomText(
                                      text: 'Hamburger',
                                      weight: FontWeight.bold,
                                      size: 18,
                                    ),
                                    const Gap(4),
                                    CustomText(
                                      text: 'Qty : 3',
                                      size: 14,
                                      color: isDark
                                          ? Colors.white70
                                          : Colors.black54,
                                    ),
                                    const Gap(4),
                                    CustomText(
                                      text: 'Price : \$ 18.9',
                                      weight: FontWeight.bold,
                                      size: 18,
                                      color: colorScheme.primary,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const Gap(20),
                            CustomButton(
                              text: 'Order Again',
                              width: double.infinity,
                              color: isDark
                                  ? colorScheme.surface
                                  : Colors.grey.shade200,
                              onTap: () {
                                // Order again logic
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
