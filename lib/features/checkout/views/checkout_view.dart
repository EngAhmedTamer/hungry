import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry/features/checkout/widgets/order_details_widget.dart';
import 'package:hungry/shared/custom_text.dart';

class CheckoutView extends StatelessWidget {
  const CheckoutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: 'Order Summary',
              size: 20,
              weight: FontWeight.w900,
            ),
            Gap(10),
            OrderDetailsWidget(
              order: '18.5',
              taxes: '3.5',
              fees: '40.33',
              total: '100',
            ),
            Gap(80),
            CustomText(
              text: 'Payment methods',
              size: 20,
              weight: FontWeight.w500,
            ),
            Gap(20),
          ],
        ),
      ),
    );
  }
}
