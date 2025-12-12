import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:hungry/features/auth/data/auth_repo.dart';
import 'package:hungry/root.dart';
import 'package:hungry/shared/custom_text.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/network/api_error.dart';
import '../../../shared/custom_textfield.dart';
import '../../../shared/snackBar_custom.dart';
import '../widgets/custom_btn.dart';
import 'login_view.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isLoading = false;
  AuthRepo authRepo = AuthRepo();
  Future<void>signup ()async {
    if (formKey.currentState == null || !formKey.currentState!.validate()) {
      return;
    }
    setState(() {
      isLoading = true;
    });
    try {
      final user = await authRepo.signup(
        nameController.text.trim(),
        emailController.text.trim(),
        passController.text.trim(),
      );
      if (user != null) {
        Navigator.pushReplacement(context,MaterialPageRoute(builder: (c)=>Root()));
      }
      setState(() {
        isLoading = false;
      });
    }
    catch (e) {
      setState(() {
        isLoading = false;
      });
      String errorMsg = 'error in register';
      if (e is ApiError) {
        errorMsg = e.message;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        customSnackBar(errorMsg),
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
                       isLoading ? CupertinoActivityIndicator(color: Colors.white,) :
                       CustomAuthBtn(text: 'Sign Up',onTap: signup),
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
