import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hola_academy/core/constants/app_string.dart';
import 'package:hola_academy/core/constants/color_manager.dart';
import 'package:hola_academy/core/constants/image_manager.dart';
import 'package:hola_academy/features/auth/reset_password/UI/reset_password.dart';

import '../../../../core/components/custom_app_button.dart';
import '../../forgot_password/UI/forgot_password_screen.dart';
import 'widgets/custom_text_form_field.dart';
import 'widgets/social_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          _buildBackground(),
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
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 40.h),
                      _buildTitle(AppString.welcomeBack),
                      SizedBox(height: 40.h),
                      // Email Address Field
                      CustomTextFormField(
                        controller: _emailController,
                        label: AppString.emailAddress,
                        hint: AppString.enterYourEmail,
                        prefixIcon: const Icon(Icons.email,
                            color: ColorManager.textRedColor),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Email is required";
                          } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                              .hasMatch(value)) {
                            return "Enter a valid email";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20.h),
                      // Password Field
                      CustomTextFormField(
                        controller: _passwordController,
                        label: AppString.password,
                        hint: AppString.enterYourPassword,
                        prefixIcon: const Icon(Icons.lock_outline,
                            color: ColorManager.textRedColor),
                        suffixIcon: GestureDetector(
                          onTap: () => setState(
                              () => _isPasswordVisible = !_isPasswordVisible),
                          child: Icon(
                            _isPasswordVisible
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: ColorManager.textRedColor,
                          ),
                        ),
                        isPassword: !_isPasswordVisible,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Password is required";
                          } else if (value.length < 6) {
                            return "Password must be at least 6 characters long";
                          }
                          return null;
                        },
                      ),
                      _buildForgotPassword(),
                      SizedBox(height: 15.h),
                      _buildLoginButton(),
                      _buildSignUpPrompt(),
                      SizedBox(height: 15.h),
                      _buildSocialLoginSection(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackground() {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(ImageManager.onBoardingImage3),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildTitle(String title) {
    return Center(
      child: Text(
        title,
        style: TextStyle(
          fontSize: 32.sp,
          fontWeight: FontWeight.w400,
          color: ColorManager.textRedColor,
        ),
      ),
    );
  }

  Widget _buildForgotPassword() {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {
         Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPasswordScreen(),),);
        },
        child: Text(
          AppString.forgotPassword,
          style: TextStyle(
            color: ColorManager.textRedColor,
            fontSize: 14.sp,
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return Center(
      child: CustomAppButton(
        text: AppString.login,
        onPressed: () {
          if (_formKey.currentState?.validate() ?? false) {
            // Handle login logic
             Navigator.push(context, MaterialPageRoute(builder: (context) => ResetPassword(),),);
          }
        },
      ),
    );
  }

  Widget _buildSignUpPrompt() {
    return Center(
      child: TextButton(
        onPressed: () {
          // Navigate to sign-up screen
        },
        child: Text(
          AppString.dontHaveAccount,
          style: TextStyle(
            color: const Color(0xFFE17637),
            fontSize: 14.sp,
          ),
        ),
      ),
    );
  }

  Widget _buildSocialLoginSection() {
    return Column(
      children: [
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
    );
  }
}
