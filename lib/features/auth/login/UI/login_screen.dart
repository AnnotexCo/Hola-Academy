import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hola_academy/core/Routing/routes.dart';
import 'package:hola_academy/core/constants/app_string.dart';
import 'package:hola_academy/core/constants/color_manager.dart';
import 'package:hola_academy/core/constants/image_manager.dart';
import 'package:hola_academy/features/auth/register/UI/register_screen.dart';
import 'package:hola_academy/features/layout/layout_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../forgot_password/UI/forgot_password_screen.dart';
import '../../register/UI/widgets/custom_button.dart';

import '../../../../core/components/general_text_form_field.dart';
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
  final TextEditingController _roleController = TextEditingController();
  bool _isPasswordVisible = false;

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      // Simulate a login process
      String role = _roleController.text;
      String password = _passwordController.text;

      // Check credentials (this is just a mock check)
      if (role == 'admin') {
        // Save user role to SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('userRole', 'admin');

        // Navigate to the home screen
        Navigator.pushReplacementNamed(context, Routes.homeAdminScreen);
      } else if (role == 'user') {
        // Save user role to SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('userRole', 'user');

        // Navigate to the home screen
        Navigator.pushReplacementNamed(context, Routes.layoutScreen);
      } else if (role == 'trainee') {
        // Save user role to SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('userRole', 'trainee');

        // Navigate to the home screen
        Navigator.pushReplacementNamed(context, Routes.layoutScreen);
      }else if (role == 'coach') {
        // Save user role to SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('userRole', 'coach');

        // Navigate to the home screen
        Navigator.pushReplacementNamed(context, Routes.layoutScreen);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Invalid credentials')),
        );
      }
    }
  }

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
                      GeneralTextFormField(
                        controller: _roleController,
                        label: 'Role',
                        hint: 'Enter your role',
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(
                            left: 24.w,
                            right: 33.w,
                            top: 9.h,
                            bottom: 7.h,
                          ),
                          child: Icon(
                            Icons.person,
                            color: ColorManager.textRedColor,
                            size: 24.sp,
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Role is required";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20.h),
                      // Email Address Field
                      GeneralTextFormField(
                        controller: _emailController,
                        label: AppString.emailAddress,
                        hint: AppString.enterYourEmail,
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(
                            left: 24.w,
                            right: 33.w,
                            top: 9.h,
                            bottom: 7.h,
                          ),
                          child: Icon(
                            Icons.email,
                            color: ColorManager.textRedColor,
                            size: 24.sp,
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
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
                      GeneralTextFormField(
                        controller: _passwordController,
                        label: AppString.password,
                        hint: AppString.enterYourPassword,
                        isPassword: !_isPasswordVisible,
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(
                            left: 24.w,
                            right: 33.w,
                            top: 9.h,
                            bottom: 7.h,
                          ),
                          child: Icon(
                            Icons.lock_outline,
                            color: ColorManager.textRedColor,
                            size: 24.sp,
                          ),
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () => setState(
                              () => _isPasswordVisible = !_isPasswordVisible),
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: 24.w,
                              right: 33.w,
                              top: 9.h,
                              bottom: 7.h,
                            ),
                            child: Icon(
                              _isPasswordVisible
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              color: ColorManager.textRedColor,
                              size: 24.sp,
                            ),
                          ),
                        ),
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
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ForgotPasswordScreen(),
            ),
          );
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
      child: CustomButton(
        text: AppString.login,
        onTap: () {
          if (_formKey.currentState?.validate() ?? false) {
            // Handle login logic
            _login();
            /*Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LayoutScreen(),
                ));*/
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
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RegisterScreen(),
              ));
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
            socialButton(ImageManager.googleLogo),
            SizedBox(width: 20.w),
            socialButton(ImageManager.appleLogo),
          ],
        ),
      ],
    );
  }
}
