import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hola_academy/core/components/custom_app_button.dart';
import 'package:hola_academy/core/constants/color_manager.dart';

import '../../../../core/components/custom_text_field.dart';
import '../../../../core/constants/app_string.dart';
import '../../verification/UI/widgets/build_back_arrow.dart';
import '../../verification/UI/widgets/build_verfication_message.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                buildBackArrow(context),
                SizedBox(height: 48.h),
                buildTextMessage(AppString.resetPassword, null,null),
                SizedBox(height: 48.h),
                _buildPasswordField(),
                SizedBox(height: 35.h),
                _buildConfirmPasswordField(),
                const Spacer(),
                CustomAppButton(
                  text: AppString.reset,
                  onPressed: _onResetPassword,
                  icon: Icons.restart_alt,
                ),
                SizedBox(height: 32.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField() {
    return CustomTextField(
      controller: _passwordController,
      label: AppString.password,
      hint: AppString.enterYourPassword,
      prefix: Icon(
        Icons.lock,
        color: ColorManager.textRedColor,
      ),
      suffix: GestureDetector(
        onTap: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
        child: Icon(
          _isPasswordVisible
              ? Icons.visibility_outlined
              : Icons.visibility_off_outlined,
          color: ColorManager.textRedColor,
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Password is required";
        } else if (value.length < 8) {
          return "Password must be at least 8 characters long";
        }
        return null;
      },
    );
  }

  Widget _buildConfirmPasswordField() {
    return CustomTextField(
      controller: _confirmPasswordController,
      label: AppString.confirmPassword,
      hint: AppString.enterYourPassword,
      prefix: Icon(
        Icons.lock,
        color: ColorManager.textRedColor,
      ),
      suffix: GestureDetector(
        onTap: () =>
            setState(() => _isConfirmPasswordVisible = !_isConfirmPasswordVisible),
        child: Icon(
          _isConfirmPasswordVisible
              ? Icons.visibility_outlined
              : Icons.visibility_off_outlined,
          color: ColorManager.textRedColor,
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Confirm password is required";
        } else if (value != _passwordController.text) {
          return "Passwords do not match";
        }
        return null;
      },
    );
  }

  void _onResetPassword() {
    if (_formKey.currentState?.validate() ?? false) {
      // Proceed with reset password logic
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Password reset successful!")),
      );
    }
  }
}
