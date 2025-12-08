import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constants/app_colors.dart';
import 'package:hungry/features/cart/widgets/cart_item.dart';

import '../../../shared/custom_button.dart';
import '../../../shared/custom_text.dart';
import '../../checkout/views/checkout_view.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView>
{
  int itemCount = 20;
  late List <int> quantities ;
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            child: Column(
              children: [
                const Gap(30),
                Center(
                  child: Text(
                    "Your Cart",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                const Gap(10),
                Expanded(
                  child: ListView.builder(

                    padding: const EdgeInsets.only(bottom: 200),
                    itemCount: itemCount,
                    itemBuilder: (context, index) {
                      return CardItem(
                        image: 'assets/test/test.png',
                        mainText: 'Cheeseburger',
                        descText: 'Wendy"s burger',
                        quantity: '${quantities[index]}',
                        onAdd: (){
                          add(index);
                        },
                        onMince: (){
                          mince(index);
                        },
                        onRemove: (){
                          remove(index);
                        },
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
            bottom: 100,
            child: Container(
              height: 90,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        CustomText(text: 'Total Price', size: 16,color: Colors.white,),
                        CustomText(text: '\$ 18.9', size: 24,color: Colors.white,),
                      ],
                    ),
                    Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),

                        child: SizedBox(
                            width: 130,
                            height: 45,
                            child: CustomButton(text: 'Checkout',color: Colors.white,onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (c){
                                return CheckoutView();
                              }));
                            },))),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
