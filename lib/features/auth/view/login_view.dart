import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constants/app_colors.dart';
import 'package:hungry/shared/custom_text.dart';
import 'package:hungry/shared/custom_textfield.dart';

import '../widgets/custom_btn.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Gap(100),
                Center(child: SvgPicture.asset('assets/logo/logo.svg')),
                Gap(10),
                CustomText(
                  text: "Welcome Back , Discover The Fast food ",
                  color: Colors.white,
                  size: 13,
                  weight: FontWeight.w500,
                ),
                Gap(60),
                CustomTextfield(
                  hint: 'Email Address',
                  isPassword: false,
                  controller: emailController,
                ),
                Gap(20),
                CustomTextfield(
                  hint: 'Password',
                  isPassword: true,
                  controller: passwordController,
                ),
                Gap(30),
                CustomAuthBtn(text: 'login',onTap: () {
                  if (formKey.currentState!.validate())
                    print('success login');
                },)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
