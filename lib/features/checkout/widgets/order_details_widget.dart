import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../core/widgets/glassmorphic_container.dart';
import '../../../shared/custom_text.dart';

class OrderDetailsWidget extends StatelessWidget {
  const OrderDetailsWidget({
    super.key,
    required this.order,
    required this.taxes,
    required this.fees,
    required this.total,
  });
  final String order, taxes, fees, total;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;

    return GlassmorphicContainer(
      padding: const EdgeInsets.all(20),
      borderRadius: BorderRadius.circular(20),
      child: Column(
        children: [
          checkoutWidget('Order', order, false, false, isDark, colorScheme),
          const Gap(12),
          checkoutWidget('Taxes', taxes, false, false, isDark, colorScheme),
          const Gap(12),
          checkoutWidget('Delivery fees', fees, false, false, isDark, colorScheme),
          const Gap(12),
          Divider(
            color: isDark
                ? Colors.white.withOpacity(0.1)
                : Colors.black.withOpacity(0.1),
            thickness: 1,
          ),
          const Gap(12),
          checkoutWidget('Total', total, true, false, isDark, colorScheme),
          const Gap(12),
          checkoutWidget('Estimated delivery time', '15 - 30 mins', true, true, isDark, colorScheme),
        ],
      ),
    );
  }
}

Widget checkoutWidget(
  String title,
  String price,
  bool isBold,
  bool isSmall,
  bool isDark,
  colorScheme,
) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      CustomText(
        text: title,
        size: isSmall ? 12 : 18,
        weight: isBold ? FontWeight.bold : FontWeight.w500,
        color: isBold
            ? (isDark ? Colors.white : Colors.black87)
            : (isDark ? Colors.white70 : Colors.grey.shade600),
      ),
      CustomText(
        text: '$price \$',
        size: isSmall ? 12 : 18,
        weight: isBold ? FontWeight.bold : FontWeight.w400,
        color: isBold
            ? (isDark ? Colors.white : Colors.black87)
            : (isDark ? Colors.white70 : Colors.grey.shade600),
      ),
    ],
  );
}
