import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../shared/custom_text.dart';

class CustomAuthBtn extends StatelessWidget {
  const CustomAuthBtn({super.key, this.onTap, required this.text, this.color, this.textColor});
  final Function () ? onTap;
  final String text;
  final Color? color ;
  final Color? textColor ;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ,
      child: Container(
        width: 200,
        height: 50,
        decoration: BoxDecoration(
          border: Border.all(color:Colors.white),
          color: color?? Colors.white,
          borderRadius: BorderRadius.circular(40),
        ),
        child: Center(
          child: CustomText(
            text: text,
            weight: FontWeight.bold,
            color:textColor?? AppColors.primary,
          ),
        ),
      ),
    );
  }
}
