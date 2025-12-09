import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:hungry/shared/custom_text.dart';
import '../../../core/constants/app_colors.dart';
import '../../../shared/custom_textfield.dart';
import '../widgets/custom_btn.dart';
import 'login_view.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();


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
                  Center(child: SvgPicture.asset('assets/logo/logo.svg',color: AppColors.primary,)),
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
          
                       Gap(30),
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
                       Gap(30),
                       CustomAuthBtn(text: 'Sign Up',onTap: (){
                         if (formKey.currentState!.validate())
                           print('success register');
                       },),
                       Gap(20),
                       CustomAuthBtn(
                         color: AppColors.primary,
                         textColor: Colors.white,
                         text: 'Go To Login ? ',onTap: (){
                         Navigator.push(context, MaterialPageRoute(builder: (c){
                           return LoginView();
                         }));
                       },),
                     ],
                   ),
                 )
            
                ],
              ),
            ),
          ),
        ),
      ),)
    );
  }
}
class NoScrollUp extends ScrollBehavior {
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const NeverScrollableScrollPhysics().applyTo(_AllowDownScrollPhysics());
  }
}


class _AllowDownScrollPhysics extends ScrollPhysics {
  const _AllowDownScrollPhysics({ScrollPhysics? parent}) : super(parent: parent);

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
