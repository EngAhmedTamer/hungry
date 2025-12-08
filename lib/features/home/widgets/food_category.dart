import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../shared/custom_text.dart';

class FoodCategory extends StatefulWidget {
    FoodCategory({super.key, required this.currentIndex, required this.category});
    late  int currentIndex;
    final List category;

    @override
  State<FoodCategory> createState() => _FoodCategoryState();
}

class _FoodCategoryState extends State<FoodCategory> {
  late int currentIndex;
  @override
  void initState() {
    currentIndex = widget.currentIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
          children: List.generate(widget.category.length, (index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  currentIndex = index;
                });
              },
              child: Container(
                margin: EdgeInsets.only(right: 8),
                decoration: BoxDecoration(color:  currentIndex == index
                    ? AppColors.primary
                    :  Color(0xffF3F4F6),borderRadius: BorderRadius.circular(20)),
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 27),
                child: CustomText(text: widget.category[index] ,weight: FontWeight.w600,color: currentIndex == index ? Colors.white : Colors.grey.shade500),

              ),
            );

          }

          )
      ),
    );
  }
}
