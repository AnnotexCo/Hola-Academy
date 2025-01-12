import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hola_academy/core/constants/app_string.dart';
import 'package:hola_academy/core/constants/color_manager.dart';
import 'package:hola_academy/core/constants/image_manager.dart';

import 'widgets/custom_text_form_field.dart';
import 'widgets/social_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(ImageManager.onBoardingImage3),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // White Container
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 0.65.sh,
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              decoration: BoxDecoration(
                color: ColorManager.whiteColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.r),
                  topRight: Radius.circular(30.r),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 40.h),
                    Center(
                      // welcome Back
                      child: Text(
                        AppString.welcomeBack,
                        style: TextStyle(
                          fontSize: 32.sp,
                          fontWeight: FontWeight.w400,
                          color: ColorManager.textRedColor,
                        ),
                      ),
                    ),
                    SizedBox(height: 40.h),
                    // Email Address
                    CustomTextFormField(
                      label: AppString.emailAddress,
                      hint: AppString.enterYourEmail,
                      prefixIcon: Icons.email,
                    ),
                    SizedBox(height: 20.h),
                    // Password
                    CustomTextFormField(
                      label: AppString.password,
                      hint: AppString.enterYourPassword,
                      prefixIcon: Icons.lock_outline,
                      suffixIcon: Icons.visibility_outlined,
                      isPassword: true,
                    ),
                    // forgot Password
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          AppString.forgotPassword,
                          style: TextStyle(
                            color: ColorManager.textRedColor,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15.h),
                    // Login Button
                    Center(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFE17637),
                          minimumSize: Size(203.w, 45.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.r),
                          ),
                        ),
                        child: Text(
                          AppString.login,
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w400,
                            color: ColorManager.whiteColor,
                          ),
                        ),
                      ),
                    ),
                    // Don't have an account
                    Center(
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          AppString.dontHaveAccount,
                          style: TextStyle(
                            color: const Color(0xFFE17637),
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15.h),
                    // Or Continue with
                    Center(
                      child: Text(
                        AppString.orContinueWith,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    SizedBox(height: 15.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        socialButton(Icons.g_mobiledata),
                        SizedBox(width: 20.w),
                        socialButton(Icons.apple),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
