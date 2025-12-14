import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hungry/core/widgets/glassmorphic_container.dart';
import 'package:hungry/features/auth/data/auth_repo.dart';
import 'package:hungry/features/auth/data/user_model.dart';
import 'package:hungry/features/auth/widgets/custom_user_text_field.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/network/api_error.dart';
import '../../../root.dart';
import '../../../shared/custom_button.dart';
import '../../../shared/custom_text.dart';
import '../../../shared/snackBar_custom.dart';
import '../../../splash_screen.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController visaController = TextEditingController();
  UserModel? userModel;

  AuthRepo authRepo = AuthRepo();

  Future<void> getProfileData() async {
    try {
      final user = await authRepo.getProfileData();
      setState(() {
        userModel = user;
      });
    } catch (e) {
      String errorMsg = 'error in profile';
      if (e is ApiError) {
        errorMsg = e.message;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        customSnackBar(errorMsg),
      );
    }
  }

  @override
  void initState() {
    getProfileData().then((v) {
      nameController.text = userModel?.name ?? 'user name';
      emailController.text = userModel?.email ?? 'email';
      addressController.text = userModel?.address ?? 'address';
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;

    return RefreshIndicator(
      onRefresh: () async {
        await getProfileData();
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: isDark ? colorScheme.background : colorScheme.background,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: GestureDetector(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (c) => Root())),
              child: GlassmorphicContainer(
                borderRadius: BorderRadius.circular(12),
                padding: const EdgeInsets.all(8),
                child: Icon(
                  Icons.arrow_back,
                  color: isDark ? Colors.white : Colors.black87,
                  size: 20,
                ),
              ),
            ),
            actions: [
              GestureDetector(
                onTap: () {
                  // Settings logic
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: GlassmorphicContainer(
                    borderRadius: BorderRadius.circular(12),
                    padding: const EdgeInsets.all(8),
                    child: Icon(
                      Icons.settings,
                      size: 24,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Skeletonizer(
                enabled: userModel == null,
                child: Column(
                  children: [
                    const Gap(20),
                    Center(
                      child: GlassmorphicContainer(
                        borderRadius: BorderRadius.circular(70),
                        padding: const EdgeInsets.all(6),
                        child: Container(
                          height: 120,
                          width: 120,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: userModel?.image != null &&
                                    userModel!.image!.isNotEmpty
                                ? DecorationImage(
                                    image: NetworkImage(userModel!.image!),
                                    fit: BoxFit.cover,
                                  )
                                : null,
                          ),
                          child: userModel?.image == null ||
                                  userModel!.image!.isEmpty
                              ? Icon(
                                  Icons.person,
                                  size: 60,
                                  color: colorScheme.primary,
                                )
                              : null,
                        ),
                      ),
                    ),
                    const Gap(30),
                    CustomUserTextField(
                      controller: nameController,
                      labelText: 'name',
                    ),
                    const Gap(20),
                    CustomUserTextField(
                      controller: emailController,
                      labelText: 'email',
                      textInputType: TextInputType.emailAddress,
                    ),
                    const Gap(20),
                    CustomUserTextField(
                      controller: addressController,
                      labelText: 'address',
                    ),
                    const Gap(20),
                    GlassmorphicContainer(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      borderRadius: BorderRadius.circular(16),
                      child: Divider(
                        color: isDark
                            ? Colors.white.withOpacity(0.1)
                            : Colors.black.withOpacity(0.1),
                        thickness: 1,
                      ),
                    ),
                    const Gap(20),
                    userModel?.visa == null
                        ? CustomUserTextField(
                            controller: visaController,
                            labelText: 'VISA',
                            textInputType: TextInputType.number,
                          )
                        : GlassmorphicContainer(
                            padding: const EdgeInsets.symmetric(
                              vertical: 2,
                              horizontal: 16,
                            ),
                            borderRadius: BorderRadius.circular(16),
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 2,
                                horizontal: 16,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              leading: Image.asset(
                                'assets/icons/visablack.png',
                                width: 50,
                              ),
                              title: CustomText(
                                text: ' Debit Card',
                                color: isDark ? Colors.white : Colors.black87,
                              ),
                              subtitle: CustomText(
                                text: userModel?.visa?.toString() ??
                                    ' **** ***** 1974',
                                color: isDark ? Colors.white70 : Colors.black54,
                              ),
                              trailing: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      colorScheme.primary,
                                      colorScheme.secondary,
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: CustomText(
                                  text: 'Default',
                                  color: Colors.white,
                                  size: 12,
                                  weight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                    const Gap(100),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(
              bottom: 20,
              top: 1,
              left: 20,
              right: 20,
            ),
            child: GlassmorphicContainer(
              padding: const EdgeInsets.all(12),
              borderRadius: BorderRadius.circular(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: CustomButton(
                      text: 'Edit Profile',
                      onTap: () {
                        // Edit profile logic
                      },
                    ),
                  ),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: CustomButton(
                      text: 'Log Out',
                      color: isDark
                          ? colorScheme.surface
                          : Colors.white,
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (c) {
                              return SplashView();
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
