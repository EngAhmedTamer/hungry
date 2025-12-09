import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../core/constants/app_colors.dart';
import '../../../shared/custom_text.dart';

class CardItem extends StatefulWidget {
  const CardItem({super.key, required this.image, required this.mainText, required this.descText, required this.quantity, this.onAdd, this.onMince, this.onRemove});
  final String image ;
  final String mainText ;
  final String descText ;
  final String quantity ;
  final Function ()? onAdd;
  final Function ()? onMince;
  final Function ()? onRemove;

  @override
  State<CardItem> createState() => _CardItemState();
}
class _CardItemState extends State<CardItem> {

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(widget.image, width: 90),
              CustomText(text: widget.mainText, size: 20),
              CustomText(text: widget.descText, size: 15),
            ],
          ),
          Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: widget.onAdd,
                    child: CircleAvatar(
                      backgroundColor: AppColors.primary,
                      child: Icon(
                        CupertinoIcons.add,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Gap(20),
                  CustomText(text: widget.quantity, size: 20,weight: FontWeight.w400,),
                  Gap(20),
                  GestureDetector(
                    onTap: widget.onMince,
                    child: CircleAvatar(
                      backgroundColor: AppColors.primary,
                      child: Icon(
                        CupertinoIcons.minus,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              Gap(10),
              GestureDetector(
                onTap: widget.onRemove,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: AppColors.primary,
                  ),
                  width: 100,
                  height: 45,
                  child: Center(child: CustomText(text: 'remove',color: Colors.white,)),
                ),
              ),
            ],

          ),
          Gap(1),
        ],
      ),
    );
  }
}
