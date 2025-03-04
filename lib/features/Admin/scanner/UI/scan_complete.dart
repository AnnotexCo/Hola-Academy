import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hola_academy/core/constants/app_string.dart';
import 'package:hola_academy/core/constants/color_manager.dart';
import 'package:hola_academy/core/constants/image_manager.dart';

class ScanComplete extends StatelessWidget {
  const ScanComplete({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 100.h),
            Opacity(
              opacity: 1.0,
              child: SvgPicture.asset(
                ImageManager.confirmedAttendance,
                width: 384.w,
                height: 343.h,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              AppString.scanComplete,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: ColorManager.textRedColor,
              ),
            ),
            SizedBox(height: 18.h),
            Text(
              AppString.dataRecorded,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: ColorManager.graycolorHeadline,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
