 import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry/shared/custom_button.dart';

import '../../../core/constants/app_colors.dart';
import '../../../shared/custom_text.dart';

class OrderHistoryView extends StatelessWidget {
   const OrderHistoryView({super.key});

   @override
   Widget build(BuildContext context) {
     return Scaffold(
       body: Center(
         child: Padding(
           padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
           child: Column(
             children: [
               const Gap(30),
               Center(
                 child: Text(
                   "Your History Order",
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
                   itemCount:9 ,
                   itemBuilder: (context, index) {
                     return
                       Card(
                         color: Colors.white,
                         child:Padding(
                           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                           child: Column(
                             children: [
                               Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 children: [
                                   Column(
                                     crossAxisAlignment: CrossAxisAlignment.center,
                                     children: [
                                       Image.asset('assets/test/test.png', width: 90),
                                       CustomText( size: 20, text: 'Cheeseburger',),
                                       CustomText(text: 'Wendy"s burger', size: 15),
                                     ],
                                   ),
                                   Column(
                                     children: [
                                       CustomText(text: 'Hamburger',weight: FontWeight.bold,),
                                       CustomText(text: 'Qty : 3'),
                                       CustomText(text: 'Price : \$ 18.9',weight: FontWeight.bold,),

                               ]
                                   )
                                 ],
                               ),
                               Gap(20),
                               CustomButton(text: 'Order Again',width: double.infinity,color: Colors.grey,)
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
