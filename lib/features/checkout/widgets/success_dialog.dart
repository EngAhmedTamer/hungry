import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../core/constants/app_colors.dart';
import '../../../shared/custom_button.dart';
import '../../../shared/custom_text.dart';

class SuccessDialog extends StatelessWidget {
  const SuccessDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
        backgroundColor: Colors.transparent,
        child: Padding(

          padding: const EdgeInsets.symmetric(horizontal: 20 , vertical: 200),
          child: Container(
              padding: EdgeInsets.all(20),
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
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                        radius: 40,
                        backgroundColor: AppColors.primary,
                        child: Icon(CupertinoIcons.check_mark ,color: Colors.white,size: 50,)
                    ),
                    Gap(10),
                    Center(child: CustomText(text: 'Success',size: 20,color: AppColors.primary,weight: FontWeight.bold,)),
                    Center(child: CustomText(text: 'Your payment was successful.\nA receipt for this purchase has\n       been sent to your email.',size: 14,color: Colors.grey.shade500,)),
                    Gap(50),
                    CustomButton(text: 'Close',width: 200,onTap: ()=>Navigator.pop(context),)



                  ]
              )
          ),
        )
    );
  }
}
