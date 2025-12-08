import 'package:flutter/material.dart';

import '../core/constants/app_colors.dart';
import 'custom_text.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.text, this.onTap, this.color});
  final String text ;
  final Function()? onTap ;
  final Color? color ;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
              color: color ?? AppColors.primary,

              borderRadius: BorderRadius.circular(20)
          ),
          child: CustomText(text: text,color: color == null ? Colors.white : Colors.black,)
      ),
    );
  }
}
