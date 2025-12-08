import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constants/app_colors.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Gap(280),
          Center(child: SvgPicture.asset('assets/logo/logo.svg')),
          Spacer(),
          Center(child: Image.asset('assets/splash/splash.png')),
        ],
      ),
    );
  }
}
