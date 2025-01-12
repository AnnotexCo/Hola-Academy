import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hola_academy/core/constants/app_string.dart';

import '../../../../core/components/custom_app_button.dart';
import '../../../../core/components/custom_text_field.dart';
import '../../../../core/constants/color_manager.dart';
import 'widgets/custom_toggle_switch.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  bool isEmailSelected = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 20.h),
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.arrow_back_ios_new, size: 24.sp),
                    color: ColorManager.textRedColor,
                  ),
                ),
                SizedBox(height: 32.h),
                Text(
                  AppString.forgetPassword,
                  style: TextStyle(
                    fontSize: 32.sp,
                    fontWeight: FontWeight.w600,
                    color: ColorManager.textRedColor,
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  textAlign: TextAlign.center,
                  AppString.forgotPasswordDescription,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: ColorManager.textRedColor,
                  ),
                ),
                SizedBox(height: 32.h),
                CustomToggleSwitch(
                  isEmailSelected: isEmailSelected,
                  onToggle: (value) => setState(() => isEmailSelected = value),
                ),
                SizedBox(height: 50.h),
                CustomTextField(
                  label: isEmailSelected
                      ? AppString.enterYourEmail
                      : AppString.enterYourPhoneNumber,
                  hint: isEmailSelected
                      ? '  ____@gmail.com'
                      : '+20  _ _ _ _ _ _ _ _ _ _',
                  prefix: Icon(
                    isEmailSelected ? Icons.email : Icons.phone,
                    color: ColorManager.textRedColor,
                    size: 30.sp,
                  ),
                ),
                const Spacer(),
                Center(
                  child: CustomAppButton(
                    text: AppString.send,
                    icon: Icons.send,
                    onPressed: () {},
                  ),
                ),
                SizedBox(height: 16.h),
                Center(
                  child: TextButton(
                    onPressed: () {},
                    child: RichText(
                      text: TextSpan(
                        text: AppString.backToSignIn,
                        style: TextStyle(
                          color: ColorManager.textRedColor.withOpacity(0.7),
                          fontSize: 14.sp,
                        ),
                        children: [
                          TextSpan(
                            text: AppString.signIn,
                            style: TextStyle(
                              color: ColorManager.textRedColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 32.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


