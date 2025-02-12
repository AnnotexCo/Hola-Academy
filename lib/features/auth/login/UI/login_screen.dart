import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:hola_academy/core/Routing/routes.dart';
import 'package:hola_academy/core/constants/app_string.dart';
import 'package:hola_academy/core/constants/color_manager.dart';
import 'package:hola_academy/core/constants/image_manager.dart';

import '../../register/UI/widgets/custom_button.dart';

import '../../../../core/components/general_text_form_field.dart';
import '../Data/Model/login_model.dart';
import '../Logic/login_cubit.dart';
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
  Future<void> _handleGoogleSignIn() async {
    final loginCubit = context.read<LoginCubit>();
    await loginCubit.doGoogleLogin();
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
                  child: BlocConsumer<LoginCubit, LoginState>(
                      listener: (context, state) async {
                    if (state is LoginSuccess) {
                      String role = state.role.trim().toUpperCase();
                      if (role == 'ADMIN') {
                        Navigator.pushReplacementNamed(
                            context, Routes.adminLayout);
                      } else if (role == 'USER' ||
                          role == 'PREUSER' ||
                          role == 'TRAINEE') {
                        Navigator.pushReplacementNamed(
                            context, Routes.layoutScreen);
                      } else if (role == 'COACH') {
                        Navigator.pushReplacementNamed(
                            context, Routes.layoutCoachScreen);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Invalid role: $role')),
                        );
                      }
                    } else if (state is LoginFailure) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.message)),
                      );
                    }
                  }, builder: (context, state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 40.h),
                        _buildTitle(AppString.welcomeBack),
                        SizedBox(height: 40.h),

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
                        _buildLoginButton(state),
                        _buildSignUpPrompt(),
                        SizedBox(height: 15.h),
                        _buildSocialLoginSection(),
                      ],
                    );
                  }),
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
          Navigator.pushNamed(context, Routes.forgotPassword);
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

  Widget _buildLoginButton(LoginState state) {
    return Center(
      child: CustomButton(
        text: AppString.login,
        onTap: () {
          if (_formKey.currentState?.validate() ?? false) {
            context.read<LoginCubit>().doLogin(
                  LoginModel(
                    email: _emailController.text.trim(),
                    password: _passwordController.text.trim(),
                  ),
                );
          }
        },
        isLoading: state is LoginLoading, // Show loading indicator
      ),
    );
  }

  Widget _buildSignUpPrompt() {
    return Center(
      child: TextButton(
        onPressed: () {
          // Navigate to sign-up screen
          Navigator.pushNamed(context, Routes.registerScreen);
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
            socialButton(ImageManager.googleLogo, _handleGoogleSignIn),
            SizedBox(width: 20.w),
            socialButton(ImageManager.appleLogo, () {}),
          ],
        ),
      ],
    );
  }
}
