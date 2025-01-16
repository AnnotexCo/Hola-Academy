import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/color_manager.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final Widget? prefix;
  final Widget? suffix;
  final String label;
  final Color? labelColor;
  final bool? isFill;
  final String? Function(String?)? validator;
  final TextEditingController? controller;

  const CustomTextField({
    super.key,
    required this.hint,
    this.prefix,
    this.suffix,
    this.isFill = true,
    required this.label,
    this.labelColor,
    this.validator,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: 8.w,
            bottom: 8.h,
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 19.sp,
              color: labelColor ?? ColorManager.textRedColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        TextFormField(
          controller: controller,
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
              fontWeight: FontWeight.w400,
            ),
            prefixIcon: prefix,
            suffixIcon: suffix,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: ColorManager.textRedColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: ColorManager.textRedColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: ColorManager.textRedColor),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 20.h,
            ),
            fillColor: ColorManager.backgroundPinkColor,
            filled: isFill,
          ),
          validator: validator,
        ),
      ],
    );
  }
}
