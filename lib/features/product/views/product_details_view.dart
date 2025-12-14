import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constants/app_colors.dart';
import 'package:hungry/features/product/widgets/spicy_slider.dart';
import 'package:hungry/features/product/widgets/topping_card.dart';
import 'package:hungry/shared/custom_button.dart';

import '../../../shared/custom_text.dart';

class ProductDetailsView extends StatefulWidget {
  const ProductDetailsView({super.key});

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  double value = 0.8;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SpicySlider(
              onChanged: (v) {
                setState(() => value = v);
                print(value);
              },
              value: value,
            ),
            Gap(20),
            CustomText(text: '   Toppings', size: 20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ToppingCard(
                    imagePath: 'assets/sanDetails/tomato.png',
                    name: 'Tomato',
                    onAdd: () {},
                  ),
                  Gap(10),
                  ToppingCard(
                    imagePath: 'assets/sanDetails/pickles.png',
                    name: 'Pickles',
                    onAdd: () {},
                  ),
                  Gap(10),
                  ToppingCard(
                    imagePath: 'assets/sanDetails/onion.png',
                    name: 'Onion',
                    onAdd: () {},
                  ),
                  Gap(10),
                  ToppingCard(
                    imagePath: 'assets/sanDetails/bacons.png',
                    name: 'Bacons',
                    onAdd: () {},
                  ),
                ],
              ),
            ),
            Gap(20),
            CustomText(text: '   Side Options', size: 20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ToppingCard(
                    imagePath: 'assets/sideDetails/fries.png',
                    name: 'Fries',
                    onAdd: () {},
                  ),
                  Gap(10),
                  ToppingCard(
                    imagePath: 'assets/sideDetails/coleslaw.png',
                    name: 'Coleslaw',
                    onAdd: () {},
                  ),
                  Gap(10),
                  ToppingCard(
                    imagePath: 'assets/sideDetails/onion.png',
                    name: 'Onion',
                    onAdd: () {},
                  ),
                  Gap(10),
                  ToppingCard(
                    imagePath: 'assets/sideDetails/salad.png',
                    name: 'Salad',
                    onAdd: () {},
                  ),
                  Gap(10),
                ],
              ),
            ),
            Gap(20),
          ],
        ),

      ),
      bottomSheet: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade800,
                blurRadius: 15,
                offset: Offset(0, 0),
              )
            ]
        ),
        height: 120,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(text: 'Total Price', size: 20),
                      CustomText(text: '\$ 18.9', size: 30),
                    ]
                ),
                SizedBox(
                    width: 150,
                    height: 60,
                    child: CustomButton(text: 'Add To Cart',)),
              ]
          ),
        ),
      )
    );
  }
}
