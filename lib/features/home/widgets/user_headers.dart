import 'package:flutter/material.dart' ;
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import '../../../core/constants/app_colors.dart';
import '../../../shared/custom_text.dart';

class UserHeaders extends StatelessWidget {
  const UserHeaders({super.key, required this.name, this.image});
  final String name ;
  final String ?image ;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Gap(30),
            Center(
              child: SvgPicture.asset(
                'assets/logo/logo.svg',
                color: AppColors.primary,
                height: 35,
              ),
            ),
            Gap(5),
            CustomText(
              text: 'Hello $name   ',
              color: Colors.grey.shade500,
              weight: FontWeight.w500,
              size: 18,
            ),
          ],
        ),
        Spacer(),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: CircleAvatar(radius: 31,child: Image(image: AssetImage(image!)),),
        ),
      ],
    );
  }
}
