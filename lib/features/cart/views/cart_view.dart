import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hungry/core/widgets/glassmorphic_container.dart';
import 'package:hungry/features/cart/widgets/cart_item.dart';
import '../../../shared/custom_button.dart';
import '../../../shared/custom_text.dart';
import '../../checkout/views/checkout_view.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  int itemCount = 3;
  late List<int> quantities;

  @override
  void initState() {
    quantities = List.generate(itemCount, (index) => 1);
    super.initState();
  }

  void add(index) {
    setState(() {
      quantities[index]++;
    });
  }

  void mince(index) {
    setState(() {
      if (quantities[index] > 1) quantities[index]--;
    });
  }

  void remove(index) {
    setState(() {
      quantities[index] = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: isDark ? colorScheme.background : colorScheme.background,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                const Gap(50),
                Center(
                  child: Text(
                    "Your Cart",
                    style: GoogleFonts.inter(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.primary,
                      letterSpacing: -0.5,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.only(bottom: 200),
                    itemCount: itemCount,
                    itemBuilder: (context, index) {
                      if (quantities[index] == 0) {
                        return const SizedBox.shrink();
                      }
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: CardItem(
                          image: 'assets/test/test.png',
                          mainText: 'Cheeseburger',
                          descText: 'Wendy"s burger',
                          quantity: '${quantities[index]}',
                          onAdd: () {
                            add(index);
                          },
                          onMince: () {
                            mince(index);
                          },
                          onRemove: () {
                            remove(index);
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 20,
            right: 20,
            bottom:20,
            child: GlassmorphicContainer(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
              borderRadius: BorderRadius.circular(50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                        text: 'Total Price',
                        size: 14,
                        color: isDark ? Colors.white70 : Colors.black54,
                      ),
                      const Gap(4),
                      CustomText(
                        text: '\$ 18.9',
                        size: 28,
                        weight: FontWeight.bold,
                        color: colorScheme.primary,
                      ),
                    ],
                  ),
                  CustomButton(
                    text: 'Checkout',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (c) {
                            return CheckoutView();
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
