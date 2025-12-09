import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constants/app_colors.dart';
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
  late String selectedMethod = 'Cash';

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
        child: SingleChildScrollView(
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
              Gap(15),

              ListTile(
                onTap: ()=>setState(() =>selectedMethod = 'Cash'),
                contentPadding: EdgeInsets.symmetric(vertical: 8,horizontal: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                tileColor: Color(0xff3C2F2F),
                leading: Image.asset('assets/icons/dollar.png',width: 50,),
                title: CustomText(text:'Cash on Delivery',color: Colors.white,),
                trailing: Radio<String>(
                  activeColor: Colors.white,
                  value: 'Cash',
                  groupValue: selectedMethod ,
                    onChanged: (v)=>setState(() =>selectedMethod = v!)
                )
              ),
              Gap(15),
              ListTile(
                onTap: ()=>setState(() =>selectedMethod = 'Visa'),
                contentPadding: EdgeInsets.symmetric(vertical: 2,horizontal: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                tileColor: Colors.blue.shade900,
                leading: Image.asset('assets/icons/visablack.png',width: 50,),
                title: CustomText(text:' Debit Card',color: Colors.white,),
                subtitle:CustomText(text:' **** ***** 1974',color: Colors.white,) ,
                trailing: Radio<String>(
                  activeColor: Colors.white,
                  value: 'Visa',
                  groupValue: selectedMethod ,
                  onChanged: (v)=>setState(() =>selectedMethod = v!),
                )
              ),
              Gap(5),
              Row(
                children: [
                  Checkbox(
                      activeColor: Color(0xffEF2A39),
                      value: true, onChanged: (v){}),
                  CustomText(text: 'Save card details for future payments')
                ],
              )


            ],
          ),
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
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                    width: 130,
                    height: 60,
                    child: CustomButton(text: 'Pay Now',onTap: (){
                      showDialog(context: context, builder: (c){
                        return SuccessDialog()
                          ;
                      }
                      );
                    },)
                ),

              ]
          ),
        ),

      ),
    );
  }
}
