import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hola_academy/core/constants/app_string.dart';
import 'package:hola_academy/features/auth/verification/UI/verfication_screen.dart';

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
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height,
              ),
              child: IntrinsicHeight(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(height: 20.h),
                      _buildBackButton(context),
                      SizedBox(height: 32.h),
                      _buildTitle(),
                      SizedBox(height: 12.h),
                      _buildDescription(),
                      SizedBox(height: 32.h),
                      CustomToggleSwitch(
                        isEmailSelected: isEmailSelected,
                        onToggle: (value) =>
                            setState(() => isEmailSelected = value),
                      ),
                      SizedBox(height: 50.h),
                      CustomTextField(
                        controller: _inputController,
                        label: isEmailSelected
                            ? AppString.enterYourEmail
                            : AppString.enterYourPhoneNumber,
                        hint: isEmailSelected
                            ? '____@gmail.com'
                            : '+20  _ _ _ _ _ _ _ _ _ _',
                        prefix: Icon(
                          isEmailSelected ? Icons.email : Icons.phone,
                          color: ColorManager.textRedColor,
                          size: 30.sp,
                        ),
                        validator: (value) => _validateInput(value),
                      ),
                      const Spacer(),
                      Center(
                        child: CustomAppButton(
                          text: AppString.send,
                          icon: Icons.send,
                          onPressed: _onSubmit,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      _buildBackToSignIn(context),
                      SizedBox(height: 32.h),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: Icon(Icons.arrow_back_ios_new, size: 24.sp),
        color: ColorManager.textRedColor,
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      AppString.forgetPassword,
      style: TextStyle(
        fontSize: 32.sp,
        fontWeight: FontWeight.w600,
        color: ColorManager.textRedColor,
      ),
    );
  }

  Widget _buildDescription() {
    return Text(
      textAlign: TextAlign.center,
      AppString.forgotPasswordDescription,
      style: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        color: ColorManager.textRedColor,
      ),
    );
  }

  Widget _buildBackToSignIn(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () => Navigator.pop(context),
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
    );
  }

  String? _validateInput(String? value) {
    if (value == null || value.isEmpty) {
      return isEmailSelected ? "Email is required" : "Phone number is required";
    }
    if (isEmailSelected) {
      // Validate email format
      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
        return "Enter a valid email";
      }
    } else {
      // Validate phone number format
      if (!RegExp(r'^\+?\d{10,15}$').hasMatch(value)) {
        return "Enter a valid phone number";
      }
    }
    return null;
  }

  void _onSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      // Proceed with the submission
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(isEmailSelected ? "Email sent!" : "SMS sent!")),
      );
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VerificationScreen(),
          ));
    }
  }
}
