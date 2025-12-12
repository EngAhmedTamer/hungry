import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constants/app_colors.dart';
import 'package:hungry/features/auth/view/signup_view.dart';
import 'package:hungry/root.dart';
import 'package:hungry/shared/custom_text.dart';
import 'package:hungry/shared/custom_textfield.dart';

import '../../../core/network/api_error.dart';
import '../data/auth_repo.dart';
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
  bool isLoading = false;
  AuthRepo authRepo = AuthRepo();

  Future<void> login ()async {
    if (formKey.currentState == null || !formKey.currentState!.validate()){
      return;
    }
    setState(() {
      isLoading = true;
    });

    try {
      final user = await authRepo.login(emailController.text.trim(), passwordController.text.trim());
      if (user != null) {
        Navigator.push(context,MaterialPageRoute(builder: (c)=>Root()));
      }
      setState(() {
        isLoading = false;
      });
    }
    catch (e) {
      setState(() {
        isLoading = false;
      });
      String errorMsg = 'unknown error';
      if (e is ApiError) {
        errorMsg = e.message;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red.shade900,
          behavior: SnackBarBehavior.floating ,
          clipBehavior: Clip.none,
          content: Row(
            children: [
              Icon(CupertinoIcons.exclamationmark_circle,color: Colors.white,),
              Gap(10),
              CustomText(text: errorMsg,color: Colors.white,size: 14,weight:FontWeight.bold ,),
            ],
          )
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: Center(
        child: ScrollConfiguration(
          behavior: NoScrollUp(),
          child: SingleChildScrollView(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Gap(180),
                    Center(
                      child: SvgPicture.asset(
                        'assets/logo/logo.svg',
                        color: AppColors.primary,
                      ),
                    ),
                    CustomText(text: 'Welcome to Our Food App'),
                    Gap(10),
                    Gap(60),

                    Container(
                      width: double.infinity,
                      height: 1000,
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30),
                        ),
                      ),
                      child: Column(
                        children: [
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
                            controller: passwordController,
                          ),
                          Gap(30),
                          isLoading ? CupertinoActivityIndicator(color: Colors.white,) :
                          CustomAuthBtn(
                            text: 'login',
                            onTap: login
                          ),
                          Gap(20),
                          CustomAuthBtn(
                            color: AppColors.primary,
                            textColor: Colors.white,
                            text: 'Go To Signup ? ',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (c) {
                                    return SignupView();
                                  },
                                ),
                              );
                            },
                          ),
                          Gap(20),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (c) {
                                    return Root();
                                  },
                                ),
                              );
                            },
                            child: CustomText(
                              text: 'Continue as a guest',
                              color: Colors.orange,
                              weight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class NoScrollUp extends ScrollBehavior {
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const NeverScrollableScrollPhysics().applyTo(
      _AllowDownScrollPhysics(),
    );
  }
}

class _AllowDownScrollPhysics extends ScrollPhysics {
  const _AllowDownScrollPhysics({ScrollPhysics? parent})
    : super(parent: parent);

  @override
  _AllowDownScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return _AllowDownScrollPhysics(parent: buildParent(ancestor));
  }

  @override
  double applyPhysicsToUserOffset(ScrollMetrics position, double offset) {
    if (offset < 0) return 0;
    return offset;
  }
}
