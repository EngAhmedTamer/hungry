import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry/features/auth/data/auth_repo.dart';
import 'package:hungry/features/auth/data/user_model.dart';
import 'package:hungry/features/auth/widgets/custom_user_text_field.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/network/api_error.dart';
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
    UserModel? userModel ;


 AuthRepo authRepo = AuthRepo();
Future<void>getProfileData()async {
  try{
    final user = await authRepo.getProfileData();
    setState(() {
      userModel =user ;
    });

  }catch(e){
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
  getProfileData().then((v){
    nameController.text = userModel?.name ??'user name';
    emailController.text = userModel?.email??'email';
    addressController.text = userModel?.address??'address';
  });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(Icons.arrow_back, color: Colors.white, size: 25),
        ),
        actions: [
          GestureDetector(
            onTap: () {

            },
            child: Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Icon(Icons.settings, size: 35, color: Colors.white),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Skeletonizer(
            enabled: userModel == null,
            child: Column(
              children: [
                Center(
                  child: Container(
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 2),
                      shape: BoxShape.circle,
                      image:
                          userModel?.image != null && userModel!.image!.isNotEmpty?
                      DecorationImage(
                        image: NetworkImage(userModel!.image!),
                      ):null,
                    ),
                  ),
                ),
                Gap(20),
                CustomUserTextField(controller: nameController, labelText: 'name'),
                Gap(20),
                CustomUserTextField(controller: emailController, labelText: 'email'),
                Gap(20),
                CustomUserTextField(controller: addressController, labelText: 'address'),
                Gap(20),
                Divider(color: Colors.white, thickness: 2),
                Gap(20),
                ListTile(
                    contentPadding: EdgeInsets.symmetric(vertical: 2,horizontal: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    tileColor: Colors.white,
                    leading: Image.asset('assets/icons/visablack.png',width: 50,),
                    title: CustomText(text:' Debit Card',color: Colors.black,),
                    subtitle:CustomText(text:userModel?.visa?.toString()??' **** ***** 1974',color: Colors.black,) ,
            
                    trailing: CustomText(text: 'Default',color: Colors.black,)
                ),
              ],
            ),
          ),
        ),
      ),
        bottomNavigationBar:
        Padding(
          padding: EdgeInsets.only(

            bottom: 100 ,
            top: 1,
          ),
          child: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white,
            ),
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

                Directionality(
                  textDirection: TextDirection.rtl,
                  child: ElevatedButton.icon(
                    onPressed: () {

                    },
                    icon: Icon(CupertinoIcons.pencil, color: Colors.white),
                    label: Text('Edit Profile', style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),

                Directionality(
                  textDirection: TextDirection.rtl,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (c){
                        return SplashView();
                      }));
                    },
                    label: Text('Log Out', style: TextStyle(color: AppColors.primary)),
                    icon: Icon(CupertinoIcons.arrow_right_circle, color: AppColors.primary),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: AppColors.primary,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )

    );
  }
}
