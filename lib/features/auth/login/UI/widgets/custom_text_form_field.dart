import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constants/color_manager.dart';

class CustomTextFormField extends StatelessWidget {
  final String label;
  final String hint;
  final Widget prefixIcon;
  final Widget? suffixIcon;
  final bool isPassword;
  final String? Function(String?)? validator; // Validator for form validation
  final TextEditingController? controller; // Controller for field value

  const CustomTextFormField({
    super.key,
    required this.label,
    required this.hint,
    required this.prefixIcon,
    this.suffixIcon,
    this.isPassword = false,
    this.validator,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        Padding(
          padding: EdgeInsets.only(left: 8.w, bottom: 8.h),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 16.sp,
              color: ColorManager.textRedColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        // Input Field
        TextFormField(
          controller: controller, // Bind controller
          obscureText: isPassword,// Toggle visibility for passwords
            style: TextStyle(
              color: ColorManager.textRedColor,
              fontSize: 18.sp,
              fontWeight: FontWeight.w400,
            ), 
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: ColorManager.textRedColor,
              fontSize: 16.sp,
            ),
            
            prefixIcon: prefixIcon, // Use Widget directly
            suffixIcon: suffixIcon, // Use Widget directly
            filled: true,
            fillColor: ColorManager.backgroundPinkColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.r),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.symmetric(
              vertical: 15.h,
              horizontal: 20.w,
            ),
          ),
          validator: validator, // Use validator for field validation
        ),
      ],
    );
  }
}
