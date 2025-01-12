
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constants/color_manager.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String hint;
  final IconData prefixIcon;
  final IconData? suffixIcon;
  final bool isPassword;

  const CustomTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.prefixIcon,
    this.suffixIcon,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
        TextField(
          obscureText: isPassword,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: ColorManager.textRedColor,
              fontSize: 16.sp,
            ),
            prefixIcon: Icon(
              prefixIcon,
              color: ColorManager.textRedColor,
              size: 22.sp,
            ),
            suffixIcon: suffixIcon != null
                ? Icon(
                    suffixIcon,
                    color: ColorManager.textRedColor,
                    size: 22.sp,
                  )
                : null,
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
        ),
      ],
    );
  }
}