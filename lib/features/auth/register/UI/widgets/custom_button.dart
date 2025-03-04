import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hola_academy/core/constants/color_manager.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final bool isLoading;
  final double? height;
  const CustomButton({super.key, required this.onTap, required this.text, this.isLoading = false, this.height});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: Padding(
        padding: EdgeInsets.only(top: 5.h, bottom: 4.h),
        child: Container(
          width: 203.w,
          height: height ?? 40.h,
          decoration: BoxDecoration(
            color: ColorManager.primaryOrangeColor,
            borderRadius: BorderRadius.circular(32.r),
          ),
          child: Center(
              child: Text(
            text,
            style: TextStyle(
              color: ColorManager.whiteColor,
              fontSize: 24.sp,
              fontWeight: FontWeight.w400,
            ),
          )),
        ),
      ),
    );
  }
}
