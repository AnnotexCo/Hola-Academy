import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/color_manager.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final Widget? prefix;
  final Widget? suffix;
  final String label;

  const CustomTextField({
    super.key,
    required this.hint,
    this.prefix,
    this.suffix,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 8.w, bottom: 15.h),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 19.sp,
              color: ColorManager.textRedColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Container(
          width: 382.w,
          height: 60.h,
          decoration: BoxDecoration(
            color: ColorManager.backgroundPinkColor,
          ),
          child: TextFormField(
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                color: ColorManager.textRedColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
              ),
              prefixIcon: prefix,
              prefixStyle: TextStyle(
                color: ColorManager.textRedColor,
                fontSize: 29.sp,
              ),
              suffixIcon: suffix,
              suffixStyle: TextStyle(
                color: ColorManager.textRedColor,
                fontSize: 29.sp,
              ),
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
            ),
          ),
        ),
      ],
    );
  }
}
