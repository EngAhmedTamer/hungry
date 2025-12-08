import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import '../../../core/constants/app_colors.dart';
import '../../../shared/custom_text.dart';
import '../../../shared/custom_textfield.dart';
import '../widgets/custom_btn.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passController = TextEditingController();
    TextEditingController confirmPassController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();


    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Gap(100),
                  Center(child: SvgPicture.asset('assets/logo.svg')),
                  Gap(10),
                  Gap(60),
                  CustomTextfield(
                    hint: 'Name ',
                    isPassword: false,
                    controller: nameController,
                  ),
                  Gap(20),
                  CustomTextfield(
                    hint: 'Email Address',
                    isPassword: false,
                    controller: emailController,
                  ),
                  Gap(20),
                  CustomTextfield(
                    hint: 'Password',
                    isPassword: true,
                    controller: passController,
                  ),
                  Gap(20),
                  CustomTextfield(
                    hint: 'Confirm Password',
                    isPassword: true,
                    controller: confirmPassController,),
                  Gap(30),
                  CustomAuthBtn(text: 'Sign Up',onTap: (){
                    if (formKey.currentState!.validate())
                      print('success register');
                  },)
              
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
