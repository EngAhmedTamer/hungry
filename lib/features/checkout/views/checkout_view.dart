import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hungry/core/widgets/glassmorphic_container.dart';
import 'package:hungry/features/checkout/widgets/order_details_widget.dart';
import 'package:hungry/features/checkout/widgets/success_dialog.dart';
import 'package:hungry/shared/custom_text.dart';
import '../../../shared/custom_button.dart';

class CheckoutView extends StatefulWidget {
  const CheckoutView({super.key});

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  String selectedMethod = 'Cash';
  bool saveCardDetails = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        backgroundColor: isDark ? colorScheme.surface : Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: GlassmorphicContainer(
            borderRadius: BorderRadius.circular(12),
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.all(8),
            child: Icon(
              Icons.arrow_back,
              color: isDark ? Colors.white : Colors.black87,
              size: 20,
            ),
          ),
        ),
        iconTheme: IconThemeData(
          color: isDark ? Colors.white : Colors.black87,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Gap(10),
                          Text(
                            'Order Summary',
                            style: GoogleFonts.inter(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: colorScheme.primary,
                              letterSpacing: -0.5,
                            ),
                          ),
                          const Gap(20),
                          OrderDetailsWidget(
                            order: '18.5',
                            taxes: '3.5',
                            fees: '40.33',
                            total: '100',
                          ),
                          const Gap(30),
                          Text(
                            'Payment methods',
                            style: GoogleFonts.inter(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: isDark ? Colors.white : Colors.black87,
                            ),
                          ),
                          const Gap(16),
                          // Payment method Cash
                          GestureDetector(
                            onTap: () => setState(() => selectedMethod = 'Cash'),
                            child: GlassmorphicContainer(
                              padding: const EdgeInsets.symmetric(
                                vertical: 16,
                                horizontal: 20,
                              ),
                              borderRadius: BorderRadius.circular(16),
                              gradient: selectedMethod == 'Cash'
                                  ? LinearGradient(
                                colors: [
                                  const Color(0xff3C2F2F),
                                  const Color(0xff3C2F2F).withOpacity(0.8),
                                ],
                              )
                                  : null,
                              child: ListTile(
                                contentPadding: EdgeInsets.zero,
                                leading: Image.asset(
                                  'assets/icons/dollar.png',
                                  width: 50,
                                ),
                                title: CustomText(
                                  text: 'Cash on Delivery',
                                  color: selectedMethod == 'Cash'
                                      ? Colors.white
                                      : (isDark ? Colors.white : Colors.black87),
                                  weight: FontWeight.w600,
                                ),
                                trailing: Radio<String>(
                                  activeColor: Colors.white,
                                  value: 'Cash',
                                  groupValue: selectedMethod,
                                  onChanged: (v) => setState(() => selectedMethod = v!),
                                ),
                              ),
                            ),
                          ),
                          const Gap(16),
                          // Payment method Visa
                          GestureDetector(
                            onTap: () => setState(() => selectedMethod = 'Visa'),
                            child: GlassmorphicContainer(
                              padding: const EdgeInsets.symmetric(
                                vertical: 16,
                                horizontal: 20,
                              ),
                              borderRadius: BorderRadius.circular(16),
                              gradient: selectedMethod == 'Visa'
                                  ? LinearGradient(
                                colors: [
                                  Colors.blue.shade900,
                                  Colors.blue.shade800,
                                ],
                              )
                                  : null,
                              child: ListTile(
                                contentPadding: EdgeInsets.zero,
                                leading: Image.asset(
                                  'assets/icons/visablack.png',
                                  width: 50,
                                ),
                                title: CustomText(
                                  text: 'Debit Card',
                                  color: selectedMethod == 'Visa'
                                      ? Colors.white
                                      : (isDark ? Colors.white : Colors.black87),
                                  weight: FontWeight.w600,
                                ),
                                subtitle: selectedMethod == 'Visa'
                                    ? CustomText(
                                  text: ' **** ***** 1974',
                                  color: Colors.white70,
                                  size: 14,
                                )
                                    : null,
                                trailing: Radio<String>(
                                  activeColor: Colors.white,
                                  value: 'Visa',
                                  groupValue: selectedMethod,
                                  onChanged: (v) => setState(() => selectedMethod = v!),
                                ),
                              ),
                            ),
                          ),
                          const Gap(16),
                          if (selectedMethod == 'Visa')
                            GlassmorphicContainer(
                              padding: const EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 16,
                              ),
                              borderRadius: BorderRadius.circular(16),
                              child: Row(
                                children: [
                                  Checkbox(
                                    activeColor: colorScheme.primary,
                                    value: saveCardDetails,
                                    onChanged: (v) => setState(() => saveCardDetails = v ?? false),
                                  ),
                                  Expanded(
                                    child: CustomText(
                                      text: 'Save card details for future payments',
                                      size: 14,
                                      color: isDark ? Colors.white70 : Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          const SizedBox(height: 20), // space before bottom sheet
                        ],
                      ),
                    ),
                  ),
                  // Bottom Sheet
                  SafeArea(
                    child: GlassmorphicContainer(
                      height: 100,
                      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                      borderRadius: BorderRadius.circular(24),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: 'Total Price',
                                size: 14,
                                color: isDark ? Colors.white70 : Colors.black54,
                              ),
                              const Gap(4),
                              CustomText(
                                text: '\$ 18.9',
                                size: 22,
                                weight: FontWeight.bold,
                                color: colorScheme.primary,
                              ),
                            ],
                          ),
                          CustomButton(
                            text: 'Pay Now',
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (c) {
                                  return SuccessDialog();
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );

  }
}
