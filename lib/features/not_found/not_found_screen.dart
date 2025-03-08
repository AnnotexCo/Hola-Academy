import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hola_academy/core/constants/color_manager.dart';
import 'package:hola_academy/core/constants/image_manager.dart';

class NotFoundScreen extends StatelessWidget {
  final String? svgPath; // Path to the SVG image
  final String? title;
  const NotFoundScreen({this.svgPath, this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 100.h),
            SvgPicture.asset(
              svgPath ?? ImageManager.notFound,
              width: 384.w,
              height: 343.h,
            ),
            SizedBox(height: 8.h),
            Text(
              title ?? '',
              maxLines: 2,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: ColorManager.textRedColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
