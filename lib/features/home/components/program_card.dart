import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hola_academy/core/constants/image_manager.dart';

class ProgramCard extends StatelessWidget {
  final double? height;
  final double? width;
  final Color? color;
  final String? text;
  final Color? backgroundColor;
  const ProgramCard(
      {super.key,
      this.height,
      this.width,
      this.color,
      this.text,
      this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: height ?? 176.h,
          width: width ?? 174.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22.r),
          ),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(22.r),
              child: Image.asset(ImageManager.programImage, fit: BoxFit.cover)),
        ),
        Positioned(
            top: 8.h,
            right: 35.w,
            left: 35.w,
            child: Container(
              width: 104.w,
              height: 25.h,
              decoration: BoxDecoration(
                color:
                    backgroundColor ?? Color(0xfef5e9cc).withValues(alpha: 0.8),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Center(
                child: Text(
                  text ?? "Beginner",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: color ?? Color(0xffF09C1F),
                  ),
                ),
              ),
            ))
      ],
    );
  }
}
